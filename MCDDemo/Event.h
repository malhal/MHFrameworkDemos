//
//  Event+CoreDataClass.h
//  MCDDemo
//
//  Created by Malcolm Hall on 16/05/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//
//

#import <MUIKit/MUIKit.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@class Attendee, Venue;

@interface Event : NSManagedObject <MUITableViewCellObject>

@end

NS_ASSUME_NONNULL_END

#import "Event+CoreDataProperties.h"
