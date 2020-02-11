//
//  CityListViewController.h
//  CloudEvents
//
//  Created by Malcolm Hall on 26/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <MCoreData/MCoreData.h>
#import "CloudEvents+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@class PersistentContainer, RootViewController;

@interface CityListViewController : MUIFetchedTableViewController

@property (strong, nonatomic) PersistentContainer *persistentContainer;

// it needs to keep it alive so it can process events.
// but not necessarily the view controller does only what is doing the showing etc.
@property (strong, nonatomic) RootViewController *rootViewController;
//@property (strong, nonatomic) MUIFetchedTableViewController *masterTable;

- (BOOL)contansDetailItem:(id)detailItem;

@end

NS_ASSUME_NONNULL_END
