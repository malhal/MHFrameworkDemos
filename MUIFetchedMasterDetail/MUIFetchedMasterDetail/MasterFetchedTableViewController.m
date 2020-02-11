//
//  MasterFetchedTableViewController.m
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 27/10/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MasterFetchedTableViewController.h"

@interface MasterFetchedTableViewController ()

@end

@implementation MasterFetchedTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //[self createFetchedResultsController];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!self.fetchedResultsController){
        [self createFetchedResultsController];
    }
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object{
    Event *event = (Event *)object;
    cell.textLabel.text = event.timestamp.description;
}

#pragma mark - Table Data

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.opaque = NO;
    cell.textLabel.backgroundColor = UIColor.clearColor;
    return cell;
}

#pragma mark - Fetched results controller

//- (NSFetchedResultsController<Event *> *)fetchedResultsController {
- (void)createFetchedResultsController{
    id i = self.parentViewController;
    NSPersistentContainer *pc = [self mcd_persistentContainerWithSender:self];
    NSManagedObjectContext *moc = pc.viewContext;
    NSAssert(moc, @"createFetchedResultsController called without managedObjectContext");
//    if (_fetchedResultsController != nil) {
//        return _fetchedResultsController;
//    }
//- (void)createFetchedResultsController{
//- (void)createFetchedResultsControllerForFetchedTableViewController:(MUIFetchedTableViewController *)fetchedTableViewController{
    NSFetchRequest<Event *> *fetchRequest = Event.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    if(self.masterItem){
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"venue = %@", self.masterItem];
    }
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];
    //fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
   // fetchedTableViewController.fetchedResultsController = fetchedResultsController;
    
    //_fetchedResultsController = aFetchedResultsController;
    //return _fetchedResultsController;
    self.fetchedResultsController = fetchedResultsController;
}

@end
