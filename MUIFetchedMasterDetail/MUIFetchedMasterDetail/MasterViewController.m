//
//  MasterViewController.m
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 16/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppController.h"

@interface MasterViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>//, UIViewControllerRestoration> // MUIFetchedTableViewControllerDelegate, MCDManagedObjectChangeControllerDelegate

@property (strong, nonatomic, null_resettable) MMSManagedObjectChangeController *masterItemChangeController;
@property (strong, nonatomic, null_resettable) NSFetchedResultsController<Event *> *fetchedResultsController;
//@property (strong, nonatomic) MUIFetchedTableViewController *fetchedTableViewController;

//@property (assign, nonatomic) BOOL isTopViewController;
@property (strong, nonatomic) UIBarButtonItem *addButton;
@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) MMSFetchedResultsTableViewAdapter *eventsTableViewAdapter;

@end

@implementation MasterViewController

- (void)insertNewObject:(id)sender {
   
    NSManagedObjectContext *context = self.managedObjectContext;
    Event *newEvent =  [[Event alloc] initWithContext:context]; // self.fetchedResultsController.fetchedObjects.lastObject ;//
        
    // If appropriate, configure the new managed object.
    newEvent.timestamp = [NSDate date];
    newEvent.venue = self.masterItem;
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
//    if(self.detailViewController){
//        self.selectedObject = newEvent;
//        [self performSegueWithIdentifier:@"showDetail" sender:self];
//        [self configureView];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eventsTableViewAdapter = [MMSFetchedResultsTableViewAdapter.alloc initWithTableView:self.tableView];
    self.eventsTableViewAdapter.fetchedResultsController = self.fetchedResultsController;
    //NSAssert(self.mui_persistentContainer, @"requires persistentContainer");
    
    // Do any additional setup after loading the view.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(buttonTapped:)];
    NSArray *rightBarButtonItems = @[self.addButton, self.editButtonItem]; // button
//    [rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        //obj.enabled = NO;
//    }];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    
   
    
    //self.fetchedTableViewController.fetchedResultsController = self.fetchedResultsController;
    //self.fetchedTableViewController.tableView.delegate = self;
    //self.fetchedTableViewController.tableView.dataSource = self; // these can't be done until the self.fetchedTableViewController is set so the forwarding works.
    
   // [self configureView];
}

- (NSManagedObjectContext *)managedObjectContext{
    AppController *appController = (AppController *)UIApplication.sharedApplication.delegate;
    return appController.persistentContainer.viewContext;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    Event *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //Event *event = (Event *)object;
    cell.textLabel.text = event.timestamp.description;
}

#pragma mark - Table Data

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.textLabel.opaque = NO;
//    cell.textLabel.backgroundColor = UIColor.clearColor;
//    return cell;
//}

#pragma mark - Fetched results controller

