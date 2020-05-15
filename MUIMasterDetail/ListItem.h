//
//  Event+CoreDataClass.h
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 28/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


NS_ASSUME_NONNULL_BEGIN


@interface ListItem : NSManagedObject

+ (NSFetchRequest<ListItem *> *)myFetchRequest;
+ (NSFetchRequest<ListItem *> *)fetchRequestWithParentListItem:(nullable ListItem *)parent;
//+ (NSFetchRequest<ListItem *> *)fetchRequestWithVenue:(nullable Venue *)venue;
@end

NS_ASSUME_NONNULL_END

#import "ListItem+CoreDataProperties.h"
