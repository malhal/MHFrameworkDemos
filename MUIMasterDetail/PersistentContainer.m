//
//  PersistentContainer.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 23/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "PersistentContainer.h"

@implementation PersistentContainer

- (NSFetchedResultsController *)newFetchedResultsController{
    NSFetchRequest<Event *> *fetchRequest = Event.fetchRequest;

    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];

    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];

    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Event *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.viewContext sectionNameKeyPath:nil cacheName:@"Master"];
   // aFetchedResultsController.delegate = self;

//    NSError *error = nil;
//    if (![aFetchedResultsController performFetch:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
//    }
    return aFetchedResultsController;
}

@end
