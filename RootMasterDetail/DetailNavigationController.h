//
//  DetailNavigationController.h
//  BasicMasterDetail
//
//  Created by Malcolm Hall on 30/05/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const DetailNavigationControllerWillMoveNotification;

@interface DetailNavigationController : UINavigationController

//@property (strong, nonatomic) id detailItem;

//@property (strong, nonatomic) UISplitViewController* targetSplitViewController;

@end

@interface UIViewController (DetailNavigationController)

@property (strong, nonatomic, readonly) DetailNavigationController *detailNavigationController;

@end

NS_ASSUME_NONNULL_END
