//
//  Venue+CoreDataClass.h
//  CloudEvents
//
//  Created by Malcolm Hall on 03/10/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, Event;

NS_ASSUME_NONNULL_BEGIN

@interface Venue : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Venue+CoreDataProperties.h"
