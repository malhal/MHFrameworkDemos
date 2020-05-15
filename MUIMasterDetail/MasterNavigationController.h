//
//  MasterNavigationController.h
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 18/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <CoreData/CoreData.h>
#import "MUIMasterDetail+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const MasterNavigationControllerDidChangeSelectedObject;

@interface MasterNavigationController : UINavigationController //<MUIFetchedPageViewControllerDelegate>

@property (strong, nonatomic) id selectedObject;

@end

NS_ASSUME_NONNULL_END
