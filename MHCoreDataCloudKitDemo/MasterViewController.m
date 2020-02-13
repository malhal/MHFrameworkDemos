//
//  MasterViewController.m
//  CoreDataCloudKitDemo2
//
//  Created by Malcolm Hall on 09/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
  //  self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.fetchedResultsController = [self newFetchedResultsController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
 //   [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didFindRelevantTransactions:) name:@"DidFindRelevantTransactions" object:self.managedObjectContext];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)didFindRelevantTransactions:(NSNotification *)notification{
    NSArray<NSPersistentHistoryTransaction *> *relevantTransactions = notification.userInfo[@"Transactions"];
    NSMutableArray<NSPersistentHistoryTransaction *> *filteredTransactions = NSMutableArray.array;
    for(NSPersistentHistoryTransaction *transaction in relevantTransactions){
        for(NSPersistentHistoryChange *change in transaction.changes){
            NSLog(@"%@", change.changedObjectID);
            if(![change.changedObjectID.entity.name isEqualToString:@"Post"]){
                continue;
            }
            NSArray *keys = [change.updatedProperties valueForKey:@"name"];
            
            if(![keys containsObject:@"title"]){
                continue;
            }
            [filteredTransactions addObject:transaction];
        }
    }
    for(NSPersistentHistoryTransaction *transaction in relevantTransactions){
        [self.fetchedResultsController.managedObjectContext mergeChangesFromContextDidSaveNotification:transaction.objectIDNotification];
    }
    NSLog(@"done");
}

- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    Post *object = [[Post alloc] initWithContext:context];
        
    // If appropriate, configure the new managed object.
    NSDateFormatter *df = [NSDateFormatter.alloc init];
    df.timeStyle = NSDateFormatterMediumStyle;
    object.title = [df stringFromDate:NSDate.date];
        
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (IBAction)changeFRC:(id)sender{
    
    NSFetchRequest<Post *> *fetchRequest = Post.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Post *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.persistentContainer.viewContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController = aFetchedResultsController;
}
    

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Post *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        MUIDetailNavigationController *navigation = (MUIDetailNavigationController *)[segue destinationViewController];
        //navigation.fetchedResultsController = [self newFetchedResultsController];
        //navigation.mui_detailModelIdentifier = object.objectID.URIRepresentation.absoluteString; // since not shown yet doesn't fire any events
        
      
        DetailViewController *controller = (DetailViewController *)navigation.topViewController;
        controller.detailItem = object;
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        controller.persistentContainer = self.persistentContainer;
        
        MCDSelectionController *sc = [MCDSelectionController.alloc initWithFetchedResultsController:[self newFetchedResultsController]];
              sc.selectedObject = object;
        controller.selectionController = sc;
        //self.detailViewController = controller;
    }
}


#pragma mark - Table View

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return [[self.fetchedResultsController sections] count];
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
//    return [sectionInfo numberOfObjects];
//}
//
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  //  Post *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
  //  [self configureCell:cell withObject:object];
    return cell;
}


//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSManagedObjectContext *context = self.fetchedResultsController.managedObjectContext;
//        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
//            
//        NSError *error = nil;
//        if (![context save:&error]) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//            abort();
//        }
//    }
//}

- (void)configureCell:(UITableViewCell *)cell withObject:(Post *)object{
//- (void)configureCell:(UITableViewCell *)cell withObject:(Post *)object {
    cell.textLabel.text = object.title;
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController<Post *> *)newFetchedResultsController {
//    if (_fetchedResultsController != nil) {
//        return _fetchedResultsController;
//    }
    
    NSFetchRequest<Post *> *fetchRequest = Post.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Post *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.persistentContainer.viewContext sectionNameKeyPath:nil cacheName:nil];
    return aFetchedResultsController;
    
//    aFetchedResultsController.delegate = self;
//
//    NSError *error = nil;
//    if (![aFetchedResultsController performFetch:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
//    }
//
//    _fetchedResultsController = aFetchedResultsController;
//    return _fetchedResultsController;
}


/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

@end
