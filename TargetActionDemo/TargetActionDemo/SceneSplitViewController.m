//
//  SceneSplitViewController.m
//  TargetActionDemo
//
//  Created by Malcolm Hall on 18/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "SceneSplitViewController.h"

@interface SceneSplitViewController ()

@end

@implementation SceneSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // self.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
  //  self.maximumPrimaryColumnWidth = 100;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    if(action == @selector(toggleMasterVisible:)){
//        return YES;
//    }
    return [super canPerformAction:action withSender:sender];
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

@implementation UIViewController (SceneSplitViewController)

- (SceneSplitViewController *)sceneSplitViewController{
    UISplitViewController *svc = self.splitViewController;
       if([svc isKindOfClass:SceneSplitViewController.class]){
           return (SceneSplitViewController *)svc;
       }
       return svc.sceneSplitViewController;
}

@end
