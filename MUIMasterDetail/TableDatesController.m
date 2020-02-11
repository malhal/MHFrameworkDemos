//
//  TableDatesController.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 17/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "TableDatesController.h"

@interface TableDatesController()

@property (strong, nonatomic) NSMutableArray *objects;

@end

@implementation TableDatesController

- (NSMutableArray *)objects{
    if(!_objects){
        _objects = NSMutableArray.array;
    }
    return _objects;
}

- (void)addObject:(NSDate *)date{
    [self.objects insertObject:date atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteObject:(NSDate *)date{
    NSUInteger index = [self.objects indexOfObject:date];
    [self.objects removeObjectAtIndex:index];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self didDeleteObjects:@[date] atIndexPaths:@[indexPath]];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath{
    return [self.objects objectAtIndex:indexPath.row];
}

- (NSIndexPath *)indexPathForObject:(id)object{
    return [NSIndexPath indexPathForRow:[self.objects indexOfObject:object] inSection:0];
}

#pragma mark - Table View

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"");
//    return indexPath;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDate *object = [self objectAtIndexPath:indexPath];
        [self deleteObject:object];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
