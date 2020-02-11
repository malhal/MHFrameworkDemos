//
//  MiddleTableViewController.h
//  BasicSplit
//
//  Created by Malcolm Hall on 04/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BasicSplit+CoreDataModel.h"
#import "CollapseController.h"

@class EndViewController, DetailNavigationController;
@protocol MiddleTableViewControllerDelegate;

@interface MiddleTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIDataSourceModelAssociation>

@property (strong, nonatomic) NSFetchedResultsController<Event *> *fetchedResultsController;

@property (strong, nonatomic) UISplitViewController *outerSplitViewController;

//@property (strong, nonatomic) DetailNavigationController *detailNavigationController;

// defaults to master item's context
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

// given to table from the 
//@property (strong, nonatomic) CollapseController *innerCollapseController;

//@property (strong, nonatomic) Event *selectedEvent;

// the split view controller that will show the detail for this master.
//@property (strong, nonatomic) UISplitViewController *detailSplitViewController;

@property (strong, nonatomic) id<MiddleTableViewControllerDelegate> delegate;

@property (strong, nonatomic) DetailItem *selectedDetailItem;
//@property (strong, nonatomic) CollapseController *collapseController;

@end
//
@protocol MiddleTableViewControllerDelegate <NSObject>

- (void)middleTableViewController:(MiddleTableViewController *)controller didCreateDetailNavigationController:(DetailNavigationController *)detailNavigationController;

@end

