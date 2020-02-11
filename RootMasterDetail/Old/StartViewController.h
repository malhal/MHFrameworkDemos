//
//  StartViewController.h
//  BasicSplit
//
//  Created by Malcolm Hall on 08/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BasicSplit+CoreDataModel.h"
#import "CollapseController.h"

@class MiddleViewController;

NS_ASSUME_NONNULL_BEGIN

@interface StartViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIDataSourceModelAssociation, CollapseControllerDelegate>

//@property (strong, nonatomic) MiddleViewController *middleViewController;
@property (strong, nonatomic) NSFetchedResultsController<Venue *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UISplitViewController *innerSplitViewController;
@property (strong, nonatomic) UISplitViewController *outerSplitViewController;

@property (strong, nonatomic) UINavigationController *detailNavigationController;
@property (strong, nonatomic) Venue *selectedDetailItem; // reason for this is if the detail is not showing then it is not restored.

@property (strong, nonatomic) CollapseController *middleEndCollapseController;

@end

NS_ASSUME_NONNULL_END
