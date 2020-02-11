//
//  OuterSplitViewController.m
//  RootMasterDetail
//
//  Created by Malcolm Hall on 10/01/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "OuterSplitViewController.h"

@interface OuterSplitViewController ()

@end

@interface PushAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@end

@interface PopAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@end

@implementation OuterSplitViewController
@dynamic delegate;

//- (BOOL)mui_willShowingDetailDetailViewControllerPushWithSender:(id)sender{
//    return [self mui_willShowingDetailViewControllerPushWithSender:sender];
//}

//- (id)mui_currentDetailDetailItemWithSender:(id)sender
//{
//    id i = self.viewControllers;
//    if (self.collapsed) {
//        // If we're collapsed, find the detail nav controller
//        return self.viewControllers.firstObject.mui_detailDetailItem;
//    } else {
//        // Otherwise, return our detail controller's contained photo (if any)
//        UIViewController *controller = self.viewControllers.lastObject;
//        return controller.mui_detailDetailItem;
//    }
//}

// must adapt to inital size
- (void)viewDidLoad {
    [super viewDidLoad];
    // if here then root/master is collapsed first, which is right. But it seems we dont have the items set up yet.
    CGSize size = self.view.frame.size;
    //self.targetViewSize = size;
    
  //  [self configureForcedTraitCollection];
    [self configureColumnsWithSize:size];
 //   [self configureTraitsWithSize:size];
   
 //   [self updateForcedTraitCollection]; // must be done for restoring in 2 column so empty detail doesnt appear in primary.
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject:self.forcedTraitCollection forKey:@"forcedTraitCollection"];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
    [super decodeRestorableStateWithCoder:coder]; // this dispatch asyncs change mode because there is no window
    
    // so we do need to decode the trait collection for when we have encoded the 2 column state otherwise seperate is called eronously.
//    self.forcedTraitCollection = [coder decodeObjectForKey:@"forcedTraitCollection"];

    //self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    dispatch_async(dispatch_get_main_queue(), ^{
        //self.preferredDisplayMode = UISplitViewControllerDisplayModeAutomatic;

    });
}

- (void)awakeFromNib{
    [super awakeFromNib];
    //self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
}


- (void) applicationFinishedRestoringState{
    NSLog(@"applicationFinishedRestoringState");
    id i = self.traitCollection;
    // restoring a 3 col to a 1 col needs this.
    // the inner must collapse before the outer.
    CGSize size = self.view.frame.size;
  //  self.targetViewSize = size;
    
  //  [self configureColumnsWithSize:size];
    [self configureTraitsWithSize:size];
    
    // we cant update to current traits here because the trait collection is still in the restored state.
    // updating it here would cause inner to seperate before outer.
}

// seems to only be called after applicationFinishedRestoringState.
// Doing something in here is only way to..?
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection{
//    // in here we only call super 
    NSLog(@"%@ %@ %@ %@", NSStringFromSelector(_cmd), self, previousTraitCollection, self.traitCollection);
    
    CGSize size = self.view.frame.size;
  //  [self configureTraitsWithSize:size];
//    [self configureColumnsWithSize:size];
    
    [super traitCollectionDidChange:previousTraitCollection];  // if its regular this overrides the child master to compact.
    
    
    //[self updateForcedTraitCollection];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGSize size = self.view.frame.size;
 //   [self configureColumnsWithSize:size];
 //   [self configureTraitsWithSize:size];
    // if here then master/detail is collapsed first because update traits causes child views to load.
    // here not view did load because of restore order. collapse would get called before it has item.
//self.preferredDisplayMode = UISplitViewControllerDisplayModeAutomatic;
}

// not called on first launch
- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    CGSize size = self.view.frame.size;
    
  //  self.forcedTraitCollection = nil;
  //  [self updateForcedTraitCollection];
    
  //  [self setOverrideTraitCollection:nil forChildViewController:self.viewControllers.firstObject];
    [super setViewControllers:viewControllers];
    
    
}

// called before restoring when launching in compact
// if moving to compact prob want to override child first, and if moving to regular want to override child first.
// mind it always starts in regular.
// I think I need to start assuming im on the biggest screen.
// try viewDidLayoutSubviews
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
//size not right yet
   // self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:newCollection.horizontalSizeClass];
   // [self updateForcedTraitCollection];
    
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    //[self configureTraitsWithSize:self.windowSize];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        // columns in here leave gray patch on portrait to landscape.
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        
        
    }];

}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{

    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    //[self.childViewControllers.firstObject viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
 //   [self configureTraitsWithSize:size];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        // columns in here leave gray patch on portrait to landscape.
  

//        [self configureTraitsWithSize:size];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        // needs to be in here so happens in right order.
        
         // needed to make inner collapse before outer when going from 3 to 1. Unnecessary if already called from willTransitino to traits
    
       [self configureColumnsWithSize:size];
     
  //      [self updateForcedTraitCollection];
    //
        
    }];
}


