//
//  SceneDelegate.h
//  CrossPlatform
//
//  Created by Malcolm Hall on 19/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface SceneDelegate : UIResponder <UIWindowSceneDelegate, UISplitViewControllerDelegate>

@property (strong, nonatomic) UIWindow * window;
@property (strong, nonatomic, readonly) NSPersistentContainer *persistentContainer;
@end

