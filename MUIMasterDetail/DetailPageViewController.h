//
//  DetailPageViewController.h
//  Paging1
//
//  Created by Malcolm Hall on 04/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <CoreData/CoreData.h>
#import "MUIMasterDetail+CoreDataModel.h"

@class DetailViewController;

@interface DetailPageViewController : MUIFetchedPageViewController<Event *>

//@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *trashButton, *upButton, *downButton;
@property (strong, nonatomic) ListItem *parentListItem;

@end

