//
//  AppDelegate.m
//  CloudEvents
//
//  Created by Malcolm Hall on 04/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import "CityListViewController.h"
#import "PersistentContainer.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@property (strong, nonatomic) UINavigationController *secondaryNavigationController;
//@property (strong, nonatomic) MUIFetchedTableViewController *citySelectionManager;
@property (strong, nonatomic) UINavigationController *detailNavigationControllerForRestoration;

@end

@implementation AppDelegate

// easy access to our primary table view controller (from PhotoHandoff)
- (CityListViewController *)rootViewController{
    UISplitViewController *svc = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *nav = svc.viewControllers[0];
    return nav.viewControllers[0];
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UIStateRestorationDebugLogging"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"UIStateRestorationDeveloperMode"];
    
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    navigationController.topViewController.navigationItem.leftItemsSupplementBackButton = YES;
    splitViewController.delegate = self;
    
    UINavigationController *primaryNavigationController = splitViewController.viewControllers[0];
    CityListViewController *controller = (CityListViewController *)primaryNavigationController.topViewController;
    controller.persistentContainer = self.persistentContainer;
  //  controller.masterTable = self.citySelectionManager;
    
    //Venue *venue = [self.persistentContainer.viewContext executeFetchRequest:<#(nonnull NSFetchRequest *)#> error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>]
    
    [application registerForRemoteNotifications]; // background modes remote notifications
    
//    self.secondaryNavigationController = splitViewController.viewControllers[1];
    
    NSBundle *bundle = [NSBundle bundleForClass:application.class];
    NSLog(@"%@", bundle.bundlePath);
    
    self.detailNavigationControllerForRestoration = splitViewController.viewControllers[1];
    
    [self.window makeKeyAndVisible];
  
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken");
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError");
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"didReceiveRemoteNotification");
}
//
//{
//    aps =     {
//        "content-available" = 1;
//    };
//    ck =     {
//        ce = 2;
//        cid = "iCloud.com.malcolmhall.CloudEvents";
//        ckuserid = "_3cb3bd2b974a2f9d7e5a86f125e7be47";
//        met =         {
//            dbs = 1;
//            sid = "com.apple.coredata.cloudkit.private.subscription";
//            zid = "com.apple.coredata.cloudkit.zone";
//            zoid = "_3cb3bd2b974a2f9d7e5a86f125e7be47";
//        };
//        nid = "65377a79-8c7e-42ca-b755-8e515ce42c1d";
//    };
//}



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
    return YES;
}

- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder{
    NSLog(@"didDecodeRestorableStateWithCoder");
    self.detailNavigationControllerForRestoration = nil;
}

