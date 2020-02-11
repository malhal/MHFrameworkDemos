//
//  DetailViewController.m
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 16/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "DetailViewController.h"

NSString * const DetailViewControllerStateRestorationDetailItemKey = @"DetailViewControllerStateRestorationDetailItemKey";

@interface DetailViewController ()

@property (copy, nonatomic) NSString *defaultText;

@end

@implementation DetailViewController

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)configureView {
    // Update the user interface for the detail item.
    self.trashButton.enabled = self.detailItem;
    self.deleteVenueButton.enabled = self.detailItem;
    if(self.detailItem){
        self.detailDescriptionLabel.text = self.detailItem.timestamp.description;
        //self.navigationController.mui_detailItem = self.detailItem;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.deleteVenueButton.enabled = NO;
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    //self.detailItem = self.splitViewController.mui_containedDetailItem;
    self.defaultText = self.detailDescriptionLabel.text;
    self.navigationItem.leftItemsSupplementBackButton = YES;
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //[self configureView];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(managedObjectContextObjectsDidChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.detailItem.managedObjectContext];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    id i = self.parentViewController.view.window;
    self.navigationItem.leftBarButtonItem = nil;
//    if(self.isTrashed){
//        [self.delegate detailViewControllerDidDelete:self];
//    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!self.detailItem){
        
        //[self performSegueWithIdentifier:@"unwindToMaster" sender:self];
    }
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(Event *)detailItem {
    if (_detailItem == detailItem) {
        return;
    }
    _detailItem = detailItem;
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(deleteObject:) name:@"TestViewControllerButtonTapped" object:nil];

    // Update the view.
    //if(self.mui_isViewVisible){
    if(self.isViewLoaded){
        [self configureView];
    }
}

- (id)mui_containedDetailItem{
    return self.detailItem;
}

- (void)managedObjectContextObjectsDidChange:(NSNotification *)notification{
//    if(!self.viewIfLoaded.window){
//        return;
//    }
    NSMutableSet *set = [NSMutableSet set];
    NSSet *updatedObjects = notification.userInfo[NSUpdatedObjectsKey];
    if(updatedObjects){
        [set unionSet:updatedObjects];
    }
    NSSet *deletedObjects = notification.userInfo[NSDeletedObjectsKey];
    if(deletedObjects){
        [set unionSet:deletedObjects];
    }
    if([set containsObject:self.detailItem]){
        [self configureView];
    }
}

- (IBAction)deleteEvent:(id)sender{
    NSManagedObjectContext *context = self.detailItem.managedObjectContext;
     [context deleteObject:self.detailItem];
     NSError *error = nil;
     if (![context save:&error]) {
         // Replace this implementation with code to handle the error appropriately.
         // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         NSLog(@"Unresolved error %@, %@", error, error.userInfo);
         abort();
     }
    //self.isTrashed = YES;
    //[self.navigationController.navigationController popViewControllerAnimated:YES];
   // [self performSegueWithIdentifier:@"unwind" sender:self];
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//
//    }];
}

- (IBAction)deleteVenue:(id)sender{
    // [self performSegueWithIdentifier:@"deleteVenue" sender:self];
    NSManagedObjectContext *context = self.detailItem.managedObjectContext;
    [context deleteObject:self.detailItem.venue];

    NSError *error = nil;
     if (![context save:&error]) {
         // Replace this implementation with code to handle the error appropriately.
         // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         NSLog(@"Unresolved error %@, %@", error, error.userInfo);
         abort();
     }
}

#pragma mark - UIStateRestoration

#define kTextKey @"Text"
#define kDetailLabelText @"DetailLabelText"

//#define kModelIdentifierForSelectedElementKey @"ModelIdentifierForSelectedElement"
//#define kSelectedMasterObjectKey @"kSelectedMasterObjectKey"

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject:self.detailItem.objectID.URIRepresentation forKey:DetailViewControllerStateRestorationDetailItemKey];
   // [coder encodeObject:self.textField.text forKey:kTextKey];
   // [coder encodeObject:self.detailDescriptionLabel.text forKey:kDetailLabelText];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    //self.detailViewController = [coder decodeObjectOfClass:DetailViewController.class forKey:kDetailViewControllerKey]; // it doesnt have the detail item
    //self.textField.text = [coder decodeObjectForKey:kTextKey];
  //  self.detailDescriptionLabel.text = [coder decodeObjectForKey:kDetailLabelText];
}

- (void)applicationFinishedRestoringState{
   // [self.tableView layoutIfNeeded]; // fix going back unlight bu
   // [self reselectTableRowIfNecessary];
}

@end
