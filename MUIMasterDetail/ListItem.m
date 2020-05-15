//
//  Event+CoreDataClass.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 28/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//
//

#import "ListItem.h"

@implementation ListItem

+ (NSFetchRequest *)myFetchRequest{
    NSFetchRequest *fetchRequest = self.fetchRequest;

    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];

    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    //fetchRequest.predicate = [NSPredicate predicateWithFormat:@"parentEvent = nil"];
    
    return fetchRequest;
}

+ (NSFetchRequest<ListItem *> *)fetchRequestWithParentListItem:(ListItem *)parent{
    NSFetchRequest<ListItem *> *fr = self.myFetchRequest;
    fr.predicate = [NSPredicate predicateWithFormat:@"parent = %@", parent];
    return fr;
}

//+ (NSFetchRequest<Event *> *)fetchRequestWithVenue:(Venue *)venue{
//    NSFetchRequest<Event *> *fr = self.myFetchRequest;
//    fr.predicate = [NSPredicate predicateWithFormat:@"venue = %@", venue];
//    return fr;
//}

@end
