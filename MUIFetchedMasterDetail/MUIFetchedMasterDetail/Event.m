//
//  Event+CoreDataClass.m
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 21/05/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//
//

#import "Event.h"

@implementation Event

+ (NSSet<NSString *> *)keyPathsForValuesAffectingTitle
{
    return [NSSet setWithObjects:@"timestamp", nil];
}

- (NSString *)title{
    return self.timestamp.description;
}

@end