// called after collapse.

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder{
    NSLog(@"%@", identifierComponents);
    if([identifierComponents.lastObject isEqualToString:@"DetailNavigationController"]){
        return self.detailNavigationControllerForRestoration;
    }
    else if([identifierComponents.lastObject isEqualToString:@"DetailViewController"]){
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
    return nil;
}


#pragma mark - Split view

//- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
//    NSLog(@"");
//    return nil;
//}

/*
// this is asking should we discard the secondary?
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    
    id a = splitViewController.viewControllers;
    id b = secondaryViewController.childViewControllers;
    id c = primaryViewController.childViewControllers;
    
    // There may or may not be a detail item.
    // There may or may not be a master view controller.
    // The master may or may not contain the same detail item.
    
//    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] object] == nil)) {
//        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//        return YES;
//    } else {
//        return NO;
//    }
    
    if(![secondaryViewController isKindOfClass:UINavigationController.class]){
        return YES;
    }
    UINavigationController *secondaryNav = (UINavigationController *)secondaryViewController;
    UIViewController *vc = secondaryNav.viewControllers.firstObject;
    if(![vc isKindOfClass:DetailViewController.class]){
        return YES;
    }
    DetailViewController *dvc = (DetailViewController *)vc;
    id detailObject = dvc.detailItem;
    // if we don't have an object
    if(!detailObject){
        return YES;
    }
    if(![primaryViewController isKindOfClass:UINavigationController.class]){
        return YES;
    }
    UINavigationController *primaryNav = (UINavigationController *)primaryViewController;
    UIViewController *primaryNavTop = primaryNav.topViewController;
    // if we don't have a master
    if(![primaryNavTop isKindOfClass:MasterViewController.class]){
        return YES;
    }
    // find out if the master "contains" the detail object.
    // it could either be the original one that showed the detail - prob not.
    // or it could be one the user moved in to which just happens to also have the same detail in it.
    // can't use the shownViewController param because going back and forward again resets it.
    MasterViewController *master = (MasterViewController *)primaryNavTop;
   // id o = master.selectedObject;
    //if(master.shownViewController != dvc){
    
    if(![master contansDetailItem:detailObject]){
        return YES;
    }
    
//     && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] object] == nil)) {
//        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//        return YES;
//    } else {
//        return NO;
//    }
    return NO;
}
*/

//#pragma mark - Root Selection Manager
//
//- (MUIFetchedTableViewController *)citySelectionManager{
//    if(_citySelectionManager){
//        return _citySelectionManager;
//    }
//    _citySelectionManager = [MUIFetchedTableViewController.alloc init];
//    [UIApplication registerObjectForStateRestoration:_citySelectionManager restorationIdentifier:@"CitySelectionManager"];
//    return _citySelectionManager;
//}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (PersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[PersistentContainer alloc] initWithName:@"CloudEvents"];
            NSPersistentStoreDescription *psd = _persistentContainer.persistentStoreDescriptions.firstObject;
            
            [psd setOption:@YES forKey:NSPersistentStoreRemoteChangeNotificationPostOptionKey];
            
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
            
     //       _persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
     //       _persistentContainer.viewContext.transactionAuthor = @"app";
            
            // Pin the viewContext to the current generation token and set it to keep itself up to date with local changes.
            _persistentContainer.viewContext.automaticallyMergesChangesFromParent = YES;
            [_persistentContainer.viewContext setQueryGenerationFromToken:NSQueryGenerationToken.currentQueryGenerationToken error:nil];
            
            [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(persistentStoreRemoteChangeNotification:) name:NSPersistentStoreRemoteChangeNotification object:_persistentContainer];
            
            [UIApplication registerObjectForStateRestoration:_persistentContainer restorationIdentifier:StateRestorationPersistentContainerKey];
            
         //   NSPersistentStoreDescription *a2 = [NSPersistentStoreDescription.alloc initWithURL:[NSPersistentContainer.defaultDirectoryURL URLByAppendingPathComponent:@"Local.sqlite"]];
           // _persistentContainer.persistentStoreDescriptions = nil;//@[a2];
            
            //id i = psd.options[@"NSPersistentStoreMirroringDelegateOptionKey"];
            
          // id i = _persistentContainer.persistentStoreCoordinator.persistentStores.lastObject.options;
            
          //  NSLog(@"%@", i);

            
        }
    }
    
    return _persistentContainer;
}

- (void)persistentStoreRemoteChangeNotification:(NSNotification *)notification{
    NSLog(@"persistentStoreRemoteChangeNotification");
    //[_persistentContainer.viewContext setQueryGenerationFromToken:NSQueryGenerationToken.currentQueryGenerationToken error:nil];
}

//NSConcreteNotification 0x280070ff0 {name = NSPersistentStoreRemoteChangeNotification; object = <NSPersistentStoreCoordinator: 0x281b82340>; userInfo = {
//    NSStoreUUID = "83A993EA-6D3C-4D63-B07C-44FD6018524E";
//    historyToken = "<NSPersistentHistoryToken - {\n    \"83A993EA-6D3C-4D63-B07C-44FD6018524E\" = 3;\n}>";
//    storeURL = "file:///var/mobile/Containers/Data/Application/CED63687-9122-4051-98C9-EA1A464D71D9/Library/Application%20Support/CloudEvents.sqlite";
//}}
//
//
//NSConcreteNotification 0x2800719b0 {name = NSPersistentStoreRemoteChangeNotification; object = <NSPersistentStoreCoordinator: 0x281b82340>; userInfo = {
//    NSStoreUUID = "83A993EA-6D3C-4D63-B07C-44FD6018524E";
//    historyToken = "<NSPersistentHistoryToken - {\n    \"83A993EA-6D3C-4D63-B07C-44FD6018524E\" = 2;\n}>";
//    storeURL = "file:///var/mobile/Containers/Data/Application/CED63687-9122-4051-98C9-EA1A464D71D9/Library/Application%20Support/CloudEvents.sqlite";
//}}
//
//NSConcreteNotification 0x280072460 {name = NSPersistentStoreRemoteChangeNotification; object = <NSPersistentStoreCoordinator: 0x281b82340>; userInfo = {
//    NSStoreUUID = "83A993EA-6D3C-4D63-B07C-44FD6018524E";
//    historyToken = "<NSPersistentHistoryToken - {\n    \"83A993EA-6D3C-4D63-B07C-44FD6018524E\" = 2;\n}>";
//    storeURL = "file:///var/mobile/Containers/Data/Application/CED63687-9122-4051-98C9-EA1A464D71D9/Library/Application%20Support/CloudEvents.sqlite";
//}}


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
