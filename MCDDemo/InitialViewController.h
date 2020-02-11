//
//  InitialViewController.h
//  MCDDemo
//
//  Created by Malcolm Hall on 09/08/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
//#import <MCoreData/MCoreData.h>
#import "MCoreDataDemo+CoreDataModel.h"
//#import "DetailViewController.h"

@class MasterViewController, MUIFetchedTableRowsController;

@interface InitialViewController : UITableViewController <UIDataSourceModelAssociation>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//@property (strong, nonatomic) MasterViewController *masterViewController;

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) MUIFetchedTableRowsController *fetchedTableRowsController;
//@property (strong, nonatomic) MUIFetchedTableRowsController *itemSplitter;
@end
