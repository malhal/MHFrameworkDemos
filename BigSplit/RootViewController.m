//
//  MasterViewController.m
//  BigSplit
//
//  Created by Malcolm Hall on 11/08/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "RootViewController.h"
#import "MasterViewController.h"
#import "DetailViewController.h"

@interface RootViewController ()

- (UIViewController *)_ancestorViewControllerOfClass:(Class)aClass allowModalParent:(BOOL)allowModalParent;
- (UIViewController *)_popoverController;
//@property (strong, nonatomic) MUIPrimaryTableFetchedDataSource *dataSource;


@property (strong, nonatomic) MUIFetchedTableRowsController *fetchedTableRowsController;

@property (strong, nonatomic) MUICollapseController *detailCollapseController;
@property (strong, nonatomic) MUIFetchedMasterTableSelectionController *fetchedMasterTableSelectionController;

@end

@interface UISplitViewController ()

-(UIUserInterfaceSizeClass)_horizontalSizeClass;
- (UIView *)_parentTraitEnvironment;

@end

@interface UIView ()

- (UITraitCollection *)_traitCollectionForChildEnvironment:(UIView *)view;

@end

@implementation RootViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  //  self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItems = @[addButton, self.editButtonItem];
    
    MasterViewController *masterViewController = (MasterViewController *)[self.splitViewController.viewControllers.lastObject topViewController];
    self.mui_collapseControllerForMaster.detailViewController = masterViewController;
    
    self.detailCollapseController = [MUICollapseController.alloc initWithSplitViewController:self.splitViewController.splitViewController];
    self.detailCollapseController.masterViewController = masterViewController;
    self.detailCollapseController.detailViewController = (DetailViewController *)[[self.splitViewController.splitViewController.viewControllers lastObject] topViewController];

    
 //   self.navigationController.delegate = self;
}

//- (void)viewWillAppear:(BOOL)animated {
//    BOOL b = self.splitViewController.isCollapsed;
//    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
//    [super viewWillAppear:animated];
//}

- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    Venue *venue = [[Venue alloc] initWithContext:context];
        
    // If appropriate, configure the new managed object.
    venue.timestamp = [NSDate date];
        
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


#pragma mark - Segues

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    if(![super shouldPerformSegueWithIdentifier:identifier sender:sender]){
//        return NO;
//    }
//    if (![identifier isEqualToString:@"showDetail"]) {
//        return NO;
//    }
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if(!indexPath){
        return NO;
    }
    Venue *venue = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if(!venue){
        return NO;
    }
    else if(!self.mui_collapseControllerForMaster.splitViewController.isCollapsed && venue == self.mui_collapseControllerForMaster.detailViewController.detailItem){ // prevent re-showing same segue.
        return NO;
    }   
    //self.masterDetailContext.detailItem = event;
    self.venueForSegue = venue;
    return YES; 
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //Venue *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        //UISplitViewController *splitViewController = (UISplitViewController *)[[segue destinationViewController] topViewController];
        //UINavigationController *MasterNavigationController = splitViewController.viewControllers.firstObject;
        UINavigationController *destinationViewController = [segue destinationViewController];
        MasterViewController *controller = (MasterViewController *)[destinationViewController topViewController];
        controller.managedObjectContext = self.managedObjectContext;
        controller.venue = self.venueForSegue;
        self.detailCollapseController.masterViewController = controller;
        self.mui_collapseControllerForMaster.detailViewController = controller;
        
        //MasterViewController *controller = (MasterViewController *)splitViewController.viewControllers[0];
        //controller.masterItem = object;
        //destinationViewController.popoverPresentationController.delegate = self;
      //  UIViewController *i = self.splitViewController;
      //  i.popoverPresentationController.overrideTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
      //  controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
       // controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue *venue = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withVenue:venue];
    return cell;
}




*/

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
//
//        NSError *error = nil;
//        if (![context save:&error]) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//            abort();
//        }
//    }
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // id t = [self _popoverController];
    /*
    id r = [self _ancestorViewControllerOfClass:UISplitViewController.class allowModalParent:NO];
    
    id i = self.splitViewController.traitCollection;
    id j = self.parentViewController.parentViewController;
  //  NSLog(@"splitViewController %@", i);
    i = self.navigationController.traitCollection;
  //  NSLog(@"navigationController %@", i);
    i = self.traitCollection;
  //  NSLog(@"traits %@", i);
    UISplitViewController *outerSplit = self.splitViewController;
    UISplitViewController *splitViewController = self.parentViewController.parentViewController;
    UIUserInterfaceSizeClass size =  splitViewController._horizontalSizeClass;
    UITraitCollection *traits =  [outerSplit overrideTraitCollectionForChildViewController:splitViewController];
    UITraitCollection *traits2 = splitViewController.traitCollection;
    
  //  UIPresentationController *popover = outerSplit.popoverPresentationController;
    
  //  id p = popover.presentedViewController;
  //  popover.overrideTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
    id s = outerSplit.popoverPresentationController;
    UIView *env = splitViewController._parentTraitEnvironment;
    UIView *evn2 = env.superview;
    UITraitCollection *bob = evn2.traitCollection;
    UITraitCollection *tr = [env _traitCollectionForChildEnvironment:splitViewController];
    NSLog(@"tr %@", tr);
    */
    
//}
//
//- (UISplitViewController *)splitViewController{
//    //return super.splitViewController;
//    return self.parentViewController.parentViewController;
//}

//- (void)configureCell:(UITableViewCell *)cell withVenue:(Venue *)venue {
- (void)fetchedTableRowsController:(MUIFetchedTableRowsController *)fetchedTableRowsController configureCell:(UITableViewCell *)cell withObject:(NSManagedObject<MUITableViewCellObject> *)object{
    Venue *venue = object;
    cell.textLabel.text = venue.timestamp.description;
}




/*
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withVenue:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withVenue:anObject];
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}
 */

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

//- (BOOL)containsDetailItem:(id)masterItem{
//    return [self.fetchedResultsController.fetchedObjects containsObject:masterItem];
//}

@end
