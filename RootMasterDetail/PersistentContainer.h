//
//  PersistentContainer.h
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 24/09/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <MUIKit/MUIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const StateRestorationPersistentContainerKey;

@interface PersistentContainer : NSPersistentContainer <UIStateRestoring>

@end

NS_ASSUME_NONNULL_END
