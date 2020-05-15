//
//  Event+CoreDataClass.h
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 17/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//
//

#import <CoreData/CoreData.h>
#import "ListItem+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@class Folder;

@interface Event : ListItem

@property (nullable, nonatomic, retain) Folder *folder;
//@property (nullable, nonatomic, copy) NSDate *timestamp;

//+ (NSFetchRequest *)fetchRequestWithFolder:(Folder *)folder;

@end

NS_ASSUME_NONNULL_END

#import "Event+CoreDataProperties.h"
