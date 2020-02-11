//
//  AppDelegate.m
//  BasicSplit
//
//  Created by Malcolm Hall on 04/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "AppDelegate.h"
#import "EndViewController.h"
#import "StartViewController.h"
//#import "MiddleTableViewController.h"
//#import "SelectedItemController.h"
#import "MiddleViewController.h"
#import "OuterSplitViewController.h"
#import "OuterMasterViewController.h"
#import "PersistentContainer.h"

static NSString * kMiddleEndSelectedItemControllerStateKey = @"MiddleEndSelectedItemControllerState";
static NSString * kStartMiddleSelectedItemControllerStateKey = @"StartMiddleSelectedItemControllerState";

@interface AppDelegate () <UISplitViewControllerDelegate, UIObjectRestoration>//, SelectedItemControllerDelegate>

@property (nonatomic, readonly) OuterSplitViewController *outerSplitController;

@property (weak, nonatomic) StartViewController *startViewController;
@property (strong, nonatomic) MUIDetailViewManager *detailViewManager;

@end

@implementation AppDelegate

- (UISplitViewController *)outerSplitController{
    return (UISplitViewController *)self.window.rootViewController;
}

//- (UISplitViewController *)innerSplitController{
//    return (UISplitViewController *)self.outerSplitController.viewControllers.firstObject;
//}

- (UIStoryboard *)storyboard{
    return self.outerSplitController.storyboard;
}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
//    [UIApplication registerObjectForStateRestoration:self.middleEndSelectedItemController restorationIdentifier:kMiddleEndSelectedItemControllerStateKey];
//    [UIApplication registerObjectForStateRestoration:self.startMiddleSelectedItemController restorationIdentifier:kStartMiddleSelectedItemControllerStateKey];
//
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"UIStateRestorationDebugLogging"];
   // [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"UIStateRestorationDeveloperMode"];
    //[application ignoreSnapshotOnNextApplicationLaunch];
    
//    UISplitViewController *innerSplitController = self.innerSplitController;
//    UINavigationController *startNavigationController = (UINavigationController *)innerSplitController.viewControllers.firstObject;
//    self.startNavigationController = startNavigationController;
    
  //  StartViewController *startViewController = (StartViewController *)startNavigationController.viewControllers.firstObject;
 //   startViewController.middleEndSelectedItemController = self.middleEndSelectedItemController;
  //  startViewController.managedObjectContext = self.persistentContainer.viewContext;
   // self.startViewController = startViewController;
    //self.persistentContainer.viewContext.automaticallyMergesChangesFromParent
    //self.outerSplitController.delegate = self;
    
     self.detailViewManager = [MUIDetailViewManager.alloc initWithSplitViewController:self.outerSplitController];
    
    self.outerSplitController.persistentContainer = self.persistentContainer;
    
    OuterMasterViewController *vc = self.outerSplitController.viewControllers.firstObject;
    
    
    //id i = vc.childViewControllers.firstObject;
    //vc.persistentContainer = self.persistentContainer;
    
 //   vc.middleEndSelectedItemController = self.middleEndSelectedItemController;
    
//    self.middleEndSelectedItemController.detailViewController = self.outerSplitController.viewControllers.lastObject;
    
    [self.window makeKeyAndVisible];
    return YES;
}

//- (SelectedItemController *)middleEndSelectedItemController{
//    if(!_middleEndSelectedItemController){
//        _middleEndSelectedItemController = [SelectedItemController.alloc initWithSplitViewController:self.outerSplitController];
//        _middleEndSelectedItemController.delegate = self;
//    }
//    return _middleEndSelectedItemController;
//}

//- (SelectedItemController *)startMiddleSelectedItemController{
//    if(!_startMiddleSelectedItemController){
//        _startMiddleSelectedItemController = [SelectedItemController.alloc initWithSplitViewController:self.innerSplitController];
//        _startMiddleSelectedItemController.delegate = self;
//    }
//    return _startMiddleSelectedItemController;
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
  //  UISplitViewController *outerSplitController = self.outerSplitController;
    //outerSplitController.delegate = self;
    //
    
    //self.middleEndSelectedItemController.delegate = self;
    
   // UISplitViewController *innerSplitController = self.innerSplitController;
    //innerSplitController.delegate = self;
//    id a = outerSplitController.viewControllers;
//
//    self.startViewController.middleEndSelectedItemController = middleEndSelectedItemController;
//    id count = self.innerSplitController.viewControllers;
//    UINavigationController *middleNavigationController = self.innerSplitController.viewControllers.lastObject;
//    MiddleViewController *middleViewController = middleNavigationController.viewControllers.lastObject;
//    MiddleTableViewController *middleTableViewController = middleViewController.middleTableViewController;
//    middleEndSelectedItemController.masterViewController = middleTableViewController;
//    
      //  MiddleNavigationController *detailNavigationController = self.splitViewController.viewControllers.lastObject;
       // MiddleViewController *middle = detailNavigationController.viewControllers.firstObject;
       // middleViewController.middleEndSelectedItemController = middleEndSelectedItemController;

    
    return YES;
}

//- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
//    return YES;
//}

//- (MiddleNavigationController *)recreateDetailViewControllerForSelectedItemController:(SelectedItemController *)selectedItemController{
   // if(selectedItemController == self.startMiddleSelectedItemController){
    //    MiddleNavigationController *middleNavigationController = [self.innerSplitController.storyboard instantiateViewControllerWithIdentifier:@"MiddleNavigationController"];
      //  MiddleViewController *middleViewController = (MiddleViewController *)middleNavigationController.topViewController;
        //middleViewController.startMiddleSelectedItemController = self.startMiddleSelectedItemController;
        //selectedItemController.detailViewController = middleViewController;
        //self.middleViewController = middleViewController; // custom setter does stuff
        
    //    middleViewController.middleEndSelectedItemController = self.middleEndSelectedItemController;
//        return middleNavigationController;
//    }
//    else if(selectedItemController == self.middleEndSelectedItemController){
//
    
//    if(selectedItemController == self.startMiddleSelectedItemController){
//        UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"MiddleNavigationController"];
//        MiddleViewController *controller = (MiddleViewController *)[nav topViewController];
//
//        controller.middleEndSelectedItemController = self.middleEndSelectedItemController;
//        return nav;
//    }
//
   // MiddleNavigationController *endNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"EndNavigationController"];
  //  EndViewController *detailViewController = (EndViewController *)endNavigationController.topViewController;
    //self.selectedItemController.detailViewController = detailViewController;
 //   return endNavigationController;
//    }
   // return nil;
//}

