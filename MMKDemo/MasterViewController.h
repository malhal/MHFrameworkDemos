//
//  MasterViewController.h
//  MCoreLocationDemo
//
//  Created by Malcolm Hall on 13/10/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMShared/MMShared.h>

@class DetailViewController;

@interface MasterViewController : MMSMapViewController

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

