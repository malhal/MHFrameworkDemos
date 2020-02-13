//
//  AppDelegate.m
//  CoreDataCloudKitDemo2
//
//  Created by Malcolm Hall on 09/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;
//@synthesize historyToken = _historyToken;
//@synthesize historyQueue = _historyQueue;

//- (NSPersistentHistoryToken *)historyToken{
//    @synchronized (self) {
//        if(!_historyToken){
//
//        }
//    }
//    return _historyToken;
//}

//- (void)setHistoryToken:(NSPersistentHistoryToken *)historyToken{
//    @synchronized (self) {
//        if(historyToken == _historyToken){
//            return;
//        }
//        _historyToken = historyToken;
//
//    }
//}

- (NSPersistentCloudKitContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentCloudKitContainer alloc] initWithName:@"MHCoreDataCloudKitDemo"];
            //[_persistentContainer trackChanges];
            
            NSPersistentStoreDescription *psd = _persistentContainer.persistentStoreDescriptions.firstObject;
            [psd setOption:@YES forKey:NSPersistentHistoryTrackingKey];
            [psd setOption:@YES forKey:NSPersistentStoreRemoteChangeNotificationPostOptionKey];
            
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
            _persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
            _persistentContainer.viewContext.transactionAuthor = @"app";
            
           // [_persistentContainer startObservingOtherTransactionAuthors];
            
           _persistentContainer.viewContext.automaticallyMergesChangesFromParent = YES;
            NSError *error = nil;
            if(![_persistentContainer.viewContext setQueryGenerationFromToken:NSQueryGenerationToken.currentQueryGenerationToken error:&error]){
                NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                abort();
            }
            
            [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(viewContextDidChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:_persistentContainer.viewContext];
            
            NSLog(@"%@", _persistentContainer.persistentStoreDescriptions.firstObject.URL);
        }
    }
    
    return _persistentContainer;
}

//- (NSOperationQueue *)historyQueue{
//    @synchronized (self) {
//        if(!_historyQueue){
//            _historyQueue = [NSOperationQueue.alloc init];
//            _historyQueue.maxConcurrentOperationCount = 1;
//        }
//    }
//    return _historyQueue;
//}

- (void)viewContextDidChange:(NSNotification *)notification{
    NSLog(@"viewContextDidChange");
}

//- (void)persistentStoreRemoteChangeNotification:(NSNotification *)notification{
//
//}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end

@implementation NSPersistentContainer (TokenFile)

//- (NSURL *)tokenFile{
//    // todo name it using view contexts name? or author?
//    return ;
//}

// must be in persistent conainer because needs to create a background context.
- (void)startObservingOtherTransactionAuthors{
    NSManagedObjectContext *viewContext = self.viewContext;

    NSOperationQueue *queue = [NSOperationQueue.alloc init];
    queue.maxConcurrentOperationCount = 1;
    
    __block NSPersistentHistoryToken *historyToken;
    NSString *viewContextTransactionAuthor = viewContext.transactionAuthor;
    NSURL *defaultDirectoryURL = self.class.defaultDirectoryURL;
    
    [NSNotificationCenter.defaultCenter addObserverForName:NSPersistentStoreRemoteChangeNotification object:self.persistentStoreCoordinator queue:queue usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"persistentStoreRemoteChangeNotification");
        //sleep(3);
        NSPersistentHistoryToken *notificationToken = note.userInfo[NSPersistentHistoryTokenKey];
        if(!notificationToken){
            return;
        }

        NSURL *tokenFile;
        if(!historyToken){
            tokenFile = [defaultDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.token", viewContextTransactionAuthor]];
            NSData *tokenData = [NSData dataWithContentsOfURL:tokenFile];
            if(tokenData){
                NSError *error;
                historyToken = [NSKeyedUnarchiver unarchivedObjectOfClass:NSPersistentHistoryToken.class fromData:tokenData error:&error];
                if(error){
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    // does this mean trashing whole context?
                    return;
                }
            }
        }
        
        if([historyToken isEqual:notificationToken]){
            return;
        }
        
        NSManagedObjectContext *backgroundContext = self.newBackgroundContext;
        // needs to wait so it can write the token before another notification arrives.
        [backgroundContext performBlockAndWait:^{
            NSFetchRequest *transactionRequest = NSPersistentHistoryTransaction.fetchRequest;
            transactionRequest.predicate = [NSPredicate predicateWithFormat:@"author != %@", viewContextTransactionAuthor];
            
            NSPersistentHistoryChangeRequest *request = [NSPersistentHistoryChangeRequest fetchHistoryAfterToken:historyToken];
            
            NSError *error;
            NSPersistentHistoryResult *result = [backgroundContext executeRequest:request error:&error];
            if(error){
                NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                // does this mean trashing whole context?
                return;
            }
            NSArray<NSPersistentHistoryTransaction *> *transactions = result.result;
            if(!transactions.count){
                return;
            }
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:notificationToken requiringSecureCoding:YES error:&error];
            if(error){
                NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                // does this mean trashing whole context?
                return;
            }
            [data writeToURL:tokenFile options:0 error:&error];
            if(error){
                NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                // does this mean trashing whole context?
             
            }
            // cache the token if we managed to write it.
            historyToken = notificationToken;
            
            [viewContext performBlock:^{
                [NSNotificationCenter.defaultCenter postNotificationName:@"DidFindRelevantTransactions" object:viewContext userInfo:@{@"Transactions" : transactions}];
            }];
            
            
    //      if(!){
    //          NSLog(@"Unresolved error %@, %@", error, error.userInfo);
    //          abort();
    //      }
            
        }];
        
    }];
    
    
    
}

@end
