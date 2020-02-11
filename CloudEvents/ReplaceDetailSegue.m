//
//  ReplaceDetailSegue.m
//  CloudEvents
//
//  Created by Malcolm Hall on 21/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "ReplaceDetailSegue.h"

@implementation ReplaceDetailSegue


- (void)perform{
    
    
    
    UIViewController *masterViewController = self.sourceViewController;
    //   UINavigationController *destinationNavigationController = (UINavigationController *)self.destinationViewController;
    //   UIViewController *detailController = destinationNavigationController.topViewController;
    id b = self.sourceViewController;
    id c = self.sourceViewController.navigationController;
    id d = self.sourceViewController.navigationController.viewControllers;
    id e = self.destinationViewController;
    //    if(!self.animate){
    //        masterViewController.detailViewManagerForMaster.detailViewController = detailController;
    //        [super perform];
    //        return;
    //    }
    
    // balls the prepareforsegue has already set the shown view controlller
    
    
    //UIViewController *trashedDetailViewController = self.trashedDetailViewController;// masterViewController.navigationController.topViewController;
    //UIView *snapshotView = [trashedDetailViewController.navigationController._outermostNavigationController.view snapshotViewAfterScreenUpdates:NO];
    
    //if([self.sourceViewController.navigationController.topViewController isKindOfClass:UINavigationController.class]){ // or top view controller
    //if([self.sourceViewController.navigationController.viewControllers containsObject:self.sourceViewController.mui_viewedObjectViewController]){
    // if the source is not the top in the navigation
    
// not a good idea to not go through the split controller
//    UIViewController *topViewController = self.sourceViewController.navigationController.topViewController;
//    if(topViewController != self.sourceViewController){
//        if([topViewController isKindOfClass:UINavigationController.class]){
//            UINavigationController *topNav = (UINavigationController *)topViewController;
//
//            if([self.destinationViewController isKindOfClass:UINavigationController.class]){
//                UINavigationController *destinationNav = (UINavigationController *)self.destinationViewController;
//                topNav.viewControllers = destinationNav.viewControllers;
//            }
//        }
//    }
//    else{
        [super perform];
        // return;
   // }
    
    
    //    if(!snapshotView){
    //        return;
    //    }
    //
    //masterViewController.detailViewManagerForMaster.detailViewController = detailController;
    
    //UIView *view = [previousDetailViewController.deleteBarButtonItem valueForKey:@"view"];
    
    //    UINavigationController *a = destinationNavigationController._outermostNavigationController;
    //    id b = a.viewControllers.firstObject;
    //    CGRect rect = CGRectMake(snapshotView.frame.size.width-30, 40, 0, 0);// [view convertRect:view.frame toView:detailController.view.window];
    //
    // [super perform];
    
    //    [destinationNavigationController._outermostNavigationController.view addSubview:snapshotView];
    //    [CATransaction flush];
    
    //    [UIView beginAnimations:@"delete" context:NULL];
    //    //if(!detailController.detailItem){
    //    [UIView setAnimationDelegate:self];
    //    [UIView setAnimationDidStopSelector:@selector(animationDidStop:)];
    //    //}
    //    [UIView setAnimationTransition:103 forView:destinationNavigationController.navigationController.view cache:YES];
    //    [UIView setAnimationDuration:0.5f];
    //    [UIView setAnimationPosition:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))];
    //
    
    //    [UIView animateWithDuration:0.5 animations:^ {
    //        snapshotView.frame = rect;
    //    } completion:^(BOOL finished) {
    //        [snapshotView removeFromSuperview];
    //    }];
    
    //[UIView commitAnimations];
}

@end
