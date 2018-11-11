//
//  MasterViewController.h
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 24/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>

@class DetailViewController;

@interface MasterViewController : MUITableViewController // MUIMasterTableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

