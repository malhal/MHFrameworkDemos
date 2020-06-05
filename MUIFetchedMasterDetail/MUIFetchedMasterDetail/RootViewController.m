//
//  RootViewController.m
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 13/09/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "RootViewController.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppController.h"

@interface RootViewController () <MMSTableViewControllerCellUpdating>

@property (strong, nonatomic) IBOutlet MMSUpdatingTableViewControllerFetchedResultsSupport *fetchedResultsSupport;

@end

@implementation RootViewController

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
   // 
//    [self.fetchedResultsController objectAtIndexPath:nil];
    Venue *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self updateCell:cell withObject:object];
}

- (void)updateCell:(UITableViewCell *)cell withObject:(Venue *)object{
    cell.textLabel.text = object.timestamp.description;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", object.numberOfEvents];
}

- (NSManagedObjectContext *)managedObjectContext{
    AppController *appController = (AppController *)UIApplication.sharedApplication.delegate;
    return appController.persistentContainer.viewContext;
}

- (IBAction)pauseTapped:(id)sender{
   // self.fetchedResultsController.delegate = nil;
}

- (IBAction)playTapped:(id)sender{
//    self.fetchedResultsController.delegate = self;
//    [self.fetchedResultsController performFetch:nil];
//    [self.tableView reloadData];
    //id i = self.fetchedResultsController;
   // [self.persistentContainer.viewContext save:nil];
}

- (IBAction)refreshTapped:(id)sender{
    Venue *object = self.fetchedResultsController.fetchedObjects.firstObject;
    object.timestamp = NSDate.date;
    
    // Save the context.
    NSError *error = nil;
    if (![object.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

//- (IBAction)deleteVenue:(MUICompletionStoryboardSegue *)unwindSegue {
//    Venue *venue;
//    if([unwindSegue.sourceViewController isKindOfClass:DetailViewController.class]){
//        DetailViewController *detailViewController = unwindSegue.sourceViewController;
//        venue = detailViewController.detailItem.venue;
//    }
//    else if([unwindSegue.sourceViewController isKindOfClass:MasterViewController.class]){
//        MasterViewController *masterViewController = unwindSegue.sourceViewController;
//        venue = masterViewController.masterItem;
//    }
//    
//    // Use data from the view controller which initiated the unwind segue
//    [unwindSegue setCompletion:^{
//        [self.managedObjectContext deleteObject:venue];
//        [self.managedObjectContext save:nil];
//    }];
//}

- (void)viewDidLoad {
    NSParameterAssert(self.managedObjectContext);
    [super viewDidLoad];
    self.fetchedResultsSupport.fetchedResultsController = self.fetchedResultsController;
}


#pragma mark Fetch Controller

//- (NSFetchedResultsController<Venue *> *)newFetchedResultsController {
- (NSFetchedResultsController<Venue *> *)fetchedResultsController {
    NSParameterAssert(self.managedObjectContext);
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    NSFetchRequest<Venue *> *fetchRequest = Venue.fetchRequest;
  //  fetchRequest.predicate = [NSPredicate predicateWithFormat:@"timestamp = nil"];
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    //_fetchedResultsController.delegate = self;
    
                NSError *error = nil;
                if (![_fetchedResultsController performFetch:&error]) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
                // do we need a perform fetch?
  
   // super.fetchedResultsController = fetchedResultsController;
     //   self.fetchedResultsController = aFetchedResultsController;
   
    return _fetchedResultsController;
//    self.fetchedResultsController = fetchedResultsController;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return sectionInfo.numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@ %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    return [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


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

- (void)viewWillAppear:(BOOL)animated{
    //self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
 
    
//    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:self.masterViewController.masterItem];
//    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];;
//    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        //[self.tableView cellForRowAtIndexPath:indexPath];
//    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//
//    }];
//[self.tableView reloadData];
    //if(self.isMov)
 //   [self.tableView endUpdates];
    [super viewWillAppear:animated];
//    self.fetchedResultsController.delegate = self;
    
    for(UITableViewCell *cell in self.tableView.visibleCells){
      //  NSLog(@"");
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
  //  self.dataImpl.fetchedResultsController = nil;
  //  [self.tableView beginUpdates];
}

- (void)configureView{
 //   self.title = [NSString stringWithFormat:@"%ld Venues", self.fetchedResultsController.fetchedObjects.count];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  //  [self updateMasterViewController];
}

//- (void)updateMaster{
//    if(![self.fetchedResultsController indexPathForObject:self.masterViewController.masterItem]){
//        [self.navigationController popToViewController:self animated:YES];
//    }
//}

- (IBAction)insertNewObject:(id)sender {
    NSManagedObjectContext *context =   self.managedObjectContext; // self.persistentContainer.newBackgroundContext;
    Venue *newObject = [Venue.alloc initWithContext:context]; // self.fetchedResultsController.fetchedObjects.lastObject ;//
        
    // If appropriate, configure the new managed object.
    newObject.timestamp = [NSDate date];
        
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
//    if(self.detailViewController){
//        self.objectToShow = newEvent;
//        [self performSegueWithIdentifier:@"showDetail" sender:self];
//        [self configureView];
//    }
}

#pragma mark - data

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"show"]){
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        Venue *venue = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
        MasterViewController *mvc = segue.destinationViewController;
        //mvc.persistentContainer = self.persistentContainer;
        mvc.masterItem = venue;
      //  mvc.selectedObject = [self mui_currentVisibleDetailItemWithSender:self];
        //mvc.detailViewController = self.masterViewController.detailViewController;
        //mvc.selectedObject = self.masterViewController.detailViewController.detailItem;
        
        //mvc.detailViewControllerDetailItem = self.masterViewController.detailViewControllerDetailItem;
        //mvc.restorationClass = self.class;
        
    //    if(self.splitViewController.viewControllers.count == 2){
    //        mvc.selectedObject = ((DetailViewController *)self.splitViewController.viewControllers.lastObject.childViewControllers.firstObject).detailItem;
    // }
        self.masterViewController = mvc;
    }
}


@end
