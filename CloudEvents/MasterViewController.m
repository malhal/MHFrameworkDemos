//
//  MasterViewController.m
//  CloudEvents
//
//  Created by Malcolm Hall on 04/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
//#import "FetchedDataSource.h"
//#import "NSManagedObjectContext+MCD.h"
#import "RootViewController.h"
#import "PersistentContainer.h"

@interface MasterViewController ()

@property (strong, nonatomic) NSFetchedResultsController<Event *> *fetchedResultsController;
@property (strong, nonatomic) MUIFetchedTableViewController *fetchedTableViewController;
@end

@implementation MasterViewController
@synthesize fetchedResultsController = _fetchedResultsController;
@dynamic detailViewController;
@dynamic persistentContainer;

- (IBAction)unwindToValidViewController:(UIStoryboardSegue *)segue{
    
}

- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController sender:(id)sender{
    return self.masterItem;
}

- (void)enableButtons:(BOOL)enabled{
    NSArray *buttons = @[self.editButtonItem, self.trashButton, self.addButton];
    for(UIBarButtonItem *button in buttons){
        button.enabled = enabled;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
//    self.toolbarItems = @[button, spacer, addButton];
    
    //self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    //self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
 //   [self createFetchedResultsController];
    //self.selectedObject = self.detailViewController.detailItem;
    //[self selectObject:self.detailViewController.detailItem];
    [self configureView];
}

- (void)configureView{
    [self enableButtons:self.fetchedResultsController];
}

//- (void)configureViewForFetchedResultsController{
//    if(self.fetchedResultsController){
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        self.fetchedTable = [MUIFetchedTable.alloc initWithFetchedResultsController:self.fetchedResultsController];
//        self.fetchedTable.dataSource = self;
//        self.fetchedTable.delegate = self;
//        self.fetchedTable.fetchedResultsControllerDelegate = self.fetchedMasterTable;
//        [self.fetchedTable selectObject:self.detailViewController.detailItem];
// [self configureSelectionManagerForDetailItem];
//    }else{
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [self enableButtons:NO];
//    }
//}

- (NSManagedObjectContext *)managedObjectContext{
    return self.persistentContainer.viewContext;
}

//- (void)detailViewControllerDidSave:(DetailViewController *)detailViewController{
//    NSError *error = nil;
//    if (![self.managedObjectContext save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
//    }
//}

- (void)buttonTapped:(id)sender{
    [self setEditing:NO animated:YES];
}

- (NSFetchedResultsController *)fetchedResultsController{
    if(_fetchedResultsController){
        return _fetchedResultsController;
    }
//    if(!self.masterItem){
//        return;
//    }
    NSManagedObjectContext *context = self.managedObjectContext;//.mcd_createChildContext;
    //context.automaticallyMergesChangesFromParent = YES;
    
    NSFetchRequest<Event *> *fetchRequest = Event.fetchRequest;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"venue == %@", self.masterItem.objectID];
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
     _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
     _fetchedResultsController.delegate = self;
    //self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    return _fetchedResultsController;
}

#pragma mark - selection

- (void)showDetailWithObject:(NSManagedObject *)object{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}


//on XR it clears by mistake
- (void)viewWillAppear:(BOOL)animated {
   //  [self.tableView layoutIfNeeded];
    //self.listViewController.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];

}


- (IBAction)button:(id)sender{
    [self showViewController:UITableViewController.alloc.init sender:self.view];
}

- (IBAction)trashVenue:(id)sender{
    [self.managedObjectContext deleteObject:self.masterItem];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
         abort();
    }
   // [self.delegate masterViewControllerDidSave:self];
}

