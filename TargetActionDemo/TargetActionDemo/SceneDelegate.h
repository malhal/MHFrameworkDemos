//
//  SceneDelegate.h
//  TargetActionDemo
//
//  Created by Malcolm Hall on 15/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//extern NSString * const SelectedEventChanged;

@class PersistentContainer;

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property (strong, nonatomic) UIWindow * window;
//- (PersistentContainer *)persistentContainer;

@end

NS_ASSUME_NONNULL_END
