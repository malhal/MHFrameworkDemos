//
//  MasterTableViewController.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 05/03/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MasterTableViewController.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "PersistentContainer.h"
#import "FetchedResultsController.h"
#import <objc/runtime.h>
#import "MasterTableDataSource.h"
#import "DetailPageViewController.h"
#import "MasterNavigationController.h"

static void * const kMasterTableKVOContext = (void *)&kMasterTableKVOContext;

@interface MasterTableViewController () //<MUIFetchedPageViewControllerDelegate>

@end

@implementation MasterTableViewController

//- (id)pageObject{
//    return self.venue;
//}

//- (void)setVenue:(Venue *)venue{
//    if(venue == _venue){
//        return;
//    }
//    _venue = venue;
//    
//}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.clearsSelectionOnViewWillAppear = NO;
    [self.navigationController addObserver:self forKeyPath:@"selectedObject" options:0 context:kMasterTableKVOContext];
    //[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(masterNavigationControllerDidChangeSelectedObject:) name:MasterNavigationControllerDidChangeSelectedObject object:nil];
    
     
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[NSNotificationCenter.defaultCenter removeObserver:self name:MasterNavigationControllerDidChangeSelectedObject object:nil];
    id i = self.navigationController ;
    [self.navigationController removeObserver:self forKeyPath:@"selectedObject"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //self.editing = YES;
    
    MasterNavigationController *masterNav = self.navigationController;
    NSIndexPath *indexPath = [self.fetchedResultsTableViewAdapter.fetchedResultsController indexPathForObject:masterNav.selectedObject];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)viewDidLoad{
    [super viewDidLoad];
 //   self.tableView.allowsMultipleSelection = YES;
 //   self.fetchedResultsController = [self newFetchedResultsController];
    
    self.fetchedResultsTableViewAdapter = self.newFetchedTableDataSource;
  

}


- (void)masterNavigationControllerDidChangeSelectedObject:(NSNotification *)notification{
    MasterNavigationController *masterNav = self.navigationController;
    NSIndexPath *indexPath = [self.fetchedResultsTableViewAdapter.fetchedResultsController indexPathForObject:masterNav.selectedObject];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kMasterTableKVOContext) {
        MasterNavigationController *masterNav = self.navigationController;
        NSIndexPath *indexPath = [self.fetchedResultsTableViewAdapter.fetchedResultsController indexPathForObject:masterNav.selectedObject];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (MasterTableDataSource *)newFetchedTableDataSource{
    id i = self.fetchedPageObject;
    NSFetchRequest *fetchRequest = [ListItem fetchRequestWithParentListItem:self.fetchedPageObject];
    NSFetchedResultsController * fetchedResultsController = [NSFetchedResultsController.alloc initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    fetchedResultsController.delegate = self;
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    MasterTableDataSource *dataSource = [MasterTableDataSource.alloc initWithFetchedResultsController:fetchedResultsController];
    //dataSource.cellIdentifiersByClassName = @{@"Venue" : @"Venue", @"Event" : @"Event"};
    return dataSource;
}

#pragma mark - Fetched results controller

//- (NSFetchedResultsController<Event *> *)newFetchedResultsController {
//    if (_fetchedResultsController != nil) {
//        return _fetchedResultsController;
//    }
//
    //_fetchedResultsController = aFetchedResultsController;
  //  NSFetchRequest *fetchRequest = Event.myFetchRequest;
   // if(self.venue){
 //   fetchRequest.predicate = [NSPredicate predicateWithFormat:@"parentVenue = %@", self.venue];
   // }
    
 //   FetchedResultsController * fetchedResultsController = [[FetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.persistentContainer.viewContext sectionNameKeyPath:nil cacheName:nil];
 //   fetchedResultsController.delegate = self;
  //     [fetchedResultsController performFetch:nil];
   // _fetchedResultsController.delegate = self;
    //_fetchedResultsController = [self.persistentContainer newFetchedResultsController];
    
//    return fetchedResultsController;
//}

#pragma mark - Table View


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = self.managedObjectContext;
        [context deleteObject:[self objectAtIndexPath:indexPath]];
            
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



#pragma mark - Segues

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier hasPrefix:@"show"]) {
        return !self.isEditing;
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {

        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        Event *event = [self.fetchedResultsTableViewAdapter.fetchedResultsController objectAtIndexPath:indexPath];
        
        UINavigationController *detailNavigationController = (UINavigationController *)segue.destinationViewController;
        
        DetailPageViewController *controller = (DetailPageViewController *)detailNavigationController.topViewController;
        //controller.selection = self.selection;
        //controller.persistentContainer = self.persistentContainer;
        controller.managedObjectContext = self.managedObjectContext;
        //controller.selectedPageObject = event;
        controller.parentListItem = self.fetchedPageObject;
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        controller.delegate = self.navigationController;
        
        //self.selectedObject = event;
        
        MasterNavigationController *masterNav = self.navigationController;
        masterNav.selectedObject = event;
        
        //self.detailViewController = controller;
        //self.detailNavigationController = detailNavigationController;
    }
    else if([segue.identifier isEqualToString:@"show"]){
        
        self.clearsSelectionOnViewWillAppear = YES;
        
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        Folder *folder = [self.fetchedResultsTableViewAdapter.fetchedResultsController objectAtIndexPath:indexPath];
        //self.selected
        MasterViewController *controller = (MasterViewController *)segue.destinationViewController;
       // Venue *venue = self.selectedObject;
        controller.parentListItem = self.fetchedPageObject;
        controller.managedObjectContext = self.managedObjectContext;
        //controller.selectedPageObject = folder;
        controller.delegate = self;
        //controller.venue = venue;
        //controller.delegate = self;
        //controller.detailNavigationController = self.detailNavigationController;
    }
}

- (void)fetchedViewController:(MUIFetchedPageViewController *)fetchedViewController didDeleteDisplayedObject:(NSManagedObject *)displayedObject{
    [self.navigationController popToViewController:self.parentViewController animated:YES];
}


- (void)fetchedViewController:(nonnull MUIFetchedPageViewController *)fetchedViewController didSelectPageObject:(nonnull id)object {
    //if([object isKindOfClass:Event.class]){
        self.selectedObject = object;
  //  }
    
    //if(!self.clearsSelectionOnViewWillAppear){
    //    NSIndexPath *indexPath = [self.fetchedResultsTableViewAdapter.fetchedResultsController indexPathForObject:object];
    //    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
  //  }
}

- (void)dealloc
{
    id i = self.navigationController;
    id j = self.splitViewController;
  //  [self.navigationController removeObserver:self forKeyPath:@"selectedObject"];
}
@end
