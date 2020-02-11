//
//  ModifySubscriptionsURLRequest.m
//  MHNetworkingDemo
//
//  Created by Malcolm Hall on 21/08/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import "ModifySubscriptionsURLRequest.h"

@implementation ModifySubscriptionsURLRequest

- (instancetype)initWithSubscriptionsToSave:(NSArray *)subscriptionsToSave{
    self = [super init];
    if (self) {
        _subscriptionsToSave = subscriptionsToSave;
    }
    return self;
}

@end