- (NSFetchedResultsController<Event *> *)fetchedResultsController {
//- (void)createFetchedResultsController{
  //  id i = self.parentViewController;
    //NSPersistentContainer *pc = [self mcd_persistentContainerWithSender:self];
    //NSManagedObjectContext *moc = pc.viewContext;
    //    NSAssert(moc, @"createFetchedResultsController called without managedObjectContext");
    if (!_fetchedResultsController) {
        
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
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        //fetchedResultsController.delegate = self;

        NSError *error = nil;
        if (![_fetchedResultsController performFetch:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
    return _fetchedResultsController;
}

- (IBAction)trashVenue:(id)sender{
    NSManagedObjectContext *moc = self.managedObjectContext;
    [moc deleteObject:self.masterItem];
    [moc save:nil];
    
  //  [self performSelector:@selector(aaa) withObject:nil afterDelay:5];
}

/*
 
 
//@synthesize fetchedResultsController = _fetchedResultsController;
//@dynamic detailViewController;
//@dynamic persistentContainer;

//- (PersistentContainer *)persistentContainer{
//    PersistentContainer *pc = [self mcd_persistentContainerWithSender:self];
//    return pc;
//}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.restorationClass = self.class;
}


- (instancetype)initWithCoder:(NSCoder *)coder masterItem:(Venue *)masterItem{
    self = [super initWithCoder:coder];
    if (self) {
        _masterItem = masterItem;
    }
    return self;
}



- (void)aaa{
  //  NSManagedObjectContext *moc;// = self.persistentContainer.viewContext;
  //  [moc deleteObject:self.fetchedResultsController.fetchedObjects.firstObject];
 //   [moc save:nil];
}

//- (MCDManagedObjectChangeController *)masterItemChangeController{
//    if(!_masterItemChangeController){
//        NSPersistentContainer *pc = [self mcd_persistentContainerWithSender:self];
//        _masterItemChangeController = [MCDManagedObjectChangeController.alloc initWithManagedObject:self.masterItem managedObjectContext:pc.viewContext];
//    }
//    return _masterItemChangeController;
//}

- (void)setMasterItem:(Venue *)masterItem{
    if(masterItem == _masterItem){
        return;
    }
    _masterItem = masterItem;
    self.masterItemChangeController = nil;
   // [NSFetchedResultsController deleteCacheWithName:@"Master"];
    //self.fetchedResultsController = nil;
    if(self.isViewLoaded){
//        [self createFetchedResultsController];
    }
}



//- (DetailViewController *)detailViewController{
//    DetailViewController *detailViewController;
//    if(self.splitViewController.viewControllers.count == 2){ // it might not be collapsed right now but it is during state restoration
//        detailViewController = ((UINavigationController *)self.splitViewController.viewControllers.lastObject).viewControllers.firstObject;
//    }
//    else if([self.navigationController.topViewController isKindOfClass:UINavigationController.class]){
//        detailViewController = ((UINavigationController *)self.navigationController.topViewController).viewControllers.firstObject;
//    }
//    return detailViewController;
//}

// this can't set anything
- (void)configureView{
    NSAssert(self.masterItem, @"Configure view called without masteritem");
  
    //self.masterItemChangeController.delegate = self;
    
    
    //BOOL a = self.masterItem.isDeleted;
    //BOOL b = self.masterItem.managedObjectContext;
//    BOOL isValid = !self.masterItemChangeController.isDeleted; //  !self.masterItem.isDeleted || self.masterItem.managedObjectContext;
    
    //!self.masterItem.isDeleted && self.masterItem.timestamp;
    //self.editButtonItem.enabled = isValid && self.countOfFetchedObjects && !self.isEditingRow;
    self.addButton.enabled = YES;//isValid && !self.isEditingRow && !self.isEditing;
    //self.title = isValid ? [NSString stringWithFormat:@"%@ Items", self.countOfFetchedObjects] : nil;
}

- (void)buttonTapped:(id)sender{
    //[self.fetchedTableViewController.tableView setEditing:NO animated:YES];
//    Event *e = self.detailViewController.detailItem;
//    e.timestamp = NSDate.date;
//    [self.persistentContainer.viewContext save:nil];
    
//   self.fetchedTableViewController.fetchedResultsController = self.fetchedResultsController;
// [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
//    if(!self.fetchedResultsController){
//        [self createFetchedResultsController];
//    }

   // [self configureView];
   // self.fetchedTableViewController.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    
    
    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        NSLog(@"is cancelled %ld", context.isCancelled);
    }];
}



- (void)detailViewControllerDidDelete:(DetailViewController *)detailViewController{
    //[self.navigationController popToViewController:self animated:YES];
}

- (void)showViewControllerForObject:(NSManagedObject *)object{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (IBAction)unwindToMaster:(UIStoryboardSegue *)unwindSegue {
    
}

//- (IBAction)deleteEvent:(MUICompletionStoryboardSegue *)unwindSegue {
//    DetailViewController *detailViewController = unwindSegue.sourceViewController;
//    // Use data from the view controller which initiated the unwind segue
//
//    [unwindSegue setCompletion:^{
//        NSPersistentContainer *pc = [self mcd_persistentContainerWithSender:self];
//        [pc.viewContext deleteObject:detailViewController.detailItem];
//        [pc.viewContext save:nil];
//    }];
//}

#pragma mark - Segues

//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    if(self.isEditing){
//        return NO;
//    }
//    
//    return YES;
//}

// here the controller for teh object has already been chosen so we can't be selecting different index paths.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        Event *object;
//        if([sender isKindOfClass:UITableView.class]){
//            NSIndexPath *indexPath = [self.fetchedTableViewController.tableView indexPathForSelectedRow];
//            object = [self.fetchedResultsController objectAtIndexPath:indexPath];
//        }else{
            object = self.selectedObject;
//        }
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        if(object){
            controller.detailItem = object;
        }
        //controller.delegate = self;
        //self.detailViewController = controller;
    }
    else if([segue.identifier isEqualToString:@"embed"]){
        MasterFetchedTableViewController *vc = segue.destinationViewController;
        vc.delegate = self;
        vc.masterItem = self.masterItem;
        //vc.fetchedResultsController = self.fetchedResultsController;
        self.fetchedTableViewController = vc;
    }
    else if([segue.identifier isEqualToString:@"showTest"]){
        
    }
}


// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}


- (void)controller:(MCDManagedObjectChangeController *)controller didChange:(MCDManagedObjectChangeType)type{
    NSLog(@"");
}


#pragma mark - UIStateRestoration

//#define kModelIdentifierForSelectedElementKey @"ModelIdentifierForSelectedElement"
#define kMasterItemKey @"MasterItem"
#define kSelectedObjectKey @"SelectedObject"

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    //[coder encodeObject:self.managedObjectContext forKey:kManagedObjectContextKey];
    [coder encodeObject:self.masterItem.objectID.URIRepresentation forKey:kMasterItemKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
}

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    MasterViewController *vc = nil;
    NSLog(@"MasterViewController: viewControllerWithRestorationIdentifierPath");
    NSString *restorationIdentifier = identifierComponents.lastObject;
    // get our main storyboard
    UIStoryboard *storyboard = [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
    if (!storyboard){
        return nil;
    }
    NSPersistentContainer *pc = [coder decodeObjectForKey:@"PersistentContainer"];
    if(!pc){
        return nil;
    }
    NSURL *objectURI = [coder decodeObjectForKey:kMasterItemKey];
    NSManagedObject *masterItem = [pc.viewContext mcd_existingObjectWithURI:objectURI error:nil];
    if(!masterItem){
        return nil;
    }
    

    
//    if (@available(iOS 13.0, *)) {
//        vc = [storyboard instantiateViewControllerWithIdentifier:restorationIdentifier creator:^__kindof UIViewController * _Nullable(NSCoder * _Nonnull coder) {
//            return [MasterViewController.alloc initWithCoder:coder masterItem:masterItem persistentContainer:pc];
//        }];
//    } else {
        // Fallback on earlier versions
        vc = [storyboard instantiateViewControllerWithIdentifier:restorationIdentifier];
        vc.masterItem = masterItem;
       // vc.persistentContainer = pc;
        //vc.selectedObject = selectedObject;
//    }
//    vc = (MasterViewController *)[storyboard instantiateViewControllerWithIdentifier:restorationIdentifier];
//    vc.restorationIdentifier = restorationIdentifier;
//    vc.restorationClass = self;
    NSLog(@"vc.restorationIdentifier %@", vc.restorationIdentifier);
    return vc;
}
*/

@end
