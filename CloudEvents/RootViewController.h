//
//  RootViewController.h
//  CloudEvents
//
//  Created by Malcolm Hall on 05/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCoreData/MCoreData.h>
#import "CloudEvents+CoreDataModel.h"
#import <MUIKit/MUIKit.h>
#import "MasterViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class RootViewController, PersistentContainer;
//@protocol RootViewControllerDelegate <MUIListViewControllerDelegate>
//
//- (void)rootViewControllerDidSave:(RootViewController *)rootViewController;
//
//@end

@interface RootViewController : MUIFetchedTableViewController

@property (strong, nonatomic) PersistentContainer *persistentContainer;

// it needs to keep it alive so it can process events.
// but not necessarily the view controller does only what is doing the showing etc.
@property (strong, nonatomic) MasterViewController *masterViewController;

@property (strong, nonatomic) City *rootItem;
//@property (strong, nonatomic) NSManagedObjectID *cityID;

//@property (weak, nonatomic) id<RootViewControllerDelegate> delegate;

@end



NS_ASSUME_NONNULL_END
