//
//  TableViewController.m
//  CloudEvents
//
//  Created by Malcolm Hall on 10/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "TableViewController.h"
#import <objc/runtime.h>
#import "DataSource.h"

NSString * const TableViewControllerDidEndEditing = @"TableViewControllerDidEndEditing";

@interface TableViewController ()

@property (strong, nonatomic, readwrite) UIBarButtonItem *addButton;
@property (assign, nonatomic) BOOL didEndEditingRowAtIndexPath;
//@property (assign, nonatomic) BOOL didSetEndEditingCompletion;
@property (strong, nonatomic) NSIndexPath *editingIndexPath;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// need to reset the table view data source because it caches the methods
- (void)setTableViewDataSource:(id<UITableViewDataSource>)tableViewDataSource{
    if(tableViewDataSource == _tableViewDataSource){
        return;
    }
    else if(self.tableView.dataSource){
        self.tableView.dataSource = nil;
    }
    _tableViewDataSource = tableViewDataSource;
    self.tableView.dataSource = self;
}

- (void)setTableViewDelegate:(id<TableViewDelegate>)tableViewDelegate{
    if(tableViewDelegate == _tableViewDelegate){
        return;
    }
    else if(self.tableView.delegate){
        self.tableView.delegate = nil;
    }
    _tableViewDelegate = tableViewDelegate;
    self.tableView.delegate = self;
}

- (UIBarButtonItem *)addButton{
    if(!_addButton){
        _addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    }
    return _addButton;
}

- (void)insertNewObject:(id)sender{
    
}

BOOL MHFProtocolHasInstanceMethod(Protocol * protocol, SEL selector) {
    struct objc_method_description desc;
    desc = protocol_getMethodDescription(protocol, selector, NO, YES);
    if(desc.name){
        return YES;
    }
    desc = protocol_getMethodDescription(protocol, selector, YES, YES);
    if(desc.name){
        return YES;
    }
    return NO;
}


- (id)forwardingTargetForSelector:(SEL)aSelector{
    if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
        if([self.tableViewDataSource respondsToSelector:aSelector]){
            return self.tableViewDataSource;
        }
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(TableViewDelegate), aSelector)){
        if([self.tableViewDelegate respondsToSelector:aSelector]){
            return self.tableViewDelegate;
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if([super respondsToSelector:aSelector]){
        return YES;
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
        return [self.tableViewDataSource respondsToSelector:aSelector];
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(TableViewDelegate), aSelector)){
        return [self.tableViewDelegate respondsToSelector:aSelector];
    }
    return NO;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSLog(@"");
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([self.tableViewDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]){
        return [self.tableViewDataSource numberOfSectionsInTableView:tableView];
    }
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableViewDataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

//- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
//    if(editing){
//        [super setEditing:editing animated:animated];
//        return;
//    }
//    else if(self.didSetEndEditingCompletion){
//        [super setEditing:editing animated:animated];
//        return;
//    }
//    self.didSetEndEditingCompletion = YES; // prevent called twice when swiped on row and done button tapped.
//    [CATransaction begin];
//    [CATransaction setCompletionBlock:^{
//        self.didSetEndEditingCompletion = NO;
//        // need to check if still editing because with a row editing tapping done then edit quickly
//        // causes it to be selected in editing after when the row closing animation ends.
//        if(!self.tableView.isEditing){
//            if(self.isEditing){
//                [self tableViewDidEndEditing];
//            }
//            else{
//                // the perform is only needed in the case where a row is editing and the done button is tapped.
//                [self performSelector:@selector(tableViewDidEndEditing) withObject:nil afterDelay:0];
//            }
//        }
//    }];
//    [super setEditing:editing animated:animated];
//    [CATransaction commit];
//}


//- (void)tableViewDidEndEditing{
//    if([self.tableViewDelegate respondsToSelector:@selector(tableViewDidEndEditing:)]){
//        [self.tableViewDelegate performSelector:@selector(tableViewDidEndEditing:) withObject:self];
//    }
//    
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#define kShownViewControllerKey @"ShownViewController"

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    if (self.shownViewController) {
        [coder encodeObject:self.shownViewController forKey:kShownViewControllerKey];
    }
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.shownViewController = [coder decodeObjectForKey:kShownViewControllerKey]; // it doesnt have the detail item
    
    //  [self.tableView reloadData];
}

@end
