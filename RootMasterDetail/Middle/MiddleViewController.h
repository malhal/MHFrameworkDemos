//
//  MiddleViewController.h
//  TableContainerTest
//
//  Created by Malcolm Hall on 24/01/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <MCoreData/MCoreData.h>
#import "BasicSplit+CoreDataModel.h"
//#import "SelectedItemController.h"
//#import "MasterTableViewController.h"
#import "EndViewController.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const MiddleViewControllerItemKey;

//@protocol MiddleViewControllerDelegate;

@interface MiddleViewController : MUIMasterViewController 

// defaults to masterItem.context
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Venue *detailItem;
//@property (strong, nonatomic) NSFetchedResultsController<Event *> *fetchedResultsController;
@property (strong, nonatomic) UIBarButtonItem *deleteBarButtonItem;
@property (strong, nonatomic) UIBarButtonItem *addButtonItem;
@property (strong, nonatomic) UIBarButtonItem *addEmployeeButtonItem;
//@property (weak, nonatomic) id<MiddleViewControllerDelegate> delegate;
//@property (strong, nonatomic) SelectedItemController *middleEndSelectedItemController;

 // not valid until view is loaded cause embedded
//@property (strong, nonatomic) UISplitViewController *

//@property (strong, nonatomic) Venue *selectedItem;

//@property (strong, nonatomic) EndViewController *detailViewController;


//- (void)setMiddleItem:(Venue *)middleItem targetSplitViewController:(UISplitViewController *)splitViewController shownDetailNavigationController:(DetailNavigationController *)detailNavigationController;


@end

//@protocol MiddleViewControllerDelegate <NSObject>
//
//- (void)middleViewControllerDeleteTapped:(MiddleViewController *)middleViewController;
//
//@end




NS_ASSUME_NONNULL_END
