//
//  TableViewController.h
//  CloudEvents
//
//  Created by Malcolm Hall on 10/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableView.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const TableViewControllerDidEndEditing;

@protocol ShownViewController, TableViewDelegate, TableViewDataSource;
@class DataSource;

@interface TableViewController : UITableViewController

@property (strong, nonatomic) UIViewController<ShownViewController> *shownViewController;

@property (strong, nonatomic, readonly) UIBarButtonItem *addButton;

@property (weak, nonatomic) id<UITableViewDataSource> tableViewDataSource;

@property (weak, nonatomic) id<TableViewDelegate> tableViewDelegate;

@property (strong, nonatomic) DataSource *dataSource;

@end

//@protocol TableViewDelegate <UITableViewDelegate>
//
//- (void)tableViewDidEndEditing:(UITableView *)tableView;
//
//@end

//@protocol TableViewDataSource <UITableViewDataSource>
//
//- (void)tableViewDidEndEditing:(UITableView *)tableView;
//
//@end

@protocol  ShownViewController <NSObject>

@property (strong, nonatomic) id object;

@end

@protocol MalcsProtocol <NSObject>

- (NSIndexPath *)indexPathForObject:(id)object;

@end

NS_ASSUME_NONNULL_END
