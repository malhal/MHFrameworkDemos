//
//  Venue+CoreDataClass.m
//  CloudEvents
//
//  Created by Malcolm Hall on 03/10/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//
//

#import "Venue.h"

@implementation Venue

+ (NSSet<NSString *> *)keyPathsForValuesAffectingEventCount
{
    return [NSSet setWithObjects:@"events.@count", nil];
}

- (void)didSave{
    [self.managedObjectContext refreshObject:self mergeChanges:YES];
}

@end
