//
//  AppDelegate.h
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 23/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class PersistentContainer;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) PersistentContainer *persistentContainer;

- (void)saveContext;


@end

