//
//  MasterTableViewController.h
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 05/03/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <CoreData/CoreData.h>
#import "MUIMasterDetail+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@class DetailViewController;

@interface MasterTableViewController : MUIFetchedTableViewController //<MUIFetchedPageViewControllerDelegate>

//@property (strong, nonatomic) Venue *venue;

@end

NS_ASSUME_NONNULL_END
