//
//  MasterNavigationController.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 18/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MasterNavigationController.h"

NSString * const MasterNavigationControllerDidChangeSelectedObject = @"MasterNavigationControllerDidChangeSelectedObject";

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

- (void)fetchedViewController:(MUIFetchedPageViewController *)fetchedViewController didSelectPageObject:(id)object{
    self.selectedObject = object;
    [NSNotificationCenter.defaultCenter postNotificationName:MasterNavigationControllerDidChangeSelectedObject object:self];
}


@end