// called by UISplitViewControllerClassicImpl _setMasterOverrideTraitCollectionActive:
// which i guess is called by setViews
// its either called with nil or with horizontal.
// Its aim is to make the master compact when the real is regular. We only want compact when less than certain size.
// The problem is override is not always called.
- (void)setOverrideTraitCollection:(UITraitCollection *)collection forChildViewController:(UIViewController *)childViewController{
    NSLog(@"%@ %@ %@ %@", NSStringFromSelector(_cmd), self, collection, childViewController);
//    if(collection.horizontalSizeClass == UIUserInterfaceSizeClassCompact){
//        return;
//    }
    UITraitCollection *tc = collection;
    if(tc){
      //  tc = self.forcedTraitCollection;
    }
    //[super setOverrideTraitCollection:tc forChildViewController:childViewController];
    
    if(collection){
       // collection = self.forcedTraitCollection;
    }
    [super setOverrideTraitCollection:collection forChildViewController:childViewController];
}


- (void)configureTraitsWithSize:(CGSize)size{

    UITraitCollection *traits = self.traitCollection;
//    if(size.width >= 1280){ //< 1366){
//        self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
//    }
//    else{
//        self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
//    }
    
    if(size.width < 1280){ //< 1366){
        self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
    }
    else{
        self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
    }
    
}

- (void)configureColumnsWithSize:(CGSize)size{
    // check if we need to go back to 2 columns from 3
    if(size.width >= 1280){//1366){ // 1280  to allow for other sizes? check ipad mini. Which is 4x320
        
        // If we are large enough, force a regular size class
        // self.preferredPrimaryColumnWidthFraction = 0.5;
        //rootMasterSplitViewController.preferredPrimaryColumnWidthFraction = 0.5;
        
        self.maximumPrimaryColumnWidth = 640;//320 * 2;//MAXFLOAT;
        self.minimumPrimaryColumnWidth = 640;//320 * 2;
        
    //    self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
        //rootMasterSplitViewController.maximumPrimaryColumnWidth = MAXFLOAT;
        //  self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
    }
    else{
        // Otherwise, compact
        //self.preferredPrimaryColumnWidthFraction = UISplitViewControllerAutomaticDimension;
        //rootMasterSplitViewController.preferredPrimaryColumnWidthFraction = UISplitViewControllerAutomaticDimension;
        
        self.maximumPrimaryColumnWidth = UISplitViewControllerAutomaticDimension;//
        self.minimumPrimaryColumnWidth = UISplitViewControllerAutomaticDimension;
       // self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
        //rootMasterSplitViewController.maximumPrimaryColumnWidth = UISplitViewControllerAutomaticDimension;
        //self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
    }
}

- (void)setForcedTraitCollection:(UITraitCollection *)forcedTraitCollection
{
    if (_forcedTraitCollection == forcedTraitCollection) {
        return;
    }
    _forcedTraitCollection = forcedTraitCollection.copy;
    //[self updateForcedTraitCollection];
}

- (void)updateForcedTraitCollection
{
    //return;
    // Use our forcedTraitCollection to override our child's traits
    [super setOverrideTraitCollection:self.forcedTraitCollection forChildViewController:self.childSplitController];
}

- (UISplitViewController *)childSplitController{
    id i = self.viewControllers.firstObject;
    //return i; // sometimes is a nav controller
    return i;
}

- (void)mui_showDetailDetailViewController:(UIViewController *)vc sender:(id)sender{
    [self showDetailViewController:vc sender:sender];
}

- (void)showViewController:(UIViewController *)vc sender:(id)sender{
    [super showViewController:vc sender:sender];
}

- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
    //- (nullable id <UIViewControllerAnimatedTransitioning>)splitViewController:(UISplitViewController *)splitViewController fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC;
//    if(!self.isCollapsed){
//        id i = self.transitionCoordinator;
//         [self.delegate splitViewController:self fromViewController:self.viewControllers.lastObject toViewController:vc];
//    }
    [super showDetailViewController:vc sender:sender];
//    return;
//    UINavigationController *nav = self.viewControllers.lastObject;
//    nav.delegate = self;
//    [nav setViewControllers:@[vc] animated:YES];
}

//- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                            animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                         fromViewController:(UIViewController *)fromVC
//                                                           toViewController:(UIViewController *)toVC{
//    return PushAnimator.alloc.init;
//}

//- (id<UIViewControllerTransitionCoordinator>)transitionCoordinator{
//}

- (NSPersistentContainer *)mcd_persistentContainerWithSender:(id)sender{
    return self.persistentContainer;
}

@end

@implementation UIViewController (OuterSplitViewController)

- (OuterSplitViewController *)outerSplitViewController{
    UISplitViewController *splitViewController = self.splitViewController;
    if(![splitViewController isKindOfClass:OuterSplitViewController.class]){
        return splitViewController.outerSplitViewController;
    }
    return (OuterSplitViewController *)splitViewController;
}

@end

//@implementation PushAnimator
//
//- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
//{
//    return 0.5;
//}
//
//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
//{
//    UIViewController* toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//
//    [[transitionContext containerView] addSubview:toViewController.view];
//
//    toViewController.view.alpha = 0.0;
//
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        toViewController.view.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
//}
//
//@end
//
//@implementation PopAnimator
//
//- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
//{
//    return 0.5;
//}
//
//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
//{
//    UIViewController* toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//
//    [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
//
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        fromViewController.view.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
//}
//
//@end
