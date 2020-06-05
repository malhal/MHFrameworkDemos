//
//  Venue+CoreDataClass.m
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 21/05/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//
//

#import "Venue.h"

@implementation Venue

//+ (NSSet<NSString *> *)keyPathsForValuesAffectingTitle
//{
//    return [NSSet setWithObjects:@"timestamp", nil];
//}
//
//- (NSString *)title{
//    return self.timestamp.description;
//}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingNumberOfEvents
{
    return [NSSet setWithObjects:@"events.@count", nil];
}

- (NSInteger)numberOfEvents{
    return self.events.count;
}


@end
