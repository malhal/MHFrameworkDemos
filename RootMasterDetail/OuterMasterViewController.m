/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  A view controller container that forces its child to have different traits.
  
 */

#import "OuterMasterViewController.h"
#import "StartViewController.h"
#import "StartNavigationController.h"
#import "InnerSplitViewController.h"


@interface UINavigationController()

- (BOOL)_allowNestedNavigationControllers;

@end

@interface OuterMasterViewController ()
@property (copy, nonatomic) UITraitCollection *forcedTraitCollection;
//@property (strong, nonatomic) UISplitViewController *viewController;
@property (strong, nonatomic) MUIDetailViewManager *detailViewManager;

@end

@implementation OuterMasterViewController

//- (InnerSplitViewController *)innerSplitController{
//    return self.childViewControllers.firstObject;
//}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject:self.innerSplitController forKey:@"innerSplitController"];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //UITraitCollection *traits = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
    //[self setOverrideTraitCollection:traits forChildViewController:self.childViewControllers.firstObject];
    //self.forcedTraitCollection = traits;
    //[self configureTraitsWithSize:self.view.frame.size];
    
  //  self.startMiddleSelectedItemController = [SelectedItemController.alloc initWithSplitViewController:self.innerSplitController];
    //self.startMiddleSelectedItemController.delegate = self;
   // UINavigationController *nav = self.innerSplitController.viewControllers.firstObject;
   // self.startMiddleSelectedItemController.masterViewController = nav.topViewController;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
//    if (size.width > 320.0 && size.width > size.height) { // malcfix for iphone x
//        // If we are large enough, force a regular size class
//        self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
//    } else {
//        // Otherwise, don't override any traits
//        self.forcedTraitCollection = nil;
//    }
    //[self configureTraitsWithSize:size];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

// https://developer.apple.com/library/archive/qa/qa1890/_index.html
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self configureTraitsWithSize:self.view.frame.size];
}

- (void)configureTraitsWithSize:(CGSize)size{
    if(size.width < 640){ //< 1366){
        self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
    }
    else{
        self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
        self.innerSplitController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    }
}

- (void)updateForcedTraitCollection
{
    // Use our forcedTraitCollection to override our child's traits
    [self setOverrideTraitCollection:self.forcedTraitCollection forChildViewController:self.innerSplitController];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UISplitViewController *splitViewController = segue.destinationViewController;
    StartNavigationController *nav = splitViewController.viewControllers.firstObject;
    StartViewController *startViewController = (StartViewController *)nav.topViewController;
    //startViewController.middleEndSelectedItemController = self.middleEndSelectedItemController;
    //startViewController.persistentContainer = self.persistentContainer;
    self.innerSplitController = splitViewController;
    self.detailViewManager = [MUIDetailViewManager.alloc initWithSplitViewController:splitViewController];
}

- (void)setForcedTraitCollection:(UITraitCollection *)forcedTraitCollection
{
    if (_forcedTraitCollection != forcedTraitCollection) {
        _forcedTraitCollection = [forcedTraitCollection copy];
        [self updateForcedTraitCollection];
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    UITraitCollection *traits = self.traitCollection;
    NSLog(@"");
}

- (void)showViewController:(UIViewController *)vc sender:(id)sender{
    
//    //[self.innerSplitController showViewController:vc sender:sender];
    UINavigationController *nav = self.innerSplitController.viewControllers.firstObject;
//    BOOL a = nav._allowNestedNavigationControllers;
//    UINavigationController *nav2 = nav.topViewController;
//    BOOL b = nav2._allowNestedNavigationControllers;
//    NSIndexSet *indexSet = [nav.viewControllers indexesOfObjectsPassingTest:^BOOL(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        return [obj isKindOfClass:UINavigationController.class];
//    }];
//    if(indexSet.count > 1){
//        [UIView performWithoutAnimation:^{
//            [nav popToViewController:nav.viewControllers[indexSet.firstIndex] animated:NO];
//            [nav showViewController:vc sender:sender]; // only nav can show a nested.
//        }];
//    }else{
        [nav showViewController:vc sender:sender]; // only nav can show a nested.
   // }
//    UIViewController *vcBeforeNav;
//    for(UIViewController *child in nav.childViewControllers){
//        if([child isKindOfClass:UINavigationController.class] && [vcBeforeNav isKindOfClass:UINavigationController.class]){
//            [UIView performWithoutAnimation:^{
//                [nav popToViewController:vcBeforeNav animated:NO];
//                [nav showViewController:vc sender:sender]; // only nav can show a nested.
//            }];
//            return;
//        }
//        vcBeforeNav = child;
//    }
    

//
//  //  self.navigationBarHidden = NO;
//
//
//   //
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    [super pushViewController:viewController animated:animated];
//
//
//    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        [self setNavigationBarHidden:NO animated:YES];
//    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        if(context.isCancelled){
//            [self setNavigationBarHidden:YES animated:YES];
//        }
//    }];
//}

//- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
//   //
//    UIViewController * vc = [super popViewControllerAnimated:animated];
//    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        [self setNavigationBarHidden:YES animated:YES];
//    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        if(context.isCancelled){
//            [self setNavigationBarHidden:NO animated:YES];
//        }
//    }];
//    return vc;
//}

- (void)collapseSecondaryViewController:(UIViewController *)secondaryViewController forSplitViewController:(UISplitViewController *)splitViewController{
    UINavigationController *navigationController = (UINavigationController *)self.innerSplitController.masterViewController;
    NSArray *viewControllers = navigationController.viewControllers;
    if(viewControllers.count == 1){
        return;
    }
    [self.innerSplitController.masterViewController collapseSecondaryViewController:secondaryViewController forSplitViewController:splitViewController]; // pushViewController
}

- (nullable UIViewController *)separateSecondaryViewControllerForSplitViewController:(UISplitViewController *)splitViewController{
    UINavigationController *navigationController = (UINavigationController *)self.innerSplitController.masterViewController;
    NSArray *viewControllers = navigationController.viewControllers;
    if(viewControllers.count == 2){
        return nil;
    }
    UIViewController *result = [self.innerSplitController.masterViewController separateSecondaryViewControllerForSplitViewController:splitViewController];;
    return result;
}

- (BOOL)mui_willShowingDetailViewControllerPushWithSender:(id)sender{
    return [self.innerSplitController.viewControllers.firstObject mui_willShowingViewControllerPushWithSender:sender];
}

- (BOOL)mui_willShowingViewControllerPushWithSender:(id)sender{
    return [self.innerSplitController.viewControllers.firstObject mui_willShowingViewControllerPushWithSender:sender];
}

- (BOOL)mui_containsDetailItem:(id)object{
    return [self.innerSplitController mui_containsDetailItem:object];
}

- (id)mui_containedDetailItem{
    return [self.innerSplitController mui_containedDetailItem];
}

@end
