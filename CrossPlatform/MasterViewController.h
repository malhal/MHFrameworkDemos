//
//  MasterViewController.h
//  CrossPlatform
//
//  Created by Malcolm Hall on 19/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CrossPlatform+CoreDataModel.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController<Event *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic, readonly) UIBarButtonItem *addButtonItem;

@end


@interface UIViewController (MasterViewController)

- (Event *)selectedDetailItemWithSender:(id)sender;

@end
