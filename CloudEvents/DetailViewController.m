//
//  DetailViewController.m
//  CloudEvents
//
//  Created by Malcolm Hall on 04/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "DetailViewController.h"

NSString * const DetailViewControllerStateRestorationDetailItemKey = @"DetailViewControllerStateRestorationDetailItemKey";

@interface DetailViewController () <MCDManagedObjectChangeControllerDelegate>

@property (strong, nonatomic) NSArray *barButtons;
//@property (strong, nonatomic, readwrite) Event *detailItem;
@property (strong, nonatomic) MCDManagedObjectChangeController *changeController;

@end

@implementation DetailViewController

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = self.detailItem.timestamp.description;
        
//        UIBarButtonItem *deleteVenueButton = [[UIBarButtonItem alloc] initWithTitle:@"DeleteVenue" style:UIBarButtonItemStylePlain target:self action:@selector(deleteVenue:)];
//        
//        UIBarButtonItem *updateButton = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(update:)];
//        
//        self.navigationItem.rightBarButtonItems = @[updateButton, deleteVenueButton];
        [self.barButtons enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull barButton, NSUInteger idx, BOOL * _Nonnull stop) {
            barButton.enabled = YES;
        }];
    }
}

- (NSArray *)barButtons{
    if(!_barButtons){
        _barButtons = @[self.trashButton, self.updateButton];
    }
    return _barButtons;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.barButtons enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull barButton, NSUInteger idx, BOOL * _Nonnull stop) {
        barButton.enabled = NO;
    }];
    
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    //[self configureView];
//    if(self.detailItemObjectID){
//        Event *event = [self.managedObjectContext objectWithID:self.detailItemObjectID];
//        self.detailItem = event;
//    }
}

- (IBAction)trash:(id)sender{
    [self.managedObjectContext deleteObject:self.detailItem];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    //[self.delegate detailViewControllerDidSave:self];
}

- (IBAction)update:(id)sender{
    self.detailItem.timestamp = NSDate.date;
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    //[self.delegate detailViewControllerDidSave:self];
    //[self configureView];
}

- (IBAction)deleteVenue:(id)sender{
    [NSNotificationCenter.defaultCenter postNotificationName:@"DeleteFirstVenue" object:nil];
}

- (IBAction)deleteFirstCity:(id)sender{
    [NSNotificationCenter.defaultCenter postNotificationName:@"DeleteFirstCity" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    [self configureView];
    if(self.detailItem){
        //[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(managedObjectContextObjectsDidChangeNotification:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.detailItem.managedObjectContext];
    }
}

- (void)controller:(MCDManagedObjectChangeController *)controller didChange:(MCDManagedObjectChangeType)type{
    
    switch (type) {
        case MCDManagedObjectChangeUpdate:
            [self configureView];
            break;
        case MCDManagedObjectChangeDelete:
          //  [self detailItemWasDeleted];
            break;
        default:
            break;
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationItem.leftBarButtonItem = nil;
   // self.changeController = nil;
}

//- (void)didMoveToParentViewController:(UIViewController *)parent{
//    [super didMoveToParentViewController:parent];
//    if(!self.detailItem){
//         [self performSegueWithIdentifier:@"unwind" sender:self];
//    }
//}

#pragma mark - Managing the detail item

- (void)setDetailItem:(Event *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureViewIfNecessary];

        //self.changeController = [MCDManagedObjectChangeController.alloc initWithManagedObject:newDetailItem managedObjectContext:self.managedObjectContext];
        //self.changeController.delegate = self;
      //  [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(selectedObjectDidUpdate:) name:MUIListViewControllerSelectedObjectDidUpdateNotification object:newDetailItem];
    }
}

- (void)selectedObjectDidUpdate:(NSNotification *)notification{
    [self configureViewIfNecessary];
}

- (void)configureViewIfNecessary{
    if(self.mui_isViewVisible){
        [self configureView];
    }
}

#pragma mark - UIStateRestoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject:self.detailItem.objectID.URIRepresentation forKey:DetailViewControllerStateRestorationDetailItemKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState{
}

@end
