//
//  MasterViewController.h
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 16/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MMShared/MMShared.h>
#import <CoreData/CoreData.h>
#import "MUIFetchedMasterDetail+CoreDataModel.h"

@class DetailViewController, PersistentContainer;

@interface MasterViewController : UITableViewController //<UIDataSourceModelAssociation>

//@property (strong, nonatomic) DetailViewController *detailViewController;

//@property (strong, nonatomic) PersistentContainer *persistentContainer;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext; // despite needing a master item it also needs this otherwise can fail when masterItem is deleted and has lost its context.
//@property (strong, nonatomic) Venue *masterItem;
@property (strong, nonatomic) NSManagedObject *masterItem;

//@property (weak, nonatomic) IBOutlet MMSFetchedResultsTableViewControllerImpl *fetchedResultsTableViewControllerImpl;

//- (instancetype)initWithCoder:(NSCoder *)coder masterItem:(Venue *)masterItem persistentContainer:(PersistentContainer *)persistentContainer;

@end

