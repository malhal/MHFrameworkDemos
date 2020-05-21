//
//  FetchedResultsViewUpdater.m
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 21/05/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "TableViewFetchedResultsController.h"
#import "MUIFetchedMasterDetail+CoreDataModel.h"

@implementation TableViewFetchedResultsController

- (void)updateCell:(UITableViewCell *)cell withObject:(id)object{
    if([object isKindOfClass:Event.class]){
        Event *event = (Event *)object;
        cell.textLabel.text = event.timestamp.description;
    }
    else if([object isKindOfClass:Venue.class]){
        Venue *venue = (Venue *)object;
        id i = venue.timestamp;
        id a = venue.managedObjectContext;
        cell.textLabel.text = venue.timestamp.description;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld Events", venue.events.count];
    }
}

@end
