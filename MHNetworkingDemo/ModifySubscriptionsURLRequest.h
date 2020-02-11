//
//  ModifySubscriptionsURLRequest.h
//  MHNetworkingDemo
//
//  Created by Malcolm Hall on 21/08/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import <MHNetworking/MHNetworking.h>

@interface ModifySubscriptionsURLRequest : MHNURLRequest

- (instancetype)initWithSubscriptionsToSave:(NSArray *)subscriptionsToSave;

@property (strong, nonatomic) NSArray *subscriptionsToSave;

- (int)operationType;
- (void)requestDidParseNodeFailure:(id)arg1;
- (id)requestDidParseProtobufObject:(id)arg1;
- (id)requestOperationClasses;
- (id)generateRequestOperations;

@end
