//
//  InnerSplitViewController.m
//  RootMasterDetail
//
//  Created by Malcolm Hall on 10/01/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "InnerSplitViewController.h"

@interface InnerSplitViewController ()

@property (assign, nonatomic) BOOL overlayFix;

@end

@implementation InnerSplitViewController
@dynamic masterViewController; // private

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (void)showViewController:(UIViewController *)vc sender:(id)sender{
//    id i = self.childViewControllers;
//    UIViewController *firstChild = self.childViewControllers.firstObject;
//    [firstChild showViewController:vc sender:sender];
//}

- (UITraitCollection *)traitCollection{
    UITraitCollection *traitCollection = super.traitCollection;
    if(self.overlayFix){
        traitCollection = [UITraitCollection traitCollectionWithTraitsFromCollections:@[traitCollection, [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact]]];
    }
    return traitCollection;
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
}

- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
    if(self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryOverlay){
        self.overlayFix = YES;
    }
    id a = self.viewControllers;
    [super showDetailViewController:vc sender:sender];
    self.overlayFix = NO;
}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    if(action != @selector(showDetailViewController:sender:)){
//        return [super canPerformAction:action withSender:sender];
//    }
//    UINavigationController *nav = self.viewControllers.firstObject;
//    UIViewController *vc = nav.viewControllers.firstObject;
////    if([sender isMemberOfViewControllerHierarchy:vc]){
////        return [super canPerformAction:action withSender:sender];
////    }
//    return NO;
//}

// don't use because too hard to find the detail items when collapsed.
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    if(action != @selector(_prepareForTapGesture:)){
//        if(self.isCollapsed){
//            if([sender navigationController] != self.viewControllers.firstObject){
//                return NO;
//            }
//        }
//        else if([sender mui_isMemberOfViewControllerHierarchy:self.viewControllers.lastObject]){
//            return NO;
//        }
//    }
//    return [super canPerformAction:action withSender:sender];
//}

@end
