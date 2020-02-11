/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  A view controller container that forces its child to have different traits.
  
 */

#import <MUIKit/MUIKit.h>
#import "InnerSplitViewController.h"

@class SelectedItemController, PersistentContainer;

@interface OuterMasterViewController : UIViewController

@property (weak, nonatomic) InnerSplitViewController *innerSplitController;

@end
