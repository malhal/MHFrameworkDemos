//
//  OuterSplitViewController.h
//  RootMasterDetail
//
//  Created by Malcolm Hall on 10/01/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OuterSplitViewControllerDelegate <UISplitViewControllerDelegate>

//- (nullable id <UIViewControllerAnimatedTransitioning>)splitViewController:(UISplitViewController *)splitViewController fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC;

@end

@class PersistentContainer;

// rename TripleSplitViewController
@interface OuterSplitViewController : UISplitViewController

@property (copy, nonatomic) UITraitCollection *forcedTraitCollection;

//@property (assign, nonatomic) CGSize targetViewSize;

//@property (nullable, nonatomic, weak) id <OuterSplitViewControllerDelegate> delegate;
- (void)updateForcedTraitCollection;

@property (strong, nonatomic) PersistentContainer *persistentContainer;

@end

@interface UIViewController (OuterSplitViewController)

@property (strong, nonatomic, readonly) OuterSplitViewController *outerSplitViewController;

@end

NS_ASSUME_NONNULL_END
