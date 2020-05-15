//
//  SceneViewController.h
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

@interface SceneViewController : UIViewController

@property (strong, nonatomic) PersistentContainer *persistentContainer;

@end


@interface UIViewController (SceneViewController)

//- (void)selectEvent:(Event *)event sender:(id)sender;
//- (PersistentContainer *)persistentContainerWithSender:(id)sender;

- (SceneViewController *)sceneViewController;

@end

NS_ASSUME_NONNULL_END
