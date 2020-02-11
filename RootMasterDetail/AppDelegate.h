//
//  AppDelegate.h
//  BasicSplit
//
//  Created by Malcolm Hall on 04/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class PersistentContainer;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) PersistentContainer *persistentContainer;

- (void)saveContext;

@end
