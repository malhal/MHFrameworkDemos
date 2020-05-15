//
//  MasterViewController.h
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 23/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <CoreData/CoreData.h>
#import "MUIMasterDetail+CoreDataModel.h"


NS_ASSUME_NONNULL_BEGIN

@class DetailViewController, PersistentContainer, DetailContext;

@interface MasterViewController : MUIFetchedPageViewController //<Venue *> 

//@property (weak, nonatomic) NSObject<MUIViewControllerSelecting> *selection;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButtonItem;
//@property (strong, nonatomic) PersistentContainer *persistentContainer;
//@property (strong, nonatomic) DetailContext *detailContext;

@property (strong, nonatomic) ListItem *parentListItem;

- (void)malc;

@end


NS_ASSUME_NONNULL_END