// all the permanent controllers (although might not be if we have to rebuild the whole UI!)


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

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder{
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder{
    
    UITraitCollection *forcedTraitCollection = [coder decodeObjectForKey:@"ForcedTraitCollection"];
    //self.outerSplitController.forcedTraitCollection = forcedTraitCollection;
    //
    
    // we need to update the traits immediately if the horizontal trait is the same.
    
   // if(forcedTraitCollection.horizontalSizeClass == self.outerSplitController.traitCollection.horizontalSizeClass){
        //[self.outerSplitController updateForcedTraitCollection];
   // }
    
    
    CGSize size = [coder decodeCGSizeForKey:@"Size"];
  //  self.outerSplitController.targetViewSize = size;
  
    //if(i != self.outerSplitController.traitCollection.horizontalSizeClass){
//        [self.outerSplitController viewWillTransitionToSize:size withTransitionCoordinator:nil];
    //}
    
    return NO;
}

- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(nonnull NSCoder *)coder{
    [coder encodeCGSize:self.outerSplitController.view.frame.size forKey:@"Size"];
    [coder encodeInteger:self.outerSplitController.traitCollection.horizontalSizeClass forKey:@"HorizontalSizeClass"];
    
    [coder encodeObject:self.outerSplitController.forcedTraitCollection forKey:@"ForcedTraitCollection"];
}


/*
- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder{
    NSLog(@"viewControllerWithRestorationIdentifierPath %@", identifierComponents);
   
    NSString *lastIdentifier = identifierComponents.lastObject;
    
    NSEnumerator *enumerator = identifierComponents.objectEnumerator;
    id i = enumerator.nextObject;
    
    if([lastIdentifier isEqualToString:@"StartViewController"]){
        StartViewController *startViewController = self.startViewController;
        NSURL *objectURI = [coder decodeObjectForKey:MasterTableViewControllerSelectedDetailItemKey];
        if(objectURI){
            startViewController.selectedItem = [self.persistentContainer.viewContext mcd_existingObjectWithURI:objectURI error:nil];
        }
    }
    else if([lastIdentifier isEqualToString:@"MiddleNavigationController"]){

        MiddleNavigationController *middleNavigationController = (MiddleNavigationController *)self.innerSplitController.viewControllers.lastObject;
        NSAssert([middleNavigationController isKindOfClass:MiddleNavigationController.class], @"middleNavigationController was not a MiddleNavigationController");
        
        NSURL *objectURI = [coder decodeObjectForKey:@"DetailItem"];
        if(objectURI){
            middleNavigationController.detailItem = [self.persistentContainer.viewContext mcd_existingObjectWithURI:objectURI error:nil];
        }
        
        return middleNavigationController;
    }
    else if([lastIdentifier isEqualToString:@"EndNavigationController"]){
        MiddleNavigationController *endNavigationController = self.outerSplitController.viewControllers.lastObject;
        NSAssert([endNavigationController isKindOfClass:UINavigationController.class], @"endNavigationController was not a MiddleNavigationController");
        
        NSURL *objectURI = [coder decodeObjectForKey:@"DetailItem"];
        if(objectURI){
            endNavigationController.detailItem = [self.persistentContainer.viewContext mcd_existingObjectWithURI:objectURI error:nil];
        }
        return endNavigationController;
    }
    else if([lastIdentifier isEqualToString:@"EndViewController"]){
        UINavigationController *endNavigationController = self.outerSplitController.viewControllers.lastObject;
        EndViewController *endViewController = (EndViewController *)endNavigationController.viewControllers.firstObject;
        // UIStoryboard *storyboard = [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
        // EndViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"EndViewController"];
        

         // gets it from the navigation
        return endViewController;
    }
    else if([lastIdentifier isEqualToString:@"MiddleViewController"]){
        // no longer called
        
        //MiddleViewController *master = (MiddleViewController *)[self.innerSplitController.viewControllers.firstObject.childViewControllers.lastObject topViewController];
        UINavigationController *middleNavigationController = self.innerSplitController.viewControllers.lastObject;
        MiddleViewController *middle = middleNavigationController.viewControllers.firstObject;
        //master.managedObjectContext = self.persistentContainer.viewContext;
        
//        NSURL *objectURI = [coder decodeObjectForKey:MiddleViewControllerItemKey];
//        if(objectURI){
//            NSManagedObject *object = [self.persistentContainer.viewContext mcd_existingObjectWithURI:objectURI error:nil];
//            if(object){
//                //[master setMasterItem:object deleteCache:NO];
//                master.masterItem = object;
//            }
//        }
        NSAssert([middle isKindOfClass:MiddleViewController.class], @"middle was not a MiddleViewController");
        return middle; // then view did loads is called which sets up the embed segue.
    }
    else if([lastIdentifier isEqualToString:@"MiddleTableViewController"]){
        UINavigationController *middleNavigationController = self.innerSplitController.viewControllers.lastObject;
        MiddleViewController *middle = middleNavigationController.viewControllers.firstObject;
        MiddleTableViewController *middleTable = middle.middleTableViewController;
        
        NSURL *objectURI = [coder decodeObjectForKey:MasterTableViewControllerSelectedDetailItemKey];
        if(objectURI){
            middleTable.selectedItem = [self.persistentContainer.viewContext mcd_existingObjectWithURI:objectURI error:nil];
        }
        
        return middleTable;
    }
    return nil;
}
*/

#pragma mark - Split view


- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[EndViewController class]] && ([(EndViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        //if ([secondaryViewController isKindOfClass:[DetailNavigationController class]] && [(DetailNavigationController *)secondaryViewController detailItem] == nil) {
        return YES;
    } else {
        return NO;
    }
}


//- (BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(nonnull UIViewController *)vc sender:(nullable id)sender{
//    UINavigationController *nc = splitViewController.viewControllers.firstObject;
//    [nc pushViewController:vc animated:YES];
//    return YES;
//}

// main thing we are checking is if the detail item originated from the current master controller
// that was flawed, cause it might be a diff instance.

//- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
//    if([primaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)primaryViewController topViewController] isKindOfClass:[StartViewController class]]){
//        return YES;
//    }
//    else if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[EndViewController class]] && ([(EndViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
//        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//        return YES;
//    }
//    return NO;
    
    // flaw in this was if the master controller didnt contain the detail item, like the navigated to a different folder.
    
//    if([primaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)primaryViewController topViewController] isKindOfClass:[MiddleTableViewController class]]
//       && [secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[EndViewController class]] && ([(EndViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem])) {
//        return NO;
//    }
//    return YES;
//
//    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
//    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
//        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//        return YES;
//    }
    
//    if ([secondaryViewController isKindOfClass:[MiddleNavigationController class]] && ([(MiddleNavigationController *)secondaryViewController detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
 //       return YES;
//    }
//
//    return NO;
//}

// for when we are not viewing detail in collapsed
// needed when 2 level master
//- (nullable UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
////   // UINavigationController *nav = (UINavigationController *)primaryViewController;
//    id i = [primaryViewController separateSecondaryViewControllerForSplitViewController:splitViewController];
//    return i;
////
//    if([[(UINavigationController *)primaryViewController topViewController] isKindOfClass:[EndViewController class]]){
//        return nil;
//    }
//    return splitViewController;
//    //return nil;
//}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[PersistentContainer alloc] initWithName:@"BasicSplit"];
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
            NSLog(@"_persistentContainer.viewContext %@", _persistentContainer.viewContext);
            NSLog(@"%@", _persistentContainer.persistentStoreDescriptions.firstObject.URL);
            [UIApplication registerObjectForStateRestoration:_persistentContainer restorationIdentifier:StateRestorationPersistentContainerKey];
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


