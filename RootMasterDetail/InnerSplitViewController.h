//
//  InnerSplitViewController.h
//  RootMasterDetail
//
//  Created by Malcolm Hall on 10/01/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol InnerSplitViewControllerDelegate;

@interface InnerSplitViewController : UISplitViewController

@property (strong, nonatomic, readonly) UIViewController *masterViewController;

@end

@protocol InnerSplitViewControllerDelegate
//animationControllerForOperation:(UINavigationControllerOperation)operation

@end

NS_ASSUME_NONNULL_END
