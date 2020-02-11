//
//  MasterNavigationController.m
//  MCDDemo
//
//  Created by Malcolm Hall on 04/01/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MasterNavigationController.h"

@interface MasterNavigationController ()

@end

@implementation MasterNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nullable UIViewController *)separateSecondaryViewControllerForSplitViewController:(UISplitViewController *)splitViewController{
    if(self.viewControllers.count < 3){
        return nil;
    }
    return [super separateSecondaryViewControllerForSplitViewController:splitViewController];
}

- (void)showViewController:(UIViewController *)vc sender:(id)sender{
    if(![sender isKindOfClass:UIView.class]){
        return;
    }
    [super showViewController:vc sender:sender];
}

@end
