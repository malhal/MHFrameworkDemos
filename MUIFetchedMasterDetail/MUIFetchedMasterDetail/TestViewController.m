//
//  TestViewController.m
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 13/09/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

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

- (IBAction)buttonTapped:(id)sender{
    [NSNotificationCenter.defaultCenter postNotificationName:@"TestViewControllerButtonTapped" object:nil];
}

@end
