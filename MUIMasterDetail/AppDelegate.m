//
//  AppDelegate.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 24/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>// <MUIDetailItemSplitterDelegate>

//@property (nonatomic, strong) MUIDetailItemSplitter *splitter;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;
    
 //   self.splitter = [MUIDetailItemSplitter.alloc initWithSplitViewController:splitViewController];
//    self.splitter.delegate = self;
    
    return YES;
}

//- (BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(id)sender{
//
//    return NO;
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
}


#pragma mark - Split view

//- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    //if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] mui_detailItem] == nil)) {
 //   if(!secondaryViewController.mui_detailItem){
   //     return YES;
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
 //   }
//    } else {
//
//    }
 //    return NO;
//}
//
//- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController
//{
//    if(primaryViewController.mui_detailItem){
//        // Do the standard behavior if we have a photo
//        return nil;
//    }
//    // If there's no content on the navigation stack, make an empty view controller for the detail side
//    return [splitViewController.storyboard instantiateViewControllerWithIdentifier:@"DetailNavigationController"];
//}

//- (UIViewController *)createDetailViewControllerForDetailSplitter:(MUIDetailItemSplitter *)detailItemSplitter{
//    return [detailItemSplitter.splitController.storyboard instantiateViewControllerWithIdentifier:@"DetailNavigationController"];
//}

@end
