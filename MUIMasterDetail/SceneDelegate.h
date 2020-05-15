//
//  SceneDelegate.h
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 23/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MUIMasterDetail+CoreDataModel.h"

@interface SceneDelegate : UIResponder

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Event *detailItem;

@end

