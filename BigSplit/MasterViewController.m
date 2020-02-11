//
//  MasterViewController.m
//  BigSplit
//
//  Created by Malcolm Hall on 11/08/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

@interface MasterViewController () //<MUIMasterTableViewControllerDelegate, MUIFetchedMasterTableSelectionControllerDelegate>

@property (strong, nonatomic) Event *eventForSegue;
@property (strong, nonatomic) MUIFetchedTableRowsController *fetchedTableRowsController;
@property (strong, nonatomic) MUIFetchedMasterTableSelectionController *fetchedMasterTableSelectionController;
//@property (strong, nonatomic) MUIMasterDetailContext *masterDetailContext;

@end

@implementation MasterViewController
//@synthesize collapseControllerForDetail = _collapseControllerForDetail;

- (BOOL)containsDetailItem:(NSObject *)detailItem{
    return [self.fetchedResultsController.fetchedObjects containsObject:detailItem];
}

- (void)fetchedMasterTableSelectionController:(MUIFetchedMasterTableSelectionController *)fetchedMasterTableSelectionController didSelectObject:(id)object{
    self.eventForSegue = object;
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    //[self updateTableSelectionForCurrentSelectedDetailItem];
}


- (void)setVenue:(Venue *)venue {
    if (_venue == venue) {
        return;
    }
    _venue = venue;
    
    // Update the view.
    if(self.isViewLoaded){
        [self configureView];
    }
    
}

//- (NSManagedObjectContext *)managedObjectContext{
//    return self.masterItem.managedObjectContext;
//}

- (void)configureView{
    [self createFetchedResultsController];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 //   self.navigationItem.leftBarButtonItem = self.editButtonItem;
   // self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
   // self.navigationItem.leftItemsSupplementBackButton = YES;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItems = @[addButton, self.editButtonItem];
    //self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
   // [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(secondaryItemDidChange:) name:MUISecondaryItemControllerItemDidChangeNotification object:self.splitViewController.secondaryItemController];
    [self configureView];
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    
//    self.fetchedTableRowsController = [MUIFetchedTableRowsController.alloc initWithTableView:self.tableView];
//    self.fetchedTableRowsController.fetchedResultsController = self.fetchedResultsController;
//
//    self.fetchedMasterTableSelectionController = [MUIFetchedMasterTableSelectionController.alloc initWithFetchedTableRowsController:self.fetchedTableRowsController masterTableViewController:self];
//    self.fetchedMasterTableSelectionController.delegate = self;
}

- (id)detailItem{
    return self.venue;
}

- (void)secondaryItemDidChange:(id)sender{
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = self.managedObjectContext;// [self.fetchedResultsController managedObjectContext];
    if(!context){
        NSLog(@"Context is nil");
        return;
    }
    Event *newEvent = [[Event alloc] initWithContext:context];
        
    // If appropriate, configure the new managed object.
    newEvent.timestamp = [NSDate date];
    newEvent.venue = self.venue;
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

#pragma mark - Segues

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if(![super shouldPerformSegueWithIdentifier:identifier sender:sender]){
        return NO;
    }
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if(!indexPath){
        return NO;
    }
    Event *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if(!event){
        return NO;
    }
    else if(!self.mui_collapseControllerForMaster.splitViewController.isCollapsed && event == self.mui_collapseControllerForMaster.detailViewController.detailItem){ // prevent re-showing same segue.
        return NO;
    }
    //self.masterDetailContext.detailItem = event;
    self.eventForSegue = event;
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //Event *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        //[controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        controller.event = self.eventForSegue;
        self.mui_collapseControllerForMaster.detailViewController = controller;
  //      UIViewController *i = controller.parentViewController;
        
//        UIPresentationController *j = i.presentationController;
//        [i dismissViewControllerAnimated:YES completion:nil];
//        NSLog(@"");

        //id o = self.navigationController.navigationController;
        
//        if(self.splitViewController.preferredDisplayMode == UISplitViewControllerDisplayModeAutomatic){
//            [UIView animateWithDuration:0.2 animations:^{
//                self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
//            }
//            completion:^(BOOL finished) {
//                self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAutomatic;
//            }];
//        }
       // AppDelegate *ad = UIApplication.sharedApplication.delegate;
       // [ad.popoverController dismissPopoverAnimated:YES];
    }
}

- (id)targetForAction:(SEL)action withSender:(id)sender{
    id i = [super targetForAction:action withSender:sender];
    return i;
}

//- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
//    // targetViewControllerForAction
//    NSLog(@"");
//}

- (void)showViewController:(UIViewController *)vc sender:(id)sender{
    NSLog(@"");
}

#pragma mark - Table View
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Event *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withEvent:event];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
            
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell withEvent:(Event *)event {
    cell.textLabel.text = event.timestamp.description;
}
*/

- (void)fetchedTableRowsController:(MUIFetchedTableRowsController *)fetchedTableRowsController configureCell:(UITableViewCell *)cell withObject:(NSManagedObject<MUITableViewCellObject> *)object{
    Event *event = object;
    cell.textLabel.text = event.timestamp.description;
}


#pragma mark - Fetched results controller

//- (NSFetchedResultsController<Event *> *)fetchedResultsController {
- (void)createFetchedResultsController{
    //if (_fetchedResultsController != nil) {
    //    return _fetchedResultsController;
    //}
    if(!self.venue){
        return;
    }
    NSFetchRequest<Event *> *fetchRequest = Event.fetchRequest;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"venue = %@", self.venue];
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Event *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    self.fetchedResultsController = aFetchedResultsController;
    //return _fetchedResultsController;
}

/*
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}
 */

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

- (void)dealloc
{
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), self);
}

//- (id)mui_detailItem{
//    return self.masterItem;
//}

//- (id)mui_masterItem{
//    return self.masterItem;
//}
//
//
//- (BOOL)mui_containsDetailItem:(id)detailItem{
//    return [self.masterItem.events containsObject:detailItem];
//}

@end
