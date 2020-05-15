//
//  MasterTableDataSource.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 13/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MasterTableDataSource.h"

@implementation MasterTableDataSource

- (UITableViewCell *)cellForObject:(id)object atIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView{
    NSString *identifier;
    if([object isKindOfClass:Folder.class]){
        identifier = @"Folder";
    }
    else{
        identifier = @"Event";
        
    }
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object inTableView:(UITableView *)tableView{
    if([object isKindOfClass:Folder.class]){
        Folder *folder = (Folder *)object;
        cell.textLabel.text = [NSString stringWithFormat:@"%ld children", folder.children.count];
    }
    else{
        Event *event = (Event *)object;
        cell.textLabel.text = event.timestamp.description;
    }
}

@end
