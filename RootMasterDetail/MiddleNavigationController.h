//
//  MiddleNavigationController.h
//  RootMasterDetail
//
//  Created by Malcolm Hall on 29/01/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//
// Suports replacing an existing
#import <MUIKit/MUIKit.h>
#import <MCoreData/MCoreData.h>
#import "DetailNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const MiddleNavigationControllerDetailItemDidChange;

@class SelectedItemController, OuterSplitViewController;

@interface MiddleNavigationController : DetailNavigationController

//@property (strong, nonatomic) NSManagedObject *detailItem;

//@property (strong, nonatomic) MiddleNavigationController* detailNavigatonController;

@property (nonatomic, nullable, readonly) SelectedItemController* selectedItemController;

@end

//@interface  UIViewController (MiddleNavigationController)

//- (MiddleNavigationController *)detailNavigationController;

//- (void)detailNavigationControllerDidSetDetailItem:(NSManagedObject *)detailItem;

//- (void)detailNavigationControllerDidSetSelectedItemController:(SelectedItemController *)selectedItemController;

//@end

NS_ASSUME_NONNULL_END
