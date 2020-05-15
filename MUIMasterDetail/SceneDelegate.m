//
//  SceneDelegate.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 23/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "SceneDelegate.h"
#import "AppDelegate.h"
#import "DetailPageViewController.h"
#import "MasterViewController.h"
#import "PersistentContainer.h"

@interface SceneDelegate () <UIWindowSceneDelegate, UISplitViewControllerDelegate, UIPageViewControllerDelegate, MUIDelegateSelection>

@property (strong, nonatomic) UIViewController *detailViewController;
@property (strong, nonatomic) id selectedObject;

//@property (strong, nonatomic) MUIFetchedPageViewControllerDelegate *fetchedPageViewControllerDelegate;

@end

@implementation SceneDelegate
//@synthesize selectedObjectForViewController = _selectedObjectForViewController;

//+ (NSSet<NSString *> *)keyPathsForValuesAffectingSelectedObjectForViewController
//{
//    return [NSSet setWithObjects:@"detail.viewControllers", nil];
//}
//
//- (NSObject *)selectedObjectForViewController{
//    return [(DetailViewController *)self.detail.viewControllers.firstObject detailItem];
//}

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *detailNavigationController = splitViewController.viewControllers.lastObject;
    detailNavigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    detailNavigationController.topViewController.navigationItem.leftItemsSupplementBackButton = YES;
    splitViewController.delegate = self;
    
    UINavigationController *masterNavigationController = splitViewController.viewControllers.firstObject;

    NSManagedObjectContext *context = ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.viewContext;
    
    //self.fetchedPageViewControllerDelegate = [MUIFetchedPageViewControllerDelegate.alloc init];
    //self.fetchedPageViewControllerDelegate.managedObjectContext = context;
    
    MasterViewController *controller = (MasterViewController *)masterNavigationController.topViewController;
    
    //controller.managedObjectContext = context;
   // controller.fetchRequest = [Event fetchRequestWithParentListItem:nil];
   // [controller malc];
    
    controller.delegate = self;//self.fetchedPageViewControllerDelegate;
    
    DetailPageViewController *detailPageController = detailNavigationController.childViewControllers.firstObject;
    detailPageController.managedObjectContext = context;
    //controller.detailNavigationController = detailNavigationController;
    //controller.selection = self;
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

- (BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(id)sender{
    //self.detailViewController = vc;

    UINavigationController *masterNavigationController = splitViewController.viewControllers.firstObject;
    

    
    return NO;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    //if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
//    } else {
//        return NO;
//    }
}

- (id)selectedPageObjectInViewController:(UIViewController *)viewController{
    return nil;
}

@end

@implementation UISplitViewController (SceneDelegate)

//- (UIViewController *)mui_currentDetailViewControllerWithSender:(id)sender{
//    return ((SceneDelegate *)self.viewIfLoaded.window.windowScene.delegate).detailViewController;
//}

- (NSManagedObjectContext *)managedObjectContextWithSender:(id)sender{
    return ((AppDelegate *)UIApplication.sharedApplication.delegate).persistentContainer.viewContext;
}

@end
