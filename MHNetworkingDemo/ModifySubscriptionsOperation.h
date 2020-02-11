//
//  ModifySubscriptionsOperation.h
//  MHNetworkingDemo
//
//  Created by Malcolm Hall on 21/08/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import <MHNetworking/MHNetworking.h>

@interface ModifySubscriptionsOperation : MHNOperation

- (id)initWithOperationInfo:(id)arg1 clientContext:(id)arg2;

@property (copy, nonatomic) CDUnknownBlockType saveCompletionBlock;

+ (NSInteger)isPredominatelyDownload;
- (void)_finishOnCallbackQueueWithError:(id)arg1;
- (void)_handleSubscriptionDeleted:(id)arg1 responseCode:(id)arg2;
- (void)_handleSubscriptionSaved:(id)arg1 error:(id)arg2;
- (void)_handleSubscriptionSaved:(id)arg1 responseCode:(id)arg2;
- (id)activityCreate;
- (id)initWithOperationInfo:(id)arg1 clientContext:(id)arg2;
- (void)main;

@end
