//
//  RootViewController.m
//  CloudEvents
//
//  Created by Malcolm Hall on 05/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "RootViewController.h"
#import "MasterViewController.h"
//#import "FetchedDataSource.h"
//#import "NSManagedObjectContext+MCD.h"
//#import "SelectionManager.h"
#import "PersistentContainer.h"

@interface RootViewController ()

//@property (strong, nonatomic) MUIFetchedTableViewController *masterSelectionManager;

@end

@implementation RootViewController
@dynamic fetchedResultsController;

- (void)setMasterViewController:(MasterViewController *)masterViewController{
    if(masterViewController == _masterViewController){
        return;
    }
    else if(_masterViewController.parentViewController == self){
        [_masterViewController willMoveToParentViewController:nil];
        [_masterViewController removeFromParentViewController];
    }
    _masterViewController = masterViewController;
}

- (IBAction)unwindToValidViewController:(UIStoryboardSegue *)segue{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    UIBarButtonItem *trashButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trashCity:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    UIBarButtonItem *spacer = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.toolbarItems = @[spacer, addButton, trashButton];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(deleteFirstVenue:) name:@"DeleteFirstVenue" object:nil];
    
    NSAssert(self.navigationController, @"navigationController cannot be nil");
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(navigationControllerDidShowViewController:) name:MUINavigationControllerDidShowViewControllerNotification object:self.navigationController];
    
    [self configureView];
}

- (void)navigationControllerDidShowViewController:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    if(userInfo[MUINavigationControllerNextVisibleViewController] != self){ // if we arn't being shown
        return;
    }
    else if(!self.masterViewController){
        return;
    }
    if(userInfo[MUINavigationControllerLastVisibleViewController] != self.masterViewController){ // if not coming back from master
        return;
    }
    [self addChildViewController:self.masterViewController];
    [self.masterViewController didMoveToParentViewController:self];
}

- (void)configureView{
    [self enableButtons:self.fetchedResultsController];
}

- (void)enableButtons:(BOOL)enabled{
    //NSArray *buttons = @[self.editButtonItem, self.trashButton, self.addButton];
    for(UIBarButtonItem *button in self.toolbarItems){
        button.enabled = enabled;
    }
}

- (NSManagedObjectContext *)managedObjectContext{
    return self.persistentContainer.viewContext;
}

//- (NSFetchedResultsController *)fetchedResultsController{
//    if(_fetchedResultsController){
//        return _fetchedResultsController;
//    }
- (void)createFetchedResultsController{
    NSManagedObjectContext *context = self.managedObjectContext;//.mcd_createChildContext;
   // context.automaticallyMergesChangesFromParent = YES;
    //[context setQueryGenerationFromToken:NSQueryGenerationToken.currentQueryGenerationToken error:nil];
    
    NSFetchRequest<Venue *> *fetchRequest = Venue.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"city == %@", self.rootItem.objectID];
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    //aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
//    return _fetchedResultsController;
    self.fetchedResultsController = fetchedResultsController;
}

- (void)deleteFirstVenue:(NSNotification *)notification{
    NSManagedObjectContext *moc = self.fetchedResultsController.managedObjectContext;
    Venue *v = self.fetchedResultsController.fetchedObjects.firstObject;
    [moc deleteObject:v];
    [moc save:nil];
    [self.rootItem.managedObjectContext save:nil];
}

