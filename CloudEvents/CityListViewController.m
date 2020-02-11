//
//  CityListViewController.m
//  CloudEvents
//
//  Created by Malcolm Hall on 26/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "CityListViewController.h"
#import "PersistentContainer.h"
#import "RootViewController.h"

@interface CityListViewController ()

@end

@implementation CityListViewController
//@dynamic fetchedResultsController;

- (NSManagedObjectContext *)managedObjectContext{
    return self.persistentContainer.viewContext;
}

- (IBAction)unwindToValidViewController:(UIStoryboardSegue *)segue{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    UIBarButtonItem *spacer = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.toolbarItems = @[spacer, addButton];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(deleteFirstCity:) name:@"DeleteFirstCity" object:nil];

 //   [self createFetchedResultsController];
}


//    self.fetchedTable = [MUIFetchedTable.alloc initWithFetchedResultsController:self.fetchedResultsController];
//    self.fetchedTable.dataSource = self;
//    self.fetchedTable.fetchedResultsControllerDelegate = self;
    
//    self.masterTable = [MUIFetchedTableViewController.alloc initWithFetchedTable:self.fetchedTable];
//    self.masterTable.delegate = self;
//    [self.masterTable selectObject:self.rootViewController.rootItem];
    
    //[UIApplication registerObjectForStateRestoration:self.masterTable restorationIdentifier:@"masterTable"];
    
//  [self configureSelectionManagerForRootItem];

//- (void)configureSelectionManagerForRootItem{
//    City *object = self.rootViewController.rootItem;
//    if(object){
//        //[self.masterTable selectObject:[self.fetchedResultsController.managedObjectContext objectWithID:<#(nonnull NSManagedObjectID *)#>
//    }
//}

//- (NSFetchedResultsController<City *> *)fetchedResultsController{
//    if(_fetchedResultsController){
//        return _fetchedResultsController;
//    }
- (void)createFetchedResultsController{
    NSManagedObjectContext *context = self.managedObjectContext;
    //NSManagedObjectContext *context = self.managedObjectContext.mcd_createChildContext;
    //context.automaticallyMergesChangesFromParent = YES;
    
    //[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(persistentStoreRemoteChangeNotification:) name:NSPersistentStoreRemoteChangeNotification object:nil];
    
    NSFetchRequest<City *> *fetchRequest = City.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    //_fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    self.fetchedResultsController = fetchedResultsController;
 //   return _fetchedResultsController;
}

//- (void)persistentStoreRemoteChangeNotification:(NSNotification *)notification{
//    NSLog(@"persistentStoreRemoteChangeNotification");
//    [self.fetchedResultsController.managedObjectContext refreshAllObjects];
//}

- (void)deleteFirstCity:(NSNotification *)notification{
    NSManagedObjectContext *moc = self.managedObjectContext;
    City *city = self.fetchedResultsController.fetchedObjects.firstObject;
    [moc deleteObject:city];
    [moc save:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    //self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    
    City *object = [[City alloc] initWithContext:context]; // self.fetchedResultsController.fetchedObjects.firstObject;//
    
    // If appropriate, configure the new managed object.
    object.timestamp = NSDate.date;
    object.title = @"Glasgow";
    
    //[venue addEventsObject:newEvent];
    
    NSError *error = nil;
    // prevent dups in table
//    if(![context obtainPermanentIDsForObjects:@[object] error:&error]){
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
//    }
    
      // Save the context.
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
//    if (![self.managedObjectContext save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
//    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"show"]) {
        Venue *object = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
        //        if(sender == self){
        //            object = self.venueForSegue;
        //        }
        //        else{
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        
        //        }
      //  if([sender isKindOfClass:UITableViewCell.class]){
     //       object = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForCell:sender]];
     //   }
        RootViewController *controller = (RootViewController *)[segue destinationViewController];
   //     controller.masterTable = self.rootSelectionManager;
        //NSManagedObjectContext *childMoc = self.managedObjectContext.mcd_createChildContext;
        //childMoc.automaticallyMergesChangesFromParent = YES;
        //controller.managedObjectContext = self.managedObjectContext; //childMoc;
        //controller.cityID = object.objectID;
//        NSString *modelID = self.masterTable.modelIdentifierForSelectedElement;
//        if(modelID){
        
        //City *object = self.masterTable.showedObject;
        if(object){
//            City *childObject = [childMoc objectWithID:object.objectID];
            controller.rootItem = object;
        }
     //   }
        
        // it doesn't have the object because its in a different context.
//        Venue *sv1 = self.rootViewController.masterTable.selectedObject;
//        if(sv1){
//            Venue *sv2 = [childMoc objectWithID:sv1.objectID];
//            [controller.masterTable selectObject:sv2];
//        }
        
        //            controller.masterItem = object;
        //            [controller selectObject:self.masterViewController.selectedObject];
        //  controller.fetchedTable.fetchedResultsController.mcd_parentFetchedResultsController = self.fetchedResultsController;
        controller.persistentContainer = self.persistentContainer;
     //   controller.delegate = self;
        controller.masterViewController = self.rootViewController.masterViewController;
        
        //[controller.masterTable selectObject:self.shownViewController.masterTable.selectedObject];
        //controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        //controller.navigationItem.leftItemsSupplementBackButton = YES;
        self.rootViewController = controller;
    }
}

#pragma mark - selection

//- (void)masterTable:(MUIMasterTable *)masterTable showObject:(id)object sender:(id)sender{
//    if(object){
//        [self performSegueWithIdentifier:@"show" sender:sender];
//    }
//    else{
//        [self.navigationController popToViewController:self animated:YES];
//    }
//}



#pragma mark - data source

- (void)configureCell:(UITableViewCell *)cell withObject:(City *)object{
    cell.textLabel.text = object.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", object.venues.count];
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = self.managedObjectContext;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UIStateRestoration

#define kRootViewControllerKey @"RootViewController"
#define kManagedObjectContextKey @"ManagedObjectContext"

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject:self.rootViewController forKey:kRootViewControllerKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    self.rootViewController = [coder decodeObjectForKey:kRootViewControllerKey];
}

- (void)applicationFinishedRestoringState{
    // [self.tableView layoutIfNeeded]; // fix going back unlight bug
    //[self reselectTableRowIfNecessary];
}

//+ (NSObject<UIStateRestoring>*)objectWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
//    return [MUIFetchedTableViewController.alloc init];
//}

//- (nullable NSString *)modelIdentifierForObject:(NSManagedObject *)object{
//    return object.objectID.URIRepresentation.absoluteString;
//}
//
//// on encode it asks for first and selected. On restore it asks for first so maybe checks ID. idx can be nil. called on decode too but with nil.
//- (nullable NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view{
//    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:idx];
//    NSString *identifier = object.objectID.URIRepresentation.absoluteString;
//    return identifier;
//}
//
//// called on decode
//- (nullable NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view{
//    if(!identifier){
//        return nil;
//    }
//    NSURL *objectURI = [NSURL URLWithString:identifier];
//    NSManagedObject *object = [self.fetchedResultsController.managedObjectContext mcd_objectWithURI:objectURI];
//    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];
//    return indexPath;
//}

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

@end
