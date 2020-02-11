//
//  RootViewController.h
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 13/09/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <CoreData/CoreData.h>
#import "MUIFetchedMasterDetail+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@class MasterViewController, PersistentContainer;

@interface RootViewController : MUIFetchedTableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (strong, nonatomic) MasterViewController *masterViewController;
//@property (strong, nonatomic) NSFetchedResultsController<Venue *> *fetchedResultsController;



@end

NS_ASSUME_NONNULL_END
