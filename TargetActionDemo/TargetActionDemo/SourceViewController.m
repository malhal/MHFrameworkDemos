//
//  SourceTabController.m
//  TargetActionDemo
//
//  Created by Malcolm Hall on 18/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "SourceViewController.h"
#import "SceneViewController.h"

@implementation SourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       
    id i = self.childViewControllers.firstObject;
    
    NSLog(@"");
   
  //  [self setOverrideTraitCollection:[UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact] forChildViewController:self.childViewControllers.firstObject];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    id i = self.sceneViewController;
    NSLog(@"");
     UIViewController *childController = self.childViewControllers.firstObject;
 //     UITraitCollection *tc = [UITraitCollection traitCollectionWithHorizontalSizeClass:self.sceneViewController.traitCollection.horizontalSizeClass];
 //     [self setOverrideTraitCollection:tc forChildViewController:childController];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)addChildViewController:(UIViewController *)childController{
    [super addChildViewController:childController];
 

}

@end
