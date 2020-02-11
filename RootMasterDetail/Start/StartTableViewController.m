//
//  StartTableViewController.m
//  RootMasterDetail
//
//  Created by Malcolm Hall on 07/11/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "StartTableViewController.h"

@interface StartTableViewController ()

@end

@implementation StartTableViewController

- (void)configureCell:(UITableViewCell *)cell withObject:(Venue *)object{
    cell.textLabel.text = object.name;
}

#pragma mark - Table Data

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.opaque = NO;
    cell.textLabel.backgroundColor = UIColor.clearColor;
    return cell;
}

@end
