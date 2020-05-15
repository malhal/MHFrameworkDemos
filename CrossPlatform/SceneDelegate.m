#import "SceneDelegate.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"


#if TARGET_OS_MACCATALYST
@interface SceneDelegate () <NSToolbarDelegate>

@property (strong, nonatomic, readonly) NSToolbar *toolbar;

@end
#endif

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    #if TARGET_OS_MACCATALYST
    splitViewController.presentsWithGesture = NO;
   // splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
    #endif
  //  SceneViewController *sceneViewController = (UISplitViewController *)self.window.rootViewController;
splitViewController.primaryBackgroundStyle = UISplitViewControllerBackgroundStyleSidebar;
   // splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
    
//    UITabBarController *tabBarController = splitViewController.viewControllers.lastObject;
//#if TARGET_OS_MACCATALYST
//    tabBarController.tabBar.hidden = YES;
//#endif
//    splitViewController = (UISplitViewController *)tabBarController.viewControllers.firstObject;
//    UINavigationController *navigationController = splitViewController.viewControllers.lastObject;
//    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
//    navigationController.topViewController.navigationItem.leftItemsSupplementBackButton = YES;
splitViewController.delegate = self;
//
    
    
    
    UINavigationController *masterNavigationController = splitViewController.viewControllers.firstObject;

    #if TARGET_OS_MACCATALYST
   // masterNavigationController.navigationBarHidden = YES;
    #endif
    
    MasterViewController *controller = (MasterViewController *)masterNavigationController.topViewController;
    controller.managedObjectContext = ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.viewContext;

    UINavigationController *detailNavigationController = splitViewController.viewControllers.lastObject;
    #if TARGET_OS_MACCATALYST
    detailNavigationController.navigationBarHidden = YES;
    #endif
    
    #if TARGET_OS_MACCATALYST
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    windowScene.titlebar.toolbar = self.toolbar;
    windowScene.titlebar.titleVisibility = UITitlebarTitleVisibilityHidden;
    #endif
}

- (NSPersistentContainer *)persistentContainer{
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer;
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.

    // Save changes in the application's managed object context when the application transitions to the background.
    [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
}


#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

#if TARGET_OS_MACCATALYST

#pragma mark - Tool Bar

@synthesize toolbar = _toolbar;

#define kGoBackToolbarIdentifier @"GoBack"
#define kToolbarAddItemIdentifier @"Add"

- (NSToolbar *)toolbar{
    if(_toolbar){
        return _toolbar;
    }
    _toolbar = [NSToolbar.alloc initWithIdentifier:@"CrossPlatform"];
    _toolbar.delegate = self;
    return _toolbar;
}

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSToolbarItemIdentifier)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag{
   // UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
   // NSToolbarItem *item = [NSToolbarItem itemWithItemIdentifier:@"Malc" barButtonItem:splitViewController.displayModeButtonItem];
   // return item;
    if([itemIdentifier isEqualToString:kToolbarAddItemIdentifier]){
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *masterNavigationController = splitViewController.viewControllers.firstObject;
        MasterViewController *master = masterNavigationController.viewControllers.firstObject;
        NSToolbarItem *item = [NSToolbarItem itemWithItemIdentifier:kToolbarAddItemIdentifier barButtonItem:master.addButtonItem];
        item.target = nil;
        return item;
    }
    else{
        UIImage *image = [UIImage systemImageNamed:@"chevron.left"];
        NSToolbarItem *item = [NSToolbarItem.alloc initWithItemIdentifier:kGoBackToolbarIdentifier];
        item.image = image;
        item.action = @selector(goBack:);
        item.bordered = YES;
        return item;
    }
    return nil;
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar{
    return @[NSToolbarToggleSidebarItemIdentifier, kToolbarAddItemIdentifier];
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar{
    return @[NSToolbarToggleSidebarItemIdentifier, kToolbarAddItemIdentifier];
}

- (void)toolbarWillAddItem:(NSNotification *)notification{
    NSToolbarItem *item = notification.userInfo[@"item"];
    if([item.itemIdentifier isEqualToString:NSToolbarToggleSidebarItemIdentifier]){
        item.target = self;
    }
}

#endif

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    NSLog(@"");
//    return NO;
//}

- (IBAction)toggleSidebar:(id)sender{
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    [UIView animateWithDuration:0.2 animations:^{
        splitViewController.preferredDisplayMode = (splitViewController.preferredDisplayMode != UISplitViewControllerDisplayModePrimaryHidden ? UISplitViewControllerDisplayModePrimaryHidden : UISplitViewControllerDisplayModeAutomatic);
    }];
}

- (UIResponder *)nextResponder{
    return UIApplication.sharedApplication;
}

@end
//
@implementation UISplitViewController (SceneDelegate)



//- (IBAction)goBack:(id)sender{
// //   [self.navigationController popViewControllerAnimated:NO];
//    
//}

@end


