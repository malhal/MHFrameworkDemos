//
//  RootViewController.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 26/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "RootViewController.h"
#import "MasterViewController.h"

@interface RootViewController ()

@property (strong, nonatomic) MasterViewController *masterViewController;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    MasterViewController *mvc = (MasterViewController *)segue.destinationViewController;
  //  mvc.persistentContainer = self.persistentContainer;
    //mvc.detailNavigationController = self.masterViewController.detailNavigationController;
    self.masterViewController = mvc;
}

@end
