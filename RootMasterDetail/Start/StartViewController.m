//
//  StartViewController.m
//  BasicSplit
//
//  Created by Malcolm Hall on 08/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "StartViewController.h"
#import "MiddleViewController.h"
#import "EndViewController.h"
#import "MiddleNavigationController.h"
#import "OuterSplitViewController.h"
#import "PersistentContainer.h"

//static NSString *kManagedObjectContextStateKey = @"ManagedObjectContext";

@interface StartViewController () //<MasterTableViewControllerDelegate>

@property (strong, nonatomic) NSIndexPath *indexPathOfDeletedObject;

@property (assign, nonatomic) BOOL previousDetailItemWasDeleted;
//@property (strong, nonatomic) UINavigationController *otherMiddleNavigationController;
//@property (strong, nonatomic) MiddleViewController *middleViewController;
//@property (strong, nonatomic) MiddleNavigationController *detailNavigationController;

//@property (strong, nonatomic) UISplitViewController *middleEndSplitViewControlller;
//@property (strong, nonatomic) MiddleViewController *middleViewController;
//@property (strong, nonatomic) NSManagedObject *objectToShow;
@property (strong, nonatomic) UIViewController *viewControllerFromSegue;

@end

@implementation StartViewController

- (void)showViewControllerForObject:(NSManagedObject *)object{
    //[UIView performWithoutAnimation:^{
        [self performSegueWithIdentifier:@"showDetail" sender:self];
    //}];
}


- (void)awakeFromNib{
    [super awakeFromNib];
    //self.middleEndSplitViewControlller = self.splitViewController;
    //id i = self.middleEndSplitViewControlller.parentViewController;
    self.splitViewController.delegate = self;
}

// not called in 50:50 split overlay because events list is pushed into master nav, happens when going back.
// self.splitViewController is getting primary by mistake
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
   // SelectedItemController *selectedItemController = [SelectedItemController.alloc initWithSplitViewController:self.splitViewController];
    //selectedItemController.itemSelection = self;
    //selectedItemController.delegate = self;
    //self.selectedItemController = selectedItemController;
    
   // UISplitViewController *middleEndSplitViewControlller = self.splitViewController.splitViewController;
    
    //SelectedItemController *middleEndSelectedItemController = [SelectedItemController.alloc initWithSplitViewController:middleEndSplitViewControlller];
    //[UIApplication registerObjectForStateRestoration:middleEndSelectedItemController restorationIdentifier:@"MiddleEndSelectedItemController"];
    //self.middleEndSelectedItemController = middleEndSelectedItemController;
    
    // cant do this here. Why not?
//    MiddleNavigationController *detailNavigationController = self.splitViewController.viewControllers.lastObject;
//    MiddleViewController *middle = detailNavigationController.viewControllers.firstObject;
//    middle.middleEndSelectedItemController = self.middleEndSelectedItemController;
//
 //   [self configureView];
    
  //  self.middleEndSelectedItemController = [SelectedItemController.alloc initWithSplitViewController:self.splitViewController.splitViewController];
    
    //self.fetchedTableViewController.fetchedResultsController = self.fetchedResultsController;
    //self.fetchedTableViewController.tableView.delegate = self;
    [self createFetchedResultsController];
}

//- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
//    if(managedObjectContext == _managedObjectContext){
//        return;
//    }
//    _managedObjectContext = managedObjectContext;
//    [self createFetchedResultsController];
//    if(self.isViewLoaded){
//        [self configureView];
//    }
//}

//- (void)configureView{
//    if(self.fetchedResultsController){
//        [self.tableView reloadData];
//    }
//}

//- (void)setShownDetailNavigationController:(DetailNavigationController *)shownDetailNavigationController{
//    self.shownMiddleViewController.delegate = nil;
//    super.shownDetailNavigationController = shownDetailNavigationController;
//    self.shownMiddleViewController.delegate = self;
//}

//- (MiddleViewController *)shownMiddleViewController{
//    return (MiddleViewController *)self.shownDetailNavigationController.topViewController;
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = self.fetchedResultsController.managedObjectContext;
    Venue *newVenue = [[Venue alloc] initWithContext:context];
    
    NSArray *names = [NSArray arrayWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"VenueNames" ofType:@"plist"]];
    uint32_t rnd = arc4random_uniform((uint32_t)names.count);
    newVenue.name = [names objectAtIndex:rnd];
    // If appropriate, configure the new managed object.
   // newVenue.timestamp = [NSDate date];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
//    self.selectedItemControllerForMaster.detailItem = newVenue;
//    [self performSegueWithIdentifier:@"showDetail" sender:sender];
//    [self updateRowSelectionForCurrentDetailItem];
}

