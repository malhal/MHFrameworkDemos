//
//  MasterViewController.h
//  CoreDataCloudKitDemo2
//
//  Created by Malcolm Hall on 09/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <CoreData/CoreData.h>
#import "MHCoreDataCloudKitDemo+CoreDataModel.h"

@class DetailViewController;

@interface MasterViewController : MUIFetchedTableViewController<Post *>

//@property (strong, nonatomic) DetailViewController *detailViewController;

//@property (strong, nonatomic) NSFetchedResultsController<Post *> *fetchedResultsController;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, strong) NSPersistentCloudKitContainer *persistentContainer;


@end

