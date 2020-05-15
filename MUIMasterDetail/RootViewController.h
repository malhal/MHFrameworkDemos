//
//  RootViewController.h
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 26/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PersistentContainer;
@interface RootViewController : UIViewController

@property (strong, nonatomic) PersistentContainer *persistentContainer;

@end

NS_ASSUME_NONNULL_END
