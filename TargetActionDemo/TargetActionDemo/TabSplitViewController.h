//
//  SplitViewController.h
//  TargetActionDemo
//
//  Created by Malcolm Hall on 15/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <MCoreData/MCoreData.h>
#import "TargetActionDemo+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN


extern NSString * const PersistentContainerResultsChanged;
extern NSString * const SelectedEventChanged;
extern NSString * const TabSplitViewControllerCurrentDetailItemChanged;

@class PersistentContainer, DetailNavigationController;

@interface TabSplitViewController : UISplitViewController

//@property (strong, nonatomic) NSFetchedResultsController<Event *> *fetchedResultsController;

//@property (strong, nonatomic, readonly) Event *selectedEvent;

//@property (strong, nonatomic, readonly) NSIndexPath *indexPathForSelectedEvent;



@property (strong, nonatomic, readonly) Event *currentDetailItem;

@end

@interface UIViewController(TabSplitViewController)

//- (void)selectEvent:(Event *)event sender:(id)sender;
//- (PersistentContainer *)persistentContainerWithSender:(id)sender;

- (TabSplitViewController *)tabSplitViewController;

@end

NS_ASSUME_NONNULL_END
