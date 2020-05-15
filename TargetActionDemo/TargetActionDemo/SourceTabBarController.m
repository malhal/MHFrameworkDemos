//
//  SourceTabBarController.m
//  TargetActionDemo
//
//  Created by Malcolm Hall on 18/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "SourceTabBarController.h"
#import "TabSplitViewController.h"
#import "DetailViewController.h"

@interface SourceTabBarController () <UISplitViewControllerDelegate>

@end

@implementation SourceTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TabSplitViewController *split = self.childViewControllers.firstObject;
    split.delegate = self;
    NSLog(@"");
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]]
        //&& ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        && ![(TabSplitViewController *)splitViewController currentDetailItem]){
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
