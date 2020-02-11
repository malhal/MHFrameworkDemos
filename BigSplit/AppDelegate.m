//
//  AppDelegate.m
//  BigSplit
//
//  Created by Malcolm Hall on 11/08/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

// cant use a nav below primary split controller because we would have to hide its navigation bar.

// lastest is not working in 12" landsscape when in compact (safari on right) on root controller then contract safari to nothing. Leaves grey middle column.
// Should rename the controllers and storyboard IDs to better names.

// Latest is ipad pro 3 column, drag in 1 column safari. Select detail then go back to Root. Expand to full screen.
// Prob is master is blank but detail still is showing.

// return nil doesn't just do the nav it can also find the preserved controller!
// But probably only if have collapsed and seperated needlessly


// In single split, select item, go to different folder. collapse to 1 column, go back, shows wrong folder.
// When going in a new item list need to choose new detail item.

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import "RootViewController.h"
#import "MasterNavigationController.h"

@interface AppDelegate () <UISplitViewControllerDelegate, MUIMasterTableSelectionControllerDelegate> // MUIDetailItemSplitterDelegate

@property (strong, nonatomic) MUICollapseController *masterCollapseController;
@property (strong, nonatomic) MUIFetchedMasterTableSelectionController *rootTableSelectionController;
@property (strong, nonatomic) MUIFetchedTableRowsController *fetchedTableRowsController;
@property (strong, nonatomic) NSFetchedResultsController<Venue *> *fetchedResultsController;
@property (strong, nonatomic) RootViewController* rootViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    MUISplitViewController *detailSplitController = (MUISplitViewController *)self.window.rootViewController;
    
    UISplitViewController *masterSplitController = detailSplitController.viewControllers.firstObject;
    
    UINavigationController *nav = masterSplitController.viewControllers.firstObject;
    RootViewController *controller = (RootViewController *)nav.topViewController;
    self.rootViewController = controller;
    
    controller.managedObjectContext = self.persistentContainer.viewContext;
    
    self.masterCollapseController = [MUICollapseController.alloc initWithSplitViewController:masterSplitController];
    self.masterCollapseController.masterViewController = controller;
    
    //self.fetchedTableRowsController.fetchedResultsController = self.fetchedResultsController;
    
    self.fetchedTableRowsController = [MUIFetchedTableRowsController.alloc initWithTableViewController:controller];
    self.fetchedTableRowsController.fetchedResultsController = self.fetchedResultsController;
    
    self.rootTableSelectionController = [MUIFetchedMasterTableSelectionController.alloc initWithFetchedTableRowsController:self.fetchedTableRowsController];
    self.rootTableSelectionController.delegate = self;
    
    //self.rootTableSelectionController.fetchedTableRowsController = self.fetchedTableRowsController;
    //self.rootTableSelectionController.dataSource = self.fetchedTableRowsController;
 
    //controller.delegate = self.rootTableSelectionController;
    //controller.dataSource = self.fetchedTableRowsController;
    controller.fetchedResultsController = self.fetchedResultsController;
    
    return YES;
}

- (void)masterTableSelectionController:(MUIMasterTableSelectionController *)masterTableSelectionController didSelectItem:(id)item{
    self.rootViewController.venueForSegue = item;
    [self.rootViewController performSegueWithIdentifier:@"showDetail" sender:self];
    //[self updateTableSelectionForCurrentSelectedDetailItem];
}

#pragma mark - Fetched results controller

//- (MUIFetchedTableRowsController *)fetchedTableRowsController{
//    if(_fetchedTableRowsController){
//        return _fetchedTableRowsController;
//    }
//    _fetchedTableRowsController = [MUIFetchedTableRowsController.alloc initWithFetchedResultsController:self.fetchedResultsController]; //WithTableView:self.tableView];
//    return _fetchedTableRowsController;
//}

- (NSFetchedResultsController<Venue *> *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<Venue *> *fetchRequest = Venue.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Venue *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    //aFetchedResultsController.delegate = self.fetchedTableRowsController;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark Detail Splitter

//- (UIViewController *)createDetailViewControllerForDetailSplitter:(MUIDetailItemSplitter *)detailItemSplitter{
//    UIStoryboard *storyboard = self.window.rootViewController.storyboard;
//    return [storyboard instantiateViewControllerWithIdentifier:@"DetailNavigationController"];
//}
//
//- (UIViewController *)createMasterViewControllerForMasterSplitter:(MUIMasterItemSplitter *)masterItemSplitter{
//    UIStoryboard *storyboard = self.window.rootViewController.storyboard;
//    return [storyboard instantiateViewControllerWithIdentifier:@"MasterNavigationController"];
//}

//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//- (void)splitViewController:(UISplitViewController *)splitViewController popoverController:(UIPopoverController *)popoverController willPresentViewController:(UIViewController *)vc{
//#pragma clang diagnostic pop
//    self.popoverController = popoverController;
//}
//
//- (BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(nullable id)sender{
//    [self.popoverController dismissPopoverAnimated:YES];
//    return NO;
//}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext{
    return self.persistentContainer.viewContext;
}

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"BigSplit"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