- (void)trashCity:(id)sender{
    [self.rootItem.managedObjectContext deleteObject:self.rootItem];
    [self.rootItem.managedObjectContext save:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    
    //self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = self.rootItem.managedObjectContext;//[self managedObjectContext];

    Venue *object = [[Venue alloc] initWithContext:context]; // self.fetchedResultsController.fetchedObjects.firstObject;//
    
    // If appropriate, configure the new managed object.
    //newEvent.timestamp = [NSDate date];
    object.title = @"Malc's Venue";
    
    //City *city = [context objectWithID:self.cityID];
    object.city = self.rootItem;
    
    //[venue addEventsObject:newEvent];
    
    NSError *error = nil;
    // prevent dups in table
//    if(![context obtainPermanentIDsForObjects:@[object] error:&error]){
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
//    }
//    
     // Save the context.
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    //[self.delegate rootViewControllerDidSave:self];
}

//- (void)masterViewControllerDidSave:(MasterViewController *) masterViewController{
//    NSError *error = nil;
//    if (![self.managedObjectContext save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
//    }
//   // [self.delegate rootViewControllerDidSave:self];
//}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"show"]) {
        Venue *object = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
        //if([sender isKindOfClass:UITableViewCell.class]){
        //    object = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForCell:sender]];
       // }
       // if([sender isKindOfClass:MUIMasterTable.class]){
//            NSString *modelID = self.masterTable.modelIdentifierForSelectedElement;
//            if(modelID){
//                object = [self.fetchedResultsController.managedObjectContext mui_existingObjectWithModelIdentifier:modelID error:nil];
//            }
    //    }
    //    else{
            //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            //object = [self.fetchedResultsController objectAtIndexPath:indexPath];
     //   }
        
        MasterViewController *controller = (MasterViewController *)[segue destinationViewController];
        //NSManagedObjectContext *childMoc = self.managedObjectContext.mcd_createChildContext;
        //childMoc.automaticallyMergesChangesFromParent = YES;
        //controller.managedObjectContext = childMoc;
       // controller.masterTable = self.masterSelectionManager;
        controller.persistentContainer = self.persistentContainer;
            if(object){
                //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    controller.masterItem = object;//[self.rootItem.managedObjectContext objectWithID:object.objectID];
               // });
                
            }
//        }
        //controller.managedObjectContext = self.managedObjectContext;
        
//        if(object){
//            Venue *childObject = [childMoc objectWithID:object.objectID];
//            controller.masterItem = childObject;
//        }
        
            // it doesn't ahve the object because its in a different context.
//        City *sv1 = self.masterViewController.masterTable.selectedObject;
//        if(sv1){
//            City *sv2 = [childMoc objectWithID:sv1.objectID];
//            [controller.masterTable selectObject:sv2];
//        }
        
        //[controller selectObject:self.masterViewController.selectedObject];
        controller.detailViewController = self.masterViewController.detailViewController;
        
        self.masterViewController = controller;
    }
}

#pragma mark - Objects

- (void)configureCell:(UITableViewCell *)cell withObject:(Venue *)object{
    cell.textLabel.text = object.title;
    cell.detailTextLabel.text = object.eventCount.stringValue;// [NSString stringWithFormat:@"%ld", object.events.count];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
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
        
      //  [self.rootItem.managedObjectContext save:nil];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


#pragma mark - UIStateRestoration

#define kMasterViewControllerKey @"MasterViewController"
#define kRootItemKey @"RootItem"
#define kManagedObjectContextKey @"ManagedObjectContext"
//#define kSelectionManagerKey @"SelectionManager"
//#define kMasterSelectionManagerKey @"MasterSelectionManager"

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject:self.masterViewController forKey:kMasterViewControllerKey];
    [coder encodeObject:self.rootItem.objectID.URIRepresentation forKey:kRootItemKey];
//    [coder encodeObject:self.masterTable forKey:kSelectionManagerKey];
//    [coder encodeObject:self.masterSelectionManager forKey:kMasterSelectionManagerKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    self.masterViewController = [coder decodeObjectForKey:kMasterViewControllerKey];
}

- (void)applicationFinishedRestoringState{
  //  [self configureSelectionManagerForMasterItem];
   // [self.tableView layoutIfNeeded]; // fix going back unlight bug
}

// for when in landscape on the root, it needs to push the master on.
//- (void)collapseSecondaryViewController:(UIViewController *)secondaryViewController forSplitViewController:(UISplitViewController *)splitViewController{
//    if([self.navigationController.viewControllers containsObject:self.masterViewController]){
//        return;
//    }
//
//    [self.navigationController pushViewController:self.masterViewController animated:NO];
//}

//- (UIViewController *)mui_viewedObjectViewController{
//    return self.masterViewController;
//}

//- (BOOL)contansDetailItem:(id)detailItem{
//
//    NSManagedObject *object = (NSManagedObject *)detailItem;
//  //  NSManagedObject *object2 = [self.rootItem.managedObjectContext objectWithID:object.objectID];
//    //return [self.fetchedResultsController.fetchedObjects containsObject:object2];
//    return [self.fetchedResultsController indexPathForObject:object];
//}

@end

