//
//  DetailNavigationController.h
//  TargetActionDemo
//
//  Created by Malcolm Hall on 16/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TargetActionDemo+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailNavigationController : UINavigationController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *previousButtonItem;
@property (strong, nonatomic, readonly) Event *detailItem;

@end

@interface UIViewController(DetailNavigationController)

@property (strong, nonatomic, readonly) DetailNavigationController *detailNavigationController;

@end

NS_ASSUME_NONNULL_END
