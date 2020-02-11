//
//  MiddleViewController.m
//  TableContainerTest
//
//  Created by Malcolm Hall on 24/01/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MiddleViewController.h"
//#import "MiddleTableViewController.h"
//#import "EndViewController.h"
//#import "SelectedItemController.h"
#import "MiddleNavigationController.h"
#import "OuterSplitViewController.h"

static NSString *kMiddleItemStateKey = @"MiddleItemState";
static NSString *kManagedObjectContextStateKey = @"ManagedObjectContextState";
//static NSString *kMiddleTableViewControllerStateKey = @"MiddleTableViewController";
static NSString *kMiddleEndSelectedItemControllerStateKey = @"MiddleEndSelectedItemController";

@interface MiddleViewController ()

//@property (class, strong, nonatomic) UIView *snapshot;
@property (assign, nonatomic) BOOL useDeleteSegue;
//@property (strong, nonatomic) MiddleTableViewController *middleTableViewController;

@end

@implementation MiddleViewController
//@dynamic detailViewController;

//- (BOOL)willShowingDetailViewControllerPush{
//    return [self mui_willShowingDetailDetailViewControllerPushWithSender:self];
//}

//- (NSManagedObject *)currentDetailItem{
//    return [self mui_currentDetailDetailItemWithSender:self];
//}

- (id)mui_containedDetailItem{
    return self.detailItem;
}

//- (void)setEndViewController:(EndViewController *)endViewController{
//    if(self.detailViewController == endViewController){
//        return;
//    }
//    self.detailViewController = endViewController;
//}

//- (EndViewController *)endViewController{
//    return (EndViewController *)self.detailViewController;
//}DetailViewController

- (void)showViewControllerForObject:(NSManagedObject *)object{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (void)deleteObject:(id)sender{
  //  [self.delegate middleViewControllerDeleteTapped:self];
    //self.class.snapshot = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
    
    //[self.delegate middleViewController:self didFinishWithSave:YES];
    NSManagedObjectContext *moc = self.detailItem.managedObjectContext;
    [moc deleteObject:self.detailItem];
    [moc save:nil];
}

- (void)setDetailItem:(Venue *)detailItem{
    if(detailItem == _detailItem){
        return;
    }
    _detailItem = detailItem;
  //  MiddleNavigationController *dnc = (MiddleNavigationController *)self.navigationController;
  //  dnc.selectedItem = detailItem;
    //dnc.detailItem = detailItem;
    
    [self configureBars];
    
    
    if(self.isViewLoaded){
        [self createFetchedResultsController];
        //[self configureView];
    }
}

//- (void)setMiddleItem:(Venue *)detailItem targetSplitViewController:(UISplitViewController *)splitViewController shownDetailNavigationController:(DetailNavigationController *)detailNavigationController{
//
//
//    self.targetSplitViewController = splitViewController;
//    self.detailItem = detailItem;
//    self.shownDetailNavigationController = detailNavigationController;
//
//
//}

- (void)configureView{
    //self.middleTableViewController.selectedItemController = self.middleEndSelectedItemController;
    if(self.detailItem){
        //[self createFetchedResultsController];
    }
}

//- (NSFetchedResultsController<Event *> *)fetchedResultsController {
- (void)createFetchedResultsController{
    //    if (_fetchedResultsController != nil) {
    //        return _fetchedResultsController;
    //    }
    //    else if(!self.managedObjectContext){
    //        return nil;
    //    }
    //    else if(!self.detailItem){
    //        return nil;
    //    }
    //    if(!self.detailItem){
    //        return;
    //    }
    
    NSFetchedResultsController<Event *> *aFetchedResultsController;
    if(self.detailItem){
        NSFetchRequest<Event *> *fetchRequest = DetailItem.fetchRequest;
        
        // Set the batch size to a suitable number.
        [fetchRequest setFetchBatchSize:20];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
        
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        //if(self.detailItem){
        // NSAssert(self.detailItem, @"Must have venue");
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"venue == %@", self.detailItem];
        //}
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil]; // @"Master"
        aFetchedResultsController.delegate = self;
        
        NSError *error = nil;
        if (![aFetchedResultsController performFetch:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
    // _fetchedResultsController = aFetchedResultsController;
    // return _fetchedResultsController;
    //self.fetchedResultsController = aFetchedResultsController;
    self.fetchedResultsController = aFetchedResultsController;
}

- (void)configureBars{
    self.navigationItem.title = self.detailItem.name;
    self.deleteBarButtonItem.enabled = YES;
    self.addButtonItem.enabled = YES;
    self.editButtonItem.enabled = YES;
    self.addEmployeeButtonItem.enabled = YES;
}

- (NSManagedObjectContext *)managedObjectContext{
//    if(!_managedObjectContext){
//        _managedObjectContext = self.middleItemManagedObjectContext;
//    }
//    return _managedObjectContext;
    return self.detailItem.managedObjectContext;
}

- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = self.managedObjectContext;//[self.fetchedResultsController managedObjectContext];
    Event *newEvent;
    if(sender == self.addEmployeeButtonItem){
        newEvent = [Employee.alloc initWithContext:context];
    }else{
        newEvent = [Event.alloc initWithContext:context];
    }
    
    // If appropriate, configure the new managed object.
    newEvent.timestamp = [NSDate date];
    newEvent.venue = self.detailItem;
    
    NSArray *names = [NSArray arrayWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"BandNames" ofType:@"plist"]];
    uint32_t rnd = arc4random_uniform((uint32_t)names.count);
    if(sender == self.addEmployeeButtonItem){
        newEvent.name = @"Bob";
    }else{
        newEvent.name = [names objectAtIndex:rnd];
    }
    //
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    // self.detailItemForSegue = newEvent;
    // [self performSegueWithIdentifier:@"showEmployee" sender:sender];
    // [self updateRowSelectionForCurrentDetailItem];
}

