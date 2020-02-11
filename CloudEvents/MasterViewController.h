//
//  MasterViewController.h
//  CloudEvents
//
//  Created by Malcolm Hall on 04/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <MCoreData/MCoreData.h>
#import "CloudEvents+CoreDataModel.h"

//#import "SelectionManager.h"

//@class MasterViewController;
//@protocol MasterViewControllerDelegate <MUIListViewControllerDelegate, MUIMasterTableDelegate>
//
//- (void)masterViewControllerDidSave:(MasterViewController *)masterViewController;
//
//@end



@class RootViewController, DetailViewController, PersistentContainer;

@interface MasterViewController : MUIMasterViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) PersistentContainer *persistentContainer;

@property (strong, nonatomic) Venue *masterItem;
//- (BOOL)contansDetailItem:(id)detailItem;

//@property (weak, nonatomic) id<MasterViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *trashButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *button;

//@property (weak, nonatomic) RootViewController *rootViewController;

- (instancetype)initWithCoder:(NSCoder *)coder masterItem:(Venue *)masterItem persistentContainer:(PersistentContainer *)persistentContainer;

@end

