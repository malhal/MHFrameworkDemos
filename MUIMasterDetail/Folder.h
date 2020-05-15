//
//  Folder+CoreDataClass.h
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 17/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//
//

#import <CoreData/CoreData.h>
#import "ListItem.h"

NS_ASSUME_NONNULL_BEGIN

@class Event;

@interface Folder : ListItem

@property (nullable, nonatomic, retain) NSSet<Event *> *events;
@property (nullable, nonatomic, copy) NSDate *timestamp;

@property (nullable, nonatomic, retain) Folder *parent;

@end

NS_ASSUME_NONNULL_END

#import "Folder+CoreDataProperties.h"
