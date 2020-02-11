//
//  MiddleTableViewController.m
//  RootMasterDetail
//
//  Created by Malcolm Hall on 08/11/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MiddleTableViewController.h"

@interface MiddleTableViewController ()

@end

@implementation MiddleTableViewController

- (void)configureCell:(UITableViewCell *)cell withObject:(Event *)object{
    cell.textLabel.text = object.name;
    cell.detailTextLabel.text = object.timestamp.description;
}

#pragma mark - Table Data

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.opaque = NO;
    cell.textLabel.backgroundColor = UIColor.clearColor;
    return cell;
}

@end
