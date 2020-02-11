//
//  MasterViewController.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 24/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TableDatesController.h"

@interface MasterViewController () //<MUIMasterControllerDelegate, MUIMasterControllerDataSource>


//@property (strong, nonatomic) MUIMasterController *masterController;

@property (strong, nonatomic) TableDatesController *tableDatesController;
@property (strong, nonatomic) MUIMasterTable *masterTable;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    //self.delegate = self;
    //self.dataSource = self;
    
//    id d = self.navigationController.navigationBar.delegate;
    
//    self.masterController = [MUIMasterController.alloc initWithTableViewController:self];
//    self.masterController.delegate = self;
//    self.masterController.dataSource = self;
//    self.masterController.tableDelegate = self;
    self.tableDatesController = [TableDatesController.alloc initWithTableView:self.tableView];
    self.tableDatesController.dataSource = self;
    
    self.masterTable = [MUIMasterTable.alloc initWithTableViewObjectsController:self.tableDatesController];
}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSLog(@"willShowViewController");
//}
//
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    id i = navigationController.viewIfLoaded.window;
//    NSLog(@"didShowViewController");
//}

- (void)viewWillAppear:(BOOL)animated {
    //self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)insertNewObject:(id)sender {
    [self.tableDatesController addObject:NSDate.date];
}

//- (NSIndexPath *)masterController:(MUIMasterController *)masterController indexPathForMasterItem:(id)item{
//    return [NSIndexPath indexPathForRow:[self.objects indexOfObject:item] inSection:0];
//}
//
//- (id)masterController:(nonnull MUIMasterController *)masterController masterItemAtIndexPath:(NSIndexPath *)indexPath{
//    return [self.objects objectAtIndex:indexPath.row];
//}
//
- (void)didSelectObject:(id)object{
    [self performSegueWithIdentifier:@"showDetail" sender:nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
}

- (void)tableObjectsController:(MUIObjectsTable *)tableObjectsController updateCell:(UITableViewCell *)cell withObject:(id)object{
        cell.textLabel.text = [object description];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
      //  NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
      //  NSDate *object = self.objects[indexPath.row];
        
//        MUIDetailNavigationController *dnc = segue.destinationViewController;
        //dnc.detailObject = object;
      //  self.mui_splitViewController.selectedObject = object;
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        
        NSDate *object = self.masterTable.selectedObject;
        if(object){
            [controller setDetailItem:object];
        }
        
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

@end
