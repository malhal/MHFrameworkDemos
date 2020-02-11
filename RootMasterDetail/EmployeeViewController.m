//
//  EmployeeViewController.m
//  RootMasterDetail
//
//  Created by Malcolm Hall on 21/01/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "EmployeeViewController.h"

@interface EmployeeViewController ()

@end

@implementation EmployeeViewController


//- (void)setSelectedItemControllerForDetail:(SelectedItemController *)selectedItemControllerForDetail{
//    if(selectedItemControllerForDetail == _selectedItemControllerForDetail){
//        return;
//    }
//    _selectedItemControllerForDetail = selectedItemControllerForDetail;
//    if(!selectedItemControllerForDetail){
//        return;
//    }
//    self.navigationItem.leftBarButtonItem = selectedItemControllerForDetail.splitViewController.displayModeButtonItem; // looks like back button when app started in ipad portrait.
//    self.detailItem = selectedItemControllerForDetail.detailItem;
//}

- (NSManagedObjectContext *)managedObjectContext{
//    if(!_managedObjectContext){
//        _managedObjectContext = self.detailItem.managedObjectContext;
//    }
//    return _managedObjectContext;
    return self.detailItem.managedObjectContext;
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = self.detailItem.timestamp.description;
        self.navigationItem.title = self.detailItem.name;
        self.deleteBarButtonItem.enabled = YES;
        self.deleteVenueButton.enabled  = YES;
    }
//    else{
//        self.detailDescriptionLabel.text = nil;
//        self.deleteBarButtonItem.enabled = NO;
//        self.deleteVenueButton.enabled  = NO;
//    }
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(managedObjectContextDidChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.managedObjectContext];
    
    //   self.detailItem = self.splitViewController.masterDetailContext.detailItem; // split might not be in hierarchy
    // [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(detailItemDidChange:) name:SelectedItemControllerDetailItemDidChange object:self.splitViewController.masterDetailContext];
    [self configureView];
}

// called slow when pushed but instantly when in split.
//- (void)viewDidAppear:(BOOL)animated{
//    BOOL b = self.navigationController.navigationBarHidden;
//    NSLog(@"");
//}

//- (void)viewWillDisappear:(BOOL)animated{
//[NSNotificationCenter.defaultCenter removeObserver:self name:SelectedItemControllerDetailItemDidChange object:self.masterDetailContext];
//}

//- (void)detailItemDidChange:(NSNotification *)notification{
//    id detailItem = notification.userInfo[@"DetailItem"];
//    self.detailItem = detailItem; // when seperated this calls with same detail item as we already get but is ignored by the setter.
//}

// need to listen for changes in case the folder view controller no longer exists.
// in case of delete from folder list it will have already changed the detail item.
- (void)managedObjectContextDidChange:(NSNotification *)notification{
    NSSet *deletedObjects = notification.userInfo[NSDeletedObjectsKey];
    if(![deletedObjects containsObject:self.detailItem]){
        //self.detailItem = nil;
        return;
    }
//    if(self.view.window){
//        EmployeeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeeViewController"];
//        self.navigationController.viewControllers = @[vc];
//        self.selectedItemControllerForDetail.detailViewController = vc;
//    }
}

#pragma mark - Managing the detail item

//- (void)setSelectedItemController:(SelectedItemController *)masterDetailContext{
//    if(masterDetailContext == _masterDetailContext){
//        return;
//    }
//    _masterDetailContext = masterDetailContext;
//    self.detailItem = masterDetailContext.detailItem;
//}

- (void)setDetailItem:(Event *)detailItem {
    if (_detailItem == detailItem) {
        return;
    }
    _detailItem = detailItem;

    // Update the view.
    if(self.isViewLoaded){
        [self configureView];
    }
}

- (IBAction)deleteButtonTapped:(id)sender{
    //[self.delegate detailViewControllerDidTapDelete:self];
    //SelectedItemController *selectedItemController = self.selectedItemControllerForDetail;
    [self.managedObjectContext deleteObject:self.detailItem];
    [self.managedObjectContext save:nil];

}

- (IBAction)deleteVenue:(id)sender {
    [self.managedObjectContext deleteObject:self.detailItem.venue];
    [self.managedObjectContext save:nil];
}

@end

