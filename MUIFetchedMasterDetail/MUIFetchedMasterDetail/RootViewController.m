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

@interface RootViewController () <MMSFetchedResultsTableViewController>

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) MMSFetchedResultsTableViewControllerImpl *fetchedResultsTableViewControllerImpl;

@end

@implementation RootViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        _fetchedResultsTableViewControllerImpl = [MMSFetchedResultsTableViewControllerImpl.alloc initWithTableViewController:self];
    }
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
   // if(MMSProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
//        if([self.delegate respondsToSelector:aSelector]){
//            return self.delegate;
//        }
 //   }
    if(MMSProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
        return self.fetchedResultsTableViewControllerImpl;
    }
    else if(MMSProtocolHasInstanceMethod(@protocol(NSFetchedResultsControllerDelegate), aSelector)){
        return self.fetchedResultsTableViewControllerImpl;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if([super respondsToSelector:aSelector]){
        return YES;
    }
//    else if(MMSProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
//        return [self.delegate respondsToSelector:aSelector];
//    }
    if(MMSProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
        return [self.fetchedResultsTableViewControllerImpl respondsToSelector:aSelector];
    }
    else if(MMSProtocolHasInstanceMethod(@protocol(NSFetchedResultsControllerDelegate), aSelector)){
        return [self.fetchedResultsTableViewControllerImpl respondsToSelector:aSelector];
    }
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.fetchedResultsTableViewControllerImpl tableView:tableView cellForRowAtIndexPath:indexPath];
}

// must override the table view controller's impl
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.fetchedResultsTableViewControllerImpl numberOfSectionsInTableView:tableView];
}

// must override the table view controller's impl
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.fetchedResultsTableViewControllerImpl tableView:tableView numberOfRowsInSection:section];
}

- (void)updateCell:(UITableViewCell *)cell withObject:(Venue *)object{
    cell.textLabel.text = object.title;
    cell.detailTextLabel.text = object.subtitle;
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
    //NSAssert(self.persistentContainer, @"This view needs a persistent container.");
    // Do any additional setup after loading the view.
 //   [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(navigationControllerDidShowViewController:) name:MUINavigationControllerDidShowViewControllerNotification object:self.navigationController];
 //   [self createFetchedResultsController];
    
    [self configureView];
}



- (void)viewWillAppear:(BOOL)animated{
    //self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
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
  //      self.masterViewController = mvc;
    }
}

//- (void)setMasterViewController:(MasterViewController *)masterViewController{
//    if(masterViewController == _masterViewController){
//        return;
//    }
//    else if(_masterViewController.parentViewController == self){
//        [_masterViewController removeFromParentViewController];
//    }
//    _masterViewController = masterViewController;
//    id i = masterViewController.parentViewController;
//    [self updateMasterViewController];
//}

//- (void)updateMasterViewController{
//    if(!self.masterViewController){
//        return;
//    }
//    else if(self.masterViewController.parentViewController){
//        return;
//    }
//    [self addChildViewController:self.masterViewController];
//}

//- (void)navigationControllerDidShowViewController:(NSNotification *)notification{
//    NSDictionary *userInfo = notification.userInfo;
//    if(userInfo[MUINavigationControllerNextVisibleViewController] != self){
//        return;
//    }
//    else if(!self.masterViewController){
//        return;
//    }
//    if(userInfo[MUINavigationControllerLastVisibleViewController] != self.masterViewController){
//        return;
//    }
//}

//- (MMSFetchedResultsTableViewControllerImpl *)fetchedResultsTableViewControllerImpl{
//    if(_fetchedResultsTableViewControllerImpl){
//        return _fetchedResultsTableViewControllerImpl;
//    }
//    _fetchedResultsTableViewControllerImpl = [MMSFetchedResultsTableViewControllerImpl.alloc init];//WithTableView:self.tableView];
//    _fetchedResultsTableViewControllerImpl.fetchedResultsController = self.fetchedResultsController;
//    _fetchedResultsTableViewControllerImpl.delegate = self;
//    
//    return _fetchedResultsTableViewControllerImpl;
//}

#pragma mark Fetch Controller

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
    _fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
   // super.fetchedResultsController = fetchedResultsController;
     //   self.fetchedResultsController = aFetchedResultsController;
   
    return _fetchedResultsController;
//    self.fetchedResultsController = fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.fetchedResultsTableViewControllerImpl controllerWillChangeContent:controller];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)object atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    [self.fetchedResultsTableViewControllerImpl controller:controller didChangeObject:object atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.fetchedResultsTableViewControllerImpl controllerDidChangeContent:controller];
 //   [self configureView];
 //   [self updateMaster];
}

#pragma mark - UIStateRestoration

#define kMasterViewControllerKey @"MasterViewController"
//#define kManagedObjectContextKey @"ManagedObjectContext"


//#define kModelIdentifierForSelectedElementKey @"ModelIdentifierForSelectedElement"
//#define kSelectedMasterObjectKey @"kSelectedMasterObjectKey"

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
 //   [coder encodeObject:self.masterViewController forKey:kMasterViewControllerKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
//    self.masterViewController = [coder decodeObjectForKey:kMasterViewControllerKey]; // it doesnt have the detail item
}

- (void)applicationFinishedRestoringState{
   // [self.tableView layoutIfNeeded]; // fix going back unlight bu
   // [self reselectTableRowIfNecessary];
    
    // we need the master item to have been decoded
    // pop back if the master is no longer in the list.
    //[self updateMaster];
}

//- (void)fetchedResultsViewUpdater:(MMSTableViewFetchedResults *)fetchedResultsViewUpdater updateCell:(UITableViewCell *)cell withObject:(id)object{
//
//}

@end

//@interface UITableViewCell(Root)<MMSTableViewCellConfiguring>
//
//@end
//
//@implementation UITableViewCell (Root)
//
//- (void)configureWithObject:(Venue *)venue{
//
//}
//
//@end
