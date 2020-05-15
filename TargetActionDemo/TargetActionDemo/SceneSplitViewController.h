//
//  SceneSplitViewController.h
//  TargetActionDemo
//
//  Created by Malcolm Hall on 18/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <MCoreData/MCoreData.h>
#import "TargetActionDemo+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@class PersistentContainer;

@interface SceneSplitViewController : UISplitViewController



@end

@interface UIViewController (SceneSplitViewController)

//- (void)selectEvent:(Event *)event sender:(id)sender;
//- (PersistentContainer *)persistentContainerWithSender:(id)sender;

- (SceneSplitViewController *)sceneSplitViewController;

@end


NS_ASSUME_NONNULL_END
