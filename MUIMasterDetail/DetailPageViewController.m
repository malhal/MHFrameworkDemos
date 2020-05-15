//
//  DetailPageViewController.m
//  Paging1
//
//  Created by Malcolm Hall on 04/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "DetailPageViewController.h"
#import "DetailViewController.h"

@interface DetailPageContainerDataSource : MUIFetchedPageContainerDataSource

@end

@implementation DetailPageContainerDataSource

- (UIViewController *)viewControllerForObject:(id)object inPageViewController:(UIPageViewController *)pageViewController{
    DetailViewController *controller = (DetailViewController *)[pageViewController.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    //controller.managedObjectContext = self.fetchedResultsController.managedObjectContext;
    //self.displayedObject = self.fetchedPageContainerDataSource.fetchedResultsController.fetchedObjects.firstObject;
   // controller.venue = object;
    controller.detailItem = object;
    return controller;
}

@end

@interface DetailPageViewController ()

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) Event *currentEvent;
@property (strong, nonatomic) NSFetchedResultsController<Event *> *fetchedResultsController;

@end

@implementation DetailPageViewController

- (MUIFetchedPageContainerDataSource *)newFetchedPageContainerDataSource{
    NSFetchRequest *fetchRequest = [Event fetchRequestWithParentListItem:self.parentListItem];
    NSFetchedResultsController * fetchedResultsController = [NSFetchedResultsController.alloc initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    fetchedResultsController.delegate = self;
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    return [DetailPageContainerDataSource.alloc initWithFetchedResultsController:fetchedResultsController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    //self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

    self.fetchedPageContainerDataSource = self.newFetchedPageContainerDataSource;
    
   // [self configureView];
}

// only read state
- (void)configureView{
//    self.pageViewController.dataSource = self.dataSource;
//    self.trashButton.enabled = self.dataSource.detailItems.count;
//    self.navigationItem.title = [NSString stringWithFormat:@"%ld Pages", self.dataSource.detailItems.count];
//    BOOL upEnabled = NO, downEnabled = NO;
//    if(self.currentEvent){
//        upEnabled = [self.dataSource.detailItems indexOfObject:self.currentEvent] > 0;
//        downEnabled = [self.dataSource.detailItems indexOfObject:self.currentEvent] < self.dataSource.detailItems.count - 1;
//    }
//    self.upButton.enabled = upEnabled;
//    self.downButton.enabled = downEnabled;
//    DetailViewController *currentController = self.pageViewController.viewControllers.firstObject;
//    if(!currentController || currentController.detailItem != self.currentEvent){
//        BOOL animated = currentController && [self.dataSource.detailItems containsObject:currentController.detailItem];
//        UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
//        if(animated){
//            direction = [self.dataSource.detailItems indexOfObject:currentController.detailItem] > [self.dataSource.detailItems indexOfObject:self.currentEvent] ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward;
//        }
//        DetailViewController *controller = (DetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
//        controller.detailItem = self.currentEvent;
//        [self.pageViewController setViewControllers:@[controller] direction:direction animated:animated completion:nil];
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    //self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

//- (IBAction)up:(id)sender {
//    NSUInteger index = [self.dataSource.detailItems indexOfObject:self.currentEvent];
//    index--;
//    self.currentEvent = [self.dataSource.detailItems objectAtIndex:index];
//    [self configureView];
//}
//
//- (IBAction)down:(id)sender {
//    NSUInteger index = [self.dataSource.detailItems indexOfObject:self.currentEvent];
//    index++;
//    self.currentEvent = [self.dataSource.detailItems objectAtIndex:index];
//    [self configureView];
//}

- (IBAction)trash:(id)sender {
    DetailViewController *controller = self.pageViewController.viewControllers.firstObject;
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    
    [context deleteObject:controller.detailItem];
//
//    UIView* barView = [sender view];
//    CGRect rect = [barView convertRect:barView.bounds toView:nil];
//
//   CGRect rect1 = [barView convertRect:self.pageViewController.viewControllers.firstObject.view.bounds toView:nil];
//    UIView *snapshotView = [self.pageViewController.viewControllers.firstObject.view snapshotViewAfterScreenUpdates:NO];
//    snapshotView.frame = rect1;
//
//  //  CGRect rect = CGRectMake(snapshotView.frame.size.width-30, 40, 0, 0);
//    [barView addSubview:snapshotView];
   // [CATransaction flush];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
//    [UIView animateWithDuration:0.5 animations:^ {
//        snapshotView.frame = rect;
//    } completion:^(BOOL finished) {
//        [snapshotView removeFromSuperview];
//    }];
}

- (IBAction)insertNewObject:(id)sender {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    Event *newEvent = [[Event alloc] initWithContext:context];
        
    // If appropriate, configure the new managed object.
    newEvent.timestamp = [NSDate date];
        
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


#pragma mark - Segues

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
////    if ([[segue identifier] isEqualToString:@"showDetail"]) {
////        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
////        Event *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
////        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
////        controller.detailItem = object;
////        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
////        controller.navigationItem.leftItemsSupplementBackButton = YES;
////        self.detailViewController = controller;
////    }
//    self.childPageViewController = segue.destinationViewController;
//}



#pragma mark - Fetched results controller





//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    //[self.tableView endUpdates];
//    //self.previousIndex = self.dataSource.detailItems indexOfObject:s
//    NSArray *fetchedObjects = controller.fetchedObjects;
//    if(![fetchedObjects containsObject:self.currentEvent]){
//        Event *event;
//        if(fetchedObjects.count){
//            NSUInteger index = [self.dataSource.detailItems indexOfObject:self.currentEvent];
//            if(index >= fetchedObjects.count){
//                index = fetchedObjects.count - 1;
//            }
//            event = [fetchedObjects objectAtIndex:index];
//        }
//        self.currentEvent = event;
//    }
//    self.dataSource = [DataSource.alloc initWithDetailItems:fetchedObjects];
//    [self configureView];
//}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */




@end
