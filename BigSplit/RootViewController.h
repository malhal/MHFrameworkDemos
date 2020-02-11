//
//  MasterViewController.h
//  BigSplit
//
//  Created by Malcolm Hall on 11/08/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <CoreData/CoreData.h>
#import "BigSplit+CoreDataModel.h"

@class MasterViewController;

@interface RootViewController : MUITableViewController <MUIMasterCollapsing>// <NSFetchedResultsControllerDelegate>

//@property (strong, nonatomic) MasterViewController *masterViewController;
//@property (strong, nonatomic) MUICollapseController *collapseController;
@property (strong, nonatomic) NSFetchedResultsController<Venue *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Venue *venueForSegue;

@end

