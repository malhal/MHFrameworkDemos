//
//  AppDelegate.m
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 16/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "AppController.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import "RootViewController.h"

@interface NSPersistentContainer (AppDelegate) //<UIStateRestoring>

@end

@interface AppController () <UISplitViewControllerDelegate>

//@property (strong, nonatomic) UINavigationController *detailNavigationControllerForRestoration;

@end

@implementation AppController


- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    //splitViewController.persistentContainer = self.persistentContainer;
    
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;

    UINavigationController *masterNavigationController = splitViewController.viewControllers[0];
    RootViewController *controller = (RootViewController *)masterNavigationController.topViewController;
    //controller.persistentContainer = self.persistentContainer;
    //controller.managedObjectContext = controller;
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UIStateRestorationDebugLogging"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UIStateRestorationDeveloperMode"];
    
    //[UIApplication registerObjectForStateRestoration: restorationIdentifier:@"DetailNavigationController"];
 //   self.detailNavigationControllerForRestoration = splitViewController.viewControllers[1];
    //id i = self.detailNavigationControllerForRestoration.topViewController;
    

    UINavigationController *detailNav = (UINavigationController *)splitViewController.viewControllers.lastObject;
    DetailViewController *detail = detailNav.viewControllers.firstObject;
    detail.managedObjectContext = self.persistentContainer.viewContext;
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
       [self saveContext];
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

//- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder{
//    NSQueryGenerationToken *q = NSQueryGenerationToken.currentQueryGenerationToken;
//    NSQueryGenerationToken *queryGenerationToken = self.persistentContainer.viewContext.queryGenerationToken;
//    [coder encodeObject:queryGenerationToken forKey:@"QueryGenerationToken"];
  
//    return YES;
//}

//- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder{
//    NSQueryGenerationToken *queryGenerationToken = [coder decodeObjectForKey:@"QueryGenerationToken"];
//    NSError *error = nil;
//    if(![self.persistentContainer.viewContext setQueryGenerationFromToken:queryGenerationToken error:&error]){
//        NSLog(@"setQueryGenerationFromToken %@", error);
//    }
    
//    return NO;
//}

#define kMasterViewController @"MasterViewController"

- (UISplitViewController *)splitViewController{
    return (UISplitViewController *)self.window.rootViewController;
}

/*
- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder{
    NSLog(@"%@", identifierComponents);
    //NSURL *objectURI = [coder decodeObjectForKey:@"CurrentDetailObject"];
    if([identifierComponents.lastObject isEqualToString:@"DetailNavigationController"]){
        // id a = self.detailNavigationControllerForRestoration;
        //return self.mas
        //id b = self.detailNavigationForRestore;
        id i = self.detailNavigationControllerForRestoration;
        return i;
    }
    else if([identifierComponents.lastObject isEqualToString:@"DetailViewController"]){
        //return
        //id c = self.detailNavigationControllerForRestoration.topViewController;
        //id d = self.detailNavigationForRestore.topViewController;
        DetailViewController *dvc = self.detailNavigationControllerForRestoration.topViewController;
        NSManagedObjectContext *moc = self.persistentContainer.viewContext;
        NSURL *objectURI = [coder decodeObjectForKey:DetailViewControllerStateRestorationDetailItemKey];
        if(objectURI){
            Event *event = [moc mcd_existingObjectWithURI:objectURI error:nil];
            if(event){
                dvc.detailItem = event;
            }
        }
        return dvc;
    }
//    else if([identifierComponents.lastObject isEqualToString:kMasterViewController]){
//        NSManagedObjectContext *moc = self.persistentContainer.viewContext;
//        NSURL *objectURI = [coder decodeObjectForKey:@"MasterItem"];
//        Venue *object = [moc mcd_objectWithURI:objectURI];
//        if (@available(iOS 13.0, *)) {
//            return [storyboard instantiateViewControllerWithIdentifier:kMasterViewController creator:^__kindof UIViewController * _Nullable(NSCoder * _Nonnull coder) {
//                return [MasterViewController.alloc initWithCoder:coder masterItem:object managedObjectContext:moc];
//            }];
//        } else {
//            // Fallback on earlier versions
//            MasterViewController *mvc = [storyboard instantiateViewControllerWithIdentifier:kMasterViewController];
//            mvc.masterItem = object;
//            mvc.managedObjectContext = moc;
//        }
//    }
    return nil;
}
*/

#pragma mark - Split view

//- (BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(id)sender{
//    if(!splitViewController.isCollapsed){
//        return NO;
//    }
//    UINavigationController *masterNav = splitViewController.viewControllers.firstObject;
//    if(![masterNav.topViewController isKindOfClass:UINavigationController.class]){
//        return NO;
//    }
//    UINavigationController *existingDetailNav = (UINavigationController *)masterNav.topViewController;
//    UINavigationController *newDetailNav = (UINavigationController *)vc;
//    existingDetailNav.viewControllers = @[newDetailNav.topViewController];
//    return YES;
//}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
//    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
//        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//        return YES;
//    }
//
//    // for when test is pushed on master
//    UINavigationController *primaryNav = (UINavigationController *)primaryViewController;
//    id i = primaryNav.topViewController;
//    if(primaryNav.childViewControllers.count != 2){
//        return YES;
//    }
    return YES;
}

//- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
//    return nil;
//}

//- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder{
//    NSLog(@"didDecodeRestorableStateWithCoder");
//    self.detailNavigationControllerForRestoration = nil;
//}
#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"MUIFetchedMasterDetail"];
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
        //    [UIApplication registerObjectForStateRestoration:_persistentContainer restorationIdentifier:@"PersistentContainer"];
            
            NSLog(@"persistentContainer is at %@", _persistentContainer.persistentStoreCoordinator.persistentStores.firstObject.URL.path);
           // _persistentContainer.viewContext.shouldDeleteInaccessibleFaults = NO;
            _persistentContainer.viewContext.automaticallyMergesChangesFromParent = YES;
            [_persistentContainer.viewContext setQueryGenerationFromToken:NSQueryGenerationToken.currentQueryGenerationToken error:nil];
        }
    }
    
    return _persistentContainer;
}

//- (NSPersistentContainer *)mui_persistentContainer{
//    return self.persistentContainer;
//}

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

//@implementation UISplitViewController (PersistentContainer)
//
//- (__kindof NSPersistentContainer *)mcd_persistentContainerWithSender:(id)sender{
//    return [(AppDelegate *)UIApplication.sharedApplication.delegate persistentContainer];
//}
//
//@end
//
//@implementation NSPersistentContainer (AppDelegate)
//@end