- (void)showObject:(NSManagedObject *)object{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"awakeFromNib %@", self);
    self.navigationItem.leftItemsSupplementBackButton = YES;
    self.navigationItem.leftBarButtonItems = @[self.editButtonItem];
    self.editButtonItem.enabled = NO;
    self.addEmployeeButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(insertNewObject:)];
    self.addEmployeeButtonItem.enabled = NO;
    
    self.addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.addButtonItem.enabled = NO;
    self.deleteBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteObject:)];
    self.deleteBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItems = @[self.addEmployeeButtonItem, self.addButtonItem, self.deleteBarButtonItem];
    
//    UISplitViewController *splitViewController = self.splitViewController;
//    if(splitViewController){
//        SelectedItemController *selectedItemController = [SelectedItemController.alloc initWithSplitViewController:splitViewController detailViewController:self];
//    }
    //self.detailItem= self.detailNavigationController.detailItem;
}

- (void)configureCell:(UITableViewCell *)cell withObject:(DetailItem *)object {
    cell.textLabel.text = object.name;
    cell.detailTextLabel.text = object.timestamp.description;
}

// embed segue and the tables viewdidload is done before this.
- (void)viewDidLoad {
    [super viewDidLoad];
    //[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(detailNavigationControllerDetailItemDidChange:) name:MiddleNavigationControllerDetailItemDidChange object:self.detailNavigationController];
    //self.detailItem = (Venue *)self.detailNavigationController.detailItem;
    
//    OuterSplitViewController *outerSplitViewController = self.outerSplitViewController;
//    SelectedItemController *selectedItemController = outerSplitViewController.selectedItemController;
//    if(!selectedItemController){
//        selectedItemController = [SelectedItemController.alloc initWithSplitViewController:outerSplitViewController];
//    }
//    self.selectedItemController = selectedItemController;
    
    [self createFetchedResultsController];
    //[self configureView];
}

//- (void)configureView{
    
   // self.middleTableViewController.fetchedResultsController = self.fetchedResultsController;
    //self.middleTableViewController.fetchedResultsController = self.fetchedResultsController;
//}

//- (void)configureTable{
//    if(!self.fetchedResultsController){
//        return;
//    }
//    self.middleTableViewController.fetchedResultsController = self.fetchedResultsController;
//    id a = self.fetchedResultsController.fetchedObjects;
//    id selectedItem = self.middleEndSelectedItemController.detailViewController.selectedItem;
//    self.middleTableViewController.selectedItem = selectedItem;
//}

- (void)viewWillAppear:(BOOL)animated{
//    if(!self.fetchedResultsController){
//        [self createFetchedResultsController];
//        [self configureTable];
//    }
    [super viewWillAppear:animated];
   // self.navigationController.toolbarHidden = NO;
}


//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    BOOL b = self.isMovingFromParentViewController;
//    BOOL c = self.navigationController.isMovingFromParentViewController;
//    
//    if(c){
//        
//        self.selectedItemControllerForDetail.detailViewController = nil;
//    }
//    
//    NSLog(@"");
//}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
}

