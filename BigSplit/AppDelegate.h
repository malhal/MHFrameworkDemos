//
//  AppDelegate.h
//  BigSplit
//
//  Created by Malcolm Hall on 11/08/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//@property (nonatomic, assign) UIPopoverController *popoverController;
//#pragma clang diagnostic pop

- (void)saveContext;


@end

