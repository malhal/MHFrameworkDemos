//
//  DetailNavigationController.m
//  BasicMasterDetail
//
//  Created by Malcolm Hall on 30/05/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "DetailNavigationController.h"

NSString * const DetailNavigationControllerWillMoveNotification = @"DetailNavigationControllerWillMoveNotification";

@interface DetailNavigationController ()
- (BOOL)_allowNestedNavigationControllers;
@end

@implementation DetailNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//[self.view layoutIfNeeded]; // also fixes nav bar item?
        
//    }
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
  //  if(parent){
   //     [NSNotificationCenter.defaultCenter postNotificationName:DetailNavigationControllerWillMoveNotification object:self];
 //   }
 //   [self.viewControllers.firstObject didMoveToParentViewController:parent];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// how about if the sender is our dunno. Sender is a middle view controller.
- (void)showViewController:(UIViewController *)vc sender:(id)sender{
    BOOL b = [self _allowNestedNavigationControllers];
    //[super showViewController:vc sender:sender];
   
//    if(![vc isKindOfClass:UINavigationController.class]){
//        return [super showViewController:vc sender:sender];
//    }
    //[self.parentViewController showViewController:vc sender:sender];
    
    //NSArray *viewControllers = self.navigationController.viewControllers;
    
    // to allow a push 
    if([sender isKindOfClass:UIView.class]){
        [super showViewController:vc sender:sender];
        return;
    }
//    else if(viewControllers.count > 1){

    UINavigationController *nav = self.navigationController;
    UINavigationController *nav2 = [[sender navigationController] navigationController];
    if(!nav){
        nav = nav2;
    }
    
    NSArray *viewControllers = nav.viewControllers;
    //    if(viewControllers.count > 1){
    //        nav.viewControllers = @[viewControllers.firstObject, vc];
    //    }
    NSArray *viewControllerClasses = [viewControllers valueForKey:@"class"];
    if([viewControllerClasses containsObject:vc.class]){
        NSUInteger i = [viewControllerClasses indexOfObject:vc.class];
        if(i >= 0){
            NSMutableArray *a = viewControllers.mutableCopy;
            [a replaceObjectAtIndex:i withObject:vc];
            [nav setViewControllers:a animated:NO];
        }
    }

//    UINavigationController *nav = self.navigationController;
//    NSArray *viewControllers = self.navigationController.viewControllers;
//    if(viewControllers.count > 1){
//        NSMutableArray *array = viewControllers.mutableCopy; // start and middle in the array but going to show end so want to skip it
//        [array removeLastObject];
//        [array addObject:vc];
//        self.navigationController.viewControllers = array;//@[self.viewControllers.firstObject, vc];
//    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  //  [self.view layoutIfNeeded];
}

//- (void)setDetailItem:(id)detailItem{
//    if(detailItem == _detailItem){
//        return;
//    }
//    _detailItem = detailItem;
//    [NSNotificationCenter.defaultCenter postNotificationName:DetailNavigationControllerDetailItemChangedNotification object:self];
//}

@end

@implementation UIViewController (DetailNavigationController)

- (DetailNavigationController *)detailNavigationController{
    UINavigationController *nav = self.navigationController;
    if([nav isKindOfClass:DetailNavigationController.class]){
        return (DetailNavigationController *)nav;
    }
    return nav.detailNavigationController;
}

@end