#pragma mark - Navigation

//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//
//    self.objectForSegue = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
//    return YES;
//}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath;
//        if([sender isKindOfClass:UITableViewCell.class]){
//            indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
//        }else if([sender isKindOfClass:NSIndexPath.class]){
//            indexPath = (NSIndexPath *)sender;
//        }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //MiddleTableViewController *controller = segue.destinationViewController;
    //self.middleTableViewController = controller;
        MiddleNavigationController *nav = segue.destinationViewController;
   // [self configureMiddleNavigationController:nav];
        
        EndViewController *endViewController = (EndViewController *)nav.topViewController;
        endViewController.detailItem = self.selectedObject;
        //endViewController.navigationItem.leftBarButtonItem = self.outerSplitViewController.displayModeButtonItem;
        //self.shownDetailNavigationController = nav;
        //self.shownDetailViewController = endViewController;
    }
    else if([segue.identifier isEqualToString:@"embed"]){
        MUIFetchedTableViewController *vc = segue.destinationViewController;
        vc.delegate = self;
        //vc.fetchedResultsController = self.fetchedResultsController;
        self.fetchedTableViewController = vc;
    }
    //EndViewController *controller = [nav topViewController];
}



//- (MiddleNavigationController *)recreateDetailViewControllerForSelectedItemController:(SelectedItemController *)selectedItemController{
 //   MiddleNavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"EndNavigationController"];
    //
    //self.selectedItemController.detailViewController = detailViewController;
//    [self configureMiddleNavigationController:nav];
    
//    return nav;
//}

//- (void)configureMiddleNavigationController:(MiddleNavigationController *)nav{
//    EndViewController *detailViewController = (EndViewController *)nav.topViewController;
   // detailViewController.endItem = self.selectedItem;
  //  self.selectedItemController.detailViewController = nav;
    
//}


//- (void)setMiddleTableViewController:(MiddleTableViewController *)middleTableViewController{
//    //id i = self.middleEndSelectedItemController;
//    //self.middleEndSelectedItemController.masterViewController = middleTableViewController;
//    //middleTableViewController.outerSelectedItemController = self.outerSelectedItemController;
//    //self.selectedItemControllerForMaster.detailViewController = middleTableViewController;
//  //  _middleTableViewController = middleTableViewController;
//}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    //[self.middleTableViewController setEditing:editing animated:animated];
    [self.childViewControllers.firstObject setEditing:editing animated:animated];
}

//- (void)selectRowForCurrentDetailItem{
//    id object = self.selectedItemControllerForMaster.detailViewController.detailItem;// self.detailViewController.detailItem;
//    NSIndexPath *indexPath = [self.middleTableViewController.fetchedResultsController indexPathForObject:object];
//    [self.middleTableViewController.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:0];
//}

//- (id)detailItem{
//    return self.detailItem;
//}


- (void)dealloc
{
    NSLog(@"dealloc");
}

#pragma mark - State Restoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject:self.managedObjectContext forKey:kManagedObjectContextStateKey];
    [coder encodeObject:self.detailItem.objectID.URIRepresentation forKey:kMiddleItemStateKey];
    // [coder encodeObject:self.middleEndSelectedItemController.masterViewController forKey:kMiddleTableViewControllerStateKey]; // needed for it to be encoded.
    // [coder encodeObject:self.middleEndSelectedItemController forKey:kMiddleEndSelectedItemControllerStateKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
    [super decodeRestorableStateWithCoder:coder];
    id i = self.navigationController;
    // self.middleEndSelectedItemController = [coder decodeObjectForKey:kMiddleEndSelectedItemControllerStateKey];
    //  self.middleEndSelectedItemController.masterViewController = [coder decodeObjectForKey:kMiddleTableViewControllerStateKey];
    
    //self.middleTableViewController = [coder decodeObjectForKey:@"MiddleTableViewController"];
    NSManagedObjectContext *managedObjectContext = [coder decodeObjectForKey:kManagedObjectContextStateKey];
    NSURL *objectURI = [coder decodeObjectForKey:kMiddleItemStateKey];
    if(objectURI){
        NSManagedObject *object = [managedObjectContext mcd_existingObjectWithURI:objectURI error:nil];
        if(object){
            //[master setMasterItem:object deleteCache:NO];
            self.detailItem = object;
        }
    }
}


@end
