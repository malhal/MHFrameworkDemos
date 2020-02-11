//
//  AppDelegate.h
//  CloudEvents
//
//  Created by Malcolm Hall on 04/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class PersistentContainer;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) PersistentContainer *persistentContainer;

- (void)saveContext;


@end