- (IBAction)insertNewObject:(id)sender {
    // we can create a child context so if valudation fails on teh first save we can end without screwing up the parent context.
    
    NSManagedObjectContext *context = self.masterItem.managedObjectContext;// [NSManagedObjectContext.alloc initWithConcurrencyType:NSMainQueueConcurrencyType];
    //context.parentContext = self.managedObjectContext;
    
    //Venue *venue =  ;//[context objectWithID:self.masterItem];
    
   // Venue *venue =  nil;//[[Venue alloc] initWithContext:context];
    Event *newEvent = [[Event alloc] initWithContext:context]; // self.fetchedResultsController.fetchedObjects.firstObject;//
        
    // If appropriate, configure the new managed object.
    newEvent.timestamp = [NSDate date];
    newEvent.title = @"Malc";
    newEvent.venue = self.masterItem;
    
    
    NSError *error = nil;

//    if(![context obtainPermanentIDsForObjects:@[newEvent] error:&error]){
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
//    }
//
//
    
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    //[self.masterItem addEventsObject:newEvent];
    // Save the context.
//    NSError *error = nil;
//    if (![self.masterItem.managedObjectContext save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
//    }
    
    //[self.delegate masterViewControllerDidSave:self];

}

#pragma mark - Segues

// this way we allow selections but prevent the segue
//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    if(self.isEditing){
//        return NO;
//    }
//    return YES;
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        Event *object = self.selectedObject;
//        if([sender isKindOfClass:UITableViewCell.class]){
//            object = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForCell:sender]];
//        }
       // else if([sender isKindOfClass:MUIFetchedTable.class]){
           // object = self.fetchedTable.selectedObject;
       // }
//        else if([sender isKindOfClass:MUIMasterTable.class]){
//        NSString *modelID = self.masterTable.modelIdentifierForSelectedElement;
//        if(modelID){
//            object = [self.fetchedResultsController.managedObjectContext mui_objectWithModelIdentifier:modelID];
//        }
   //     }
        
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        
        // = self.masterTable.selectedObject;
        if(object){
            controller.detailItem = object;//[self.managedObjectContext objectWithID:object.objectID];
            //controller.detailItemObjectID = object.objectID;
            
        }
        controller.managedObjectContext = self.managedObjectContext;
//        if(object){
//            NSManagedObjectContext *childMoc = self.managedObjectContext.mcd_createChildContext;
//            childMoc.automaticallyMergesChangesFromParent = YES;
//            Event *childObject = [childMoc objectWithID:object.objectID];
//            controller.detailItem = childObject;
//            controller.managedObjectContext = childMoc;
//        }
        
        self.detailViewController = controller;
    }
    else if ([[segue identifier] isEqualToString:@"embed"]) {
        MUIFetchedTableViewController *vc = segue.destinationViewController;
        vc.delegate = self;
        self.fetchedTableViewController = vc;
    }
}

#pragma mark - Table Objects


- (void)fetchedTableViewController:(MUIFetchedTableViewController *)fetchedTableViewController configureCell:(UITableViewCell *)cell withObject:(Event *)object{
    cell.textLabel.text = object.timestamp.description;
}

#pragma mark - Table Data

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *context = self.fetchedResultsController.managedObjectContext;
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
        
      //  [self.managedObjectContext save:nil];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

#pragma mark - UIStateRestoration

#define kManagedObjectContextKey @"ManagedObjectContext"
#define kMasterItemKey @"MasterItem"
#define kDetailViewControllerKey @"DetailViewController"
//#define kSelectionManagerKey @"SelectionManager"

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject:self.masterItem.objectID.URIRepresentation forKey:kMasterItemKey];
    //[coder encodeObject:self.masterTable forKey:kSelectionManagerKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState{
//    NSIndexPath *ip = self.tableView.indexPathForSelectedRow;
   //[self.tableView reloadData];
  //  [self.tableView layoutIfNeeded]; // fix going back unlight bu
    //[self reselectTableRowIfNecessary];
    //[self createFetchedResultsController];
    //
}

//- (BOOL)contansDetailItem:(id)detailItem{
//    NSManagedObject *object = (NSManagedObject *)detailItem;
//    //NSManagedObject *object2 = [self.fetchedResultsController.managedObjectContext objectWithID:object.objectID];
//    //return [self.fetchedResultsController.fetchedObjects containsObject:object2];
//    return [self.fetchedResultsController indexPathForObject:object];
//}

//- (UIViewController *)mui_viewedObjectViewController{
//    return self.detailViewController;
//}

//- (id)mui_viewedObject{
//    return self.masterItem;
//}

@end