- (void)showObject:(NSManagedObject *)object{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

#pragma mark - Segues

//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    self.objectForSegue = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
//    return YES;
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath;
//        if([sender isKindOfClass:UITableViewCell.class]){
//            indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
//        }else if([sender isKindOfClass:NSIndexPath.class]){
//            indexPath = (NSIndexPath *)sender;
//        }
        MiddleNavigationController *nav = [segue destinationViewController];
        MiddleViewController *controller = (MiddleViewController *)nav.topViewController;
        id i = self.outerSplitViewController;
        controller.resolvedSplitViewController = self.outerSplitViewController;
        controller.detailItem = self.selectedObject;//[self.fetchedResultsController objectAtIndexPath:indexPath];
        
        
        self.fetchedResultsController.delegate = nil;
        self.fetchedResultsController.delegate = self;
        
        //controller.targetSplitViewController = self.outerSplitViewController;
        
      //  MiddleViewController *shownMiddleViewController = self.shownDetailViewController;
        //(MiddleViewController *)self.shownDetailNavigationController.topViewController;
        //shownMiddleViewController.detailItem = nil;
        
        //controller.shownDetailNavigationController = shownMiddleViewController.shownDetailNavigationController;
        //controller.shownDetailViewController = shownMiddleViewController.shownDetailViewController;
        
        //[controller setMiddleItem:self.objectToShow targetSplitViewController:self.outerSplitViewController shownDetailNavigationController:shownMiddleViewController.shownDetailNavigationController];
        
       //self.shownDetailNavigationController = nav;
        //self.shownDetailViewController = controller;
        
      //  __unused id i = controller.view; // fix bug in nav bar items not appearing for animation.
    }
    else if([segue.identifier isEqualToString:@"embed"]){
        MUIFetchedTableViewController *vc = segue.destinationViewController;
        vc.delegate = self;
        //vc.fetchedResultsController = self.fetchedResultsController;
        self.fetchedTableViewController = vc;
    }
}

#pragma mark - master

//- (void)masterTableViewController:(MasterTableViewController *)masterTableViewController showObject:(NSManagedObject *)object{
//    [masterTableViewController performSegueWithIdentifier:@"showDetail" sender:masterTableViewController];
//}

//- (UISplitViewController *)splitViewControllerForMasterTableViewController:(MasterTableViewController *)masterTableViewController{
//    return self.outerSplitViewController;
//}

#pragma mark - split

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[EndViewController class]] && ([(EndViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
    //if ([secondaryViewController isKindOfClass:[DetailNavigationController class]] && [(DetailNavigationController *)secondaryViewController detailItem] == nil) {
        return YES;
    } else {
        return NO;
    }
}

//- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
//    if ([primaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)primaryViewController topViewController] isKindOfClass:[UINavigationController class]]){
//        return nil;
//    }
//    UINavigationController *nav = [primaryViewController.storyboard instantiateViewControllerWithIdentifier:@"MiddleNavigationController"];
//    self.middleViewController.endViewController = nil;//.detailViewController = nil;
//    return nav;
//}

//- (MiddleNavigationController *)recreateDetailViewControllerForSelectedItemController:(SelectedItemController *)selectedItemController{
//    MiddleNavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"MiddleNavigationController"];
    //[self configureMiddleNavigationController:nav];
    //
    //controller.selectedItem = self.otherMiddleNavigationController.detailItem;
    //controller.delegate = self;
    //controller.middleEndSelectedItemController = self.middleEndSelectedItemController;
//    return nav;
//}

////
//- (void)configureMiddleNavigationController:(MiddleNavigationController *)nav{
//    //nav.detailItem = self.selectedItem;
//
//   // self.middleViewController = controller;
//}

#pragma mark - Table View

//- (void)configureCell:(UITableViewCell *)cell withObject:(Venue *)object {
//    cell.textLabel.text = object.name;//timestamp.description;
//}

#pragma mark - Fetched results controller

//- (NSFetchedResultsController<Venue *> *)fetchedResultsController {
- (void)createFetchedResultsController{
//    if (_fetchedResultsController != nil) {
//        return _fetchedResultsController;
//    }
    NSFetchRequest<Venue *> *fetchRequest = Venue.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    UISplitViewController *s = self.splitViewController;
    PersistentContainer *pc = [self mcd_persistentContainerWithSender:self];
    NSManagedObjectContext *moc = pc.viewContext;
    
    NSFetchedResultsController<Venue *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil]; // @"Master"
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
   // _fetchedResultsController = aFetchedResultsController;
   // return _fetchedResultsController;
    self.fetchedResultsController = aFetchedResultsController;
}

//- (void)middleViewControllerDeleteTapped:(MiddleViewController *)middleViewController{
//    self.previousDetailItemWasDeleted = YES;
//    [self.managedObjectContext deleteObject:middleViewController.detailItem];
//    [self.managedObjectContext save:nil];
//}

#pragma mark - State Restoration

//- (void)setMiddleViewController:(MiddleViewController *)middleViewController{
//    self.detailViewController = middleViewController;
//}

//- (MiddleViewController *)middleViewController{
//    return self.detailViewController;
//}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [super encodeRestorableStateWithCoder:coder];
    // [coder encodeObject:self.selectedItem.objectID.URIRepresentation forKey:kSelectedDetailItemStateKey];
  //  [coder encodeObject:self.managedObjectContext forKey:kManagedObjectContextStateKey];
    //[coder encodeObject:self.middleViewController forKey:@"MiddleViewController"];
    //[coder encodeObject:self.selectedItemController.detailViewController forKey:@"MiddleNavigationController"];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
    [super decodeRestorableStateWithCoder:coder];
    //self.middleTableViewController = [coder decodeObjectForKey:@"MiddleTableViewController"];
 //   NSManagedObjectContext *managedObjectContext = [coder decodeObjectForKey:kManagedObjectContextStateKey];
    // self.middleViewController = [coder decodeObjectForKey:@"MiddleViewController"];
    // self.middleViewController.middleEndSelectedItemController = self.middleEndSelectedItemController;
    MiddleNavigationController *nav = [coder decodeObjectForKey:@"MiddleNavigationController"];
    // [self configureMiddleNavigationController:nav];
    //  id i = nav.topViewController;
    //  NSLog(@"topViewController %@", i);
    //self.selectedItemController.detailViewController = nav;
}

@end
