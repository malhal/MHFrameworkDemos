//
//  Venue+CoreDataClass.h
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 21/05/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MMShared/MMShared.h>

@class Event;

NS_ASSUME_NONNULL_BEGIN

@interface Venue : NSManagedObject

- (NSInteger)numberOfEvents;

@end

NS_ASSUME_NONNULL_END

#import "Venue+CoreDataProperties.h"
