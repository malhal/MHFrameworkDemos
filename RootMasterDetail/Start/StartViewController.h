//
//  StartViewController.h
//  BasicSplit
//
//  Created by Malcolm Hall on 08/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <MCoreData/MCoreData.h>
#import "BasicSplit+CoreDataModel.h"
//#import "SelectedItemController.h"

@class MiddleViewController;

NS_ASSUME_NONNULL_BEGIN

@interface StartViewController : MUIMasterViewController <NSFetchedResultsControllerDelegate, UIDataSourceModelAssociation, UISplitViewControllerDelegate>

@property (strong, nonatomic) MiddleViewController *middleViewController;
//@property (strong, nonatomic) NSFetchedResultsController<Venue *> *fetchedResultsController;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//@property (strong, nonatomic) UISplitViewController *innerSplitViewController;
//@property (strong, nonatomic) UISplitViewController *outerSplitViewController;

//@property (strong, nonatomic) UINavigationController *detailNavigationController;
//@property (strong, nonatomic) Venue *selectedItem; // reason for this is if the detail is not showing then it is not restored.

//@property (strong, nonatomic) SelectedItemController *middleEndSelectedItemController;
//@property (strong, nonatomic) SelectedItemController *startMiddleSelectedItemController;

@end

NS_ASSUME_NONNULL_END
