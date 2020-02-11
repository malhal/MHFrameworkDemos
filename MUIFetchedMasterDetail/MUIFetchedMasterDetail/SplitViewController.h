//
//  SplitViewController.h
//  SingleSource
//
//  Created by Malcolm Hall on 12/01/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//
// Manages selection.
// Since deletion is not a model action it is not done in here?

#import <UIKit/UIKit.h>
#import "MUIFetchedMasterDetail+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const SplitViewControllerWillShowViewController;
extern NSString * const SplitViewControllerDidChangeCurrentDetailItem;
//extern NSString * const SplitViewControllerDidChangeMasterObjects;

@interface SplitViewController : UISplitViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic, readonly) Event *currentDetailItem;

@end

@interface UIViewController (SplitViewController)

- (SplitViewController *)mh_splitViewController;
// this could be the array of objects that are selectable!
//- (void)setMasterObjects:(NSArray *)objects sender:(id)sender;
//- (void)setMasterFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController sender:(id)sender;
- (void)setCurrentDetailItem:(Event *)event sender:(id)sender;

@end

NS_ASSUME_NONNULL_END
