//
//  SceneViewController.m
//  TargetActionDemo
//
//  Created by Malcolm Hall on 18/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "SceneViewController.h"

@interface SceneViewController () <UISplitViewControllerDelegate>

@end

@implementation SceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self setOverrideTraitCollection:[UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular] forChildViewController:self.childViewControllers.firstObject];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UISplitViewController *splitViewController = segue.destinationViewController;
    splitViewController.delegate = self;
    splitViewController.primaryBackgroundStyle = UISplitViewControllerBackgroundStyleSidebar;
}


//- (UISplitViewControllerDisplayMode)targetDisplayModeForActionInSplitViewController:(UISplitViewController *)svc{
//    return UISplitViewControllerDisplayModePrimaryOverlay;
//}

@end

@implementation UIViewController (SceneViewController)

- (SceneViewController *)sceneViewController{
    UIViewController *vc = self.parentViewController;
       if([vc isKindOfClass:SceneViewController.class]){
           return (SceneViewController *)vc;
       }
       return vc.sceneViewController;
}

@end
