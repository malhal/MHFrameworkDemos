//
//  MasterFetchedTableViewController.h
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 27/10/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <CoreData/CoreData.h>
#import "MUIFetchedMasterDetail+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MasterFetchedTableViewController : MUIFetchedTableViewController

@property (strong, nonatomic) NSManagedObject *masterItem;

@end

NS_ASSUME_NONNULL_END
