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

@class DetailViewController;

@interface MasterViewController : MUITableViewController <NSFetchedResultsControllerDelegate, MUIDetailCollapsing, MUIMasterCollapsing>

@property (strong, nonatomic) Venue *venue;

//@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController<Event *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

