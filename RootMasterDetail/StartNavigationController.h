//
//  NavigationController.h
//  RootMasterDetail
//
//  Created by Malcolm Hall on 08/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import "MiddleNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

// NestNavigationController
@interface StartNavigationController : UINavigationController

@end

@interface  UIViewController (StartNavigationController)

- (StartNavigationController *)innerMasterNavigationController;

@end

NS_ASSUME_NONNULL_END
