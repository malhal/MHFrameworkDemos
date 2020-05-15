//
//  PersistentContainer.h
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 23/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MUIMasterDetail+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface PersistentContainer : NSPersistentContainer


//@property (strong, nonatomic) Event *selectedDetailItem;

-(NSFetchedResultsController *)newFetchedResultsController;

@end

NS_ASSUME_NONNULL_END
