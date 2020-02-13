//
//  AppDelegate.h
//  CoreDataCloudKitDemo2
//
//  Created by Malcolm Hall on 09/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;
//@property (readonly, strong) NSPersistentHistoryToken *historyToken;

//@property (readonly, strong) NSOperationQueue *historyQueue;


- (void)saveContext;


@end

@interface NSPersistentContainer (TokenFile)

//@property (readonly, strong) NSURL *tokenFile;

- (void)startObservingOtherTransactionAuthors;



@end
