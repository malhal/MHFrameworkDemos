//
//  MasterViewController.m
//  TargetActionDemo
//
//  Created by Malcolm Hall on 15/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "PersistentContainer.h"
#import "TabSplitViewController.h"
#import "SceneDelegate.h"
#import "DetailNavigationController.h"
#import "SceneSplitViewController.h"
#import "SceneViewController.h"

@interface MasterViewController ()

//@property (strong, nonatomic, readonly) PersistentContainer *persistentContainer;

@end

@implementation MasterViewController

//- (PersistentContainer *)persistentContainer{
//    return (PersistentContainer *)[self mcd_persistentContainerWithSender:self];
//}

//- (NSFetchedResultsController<Event *> *)fetchedResultsController{
//    return [(SplitViewController *)self.splitViewController fetchedResultsController];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    id i = self.sceneSplitViewController;
    self.navigationItem.leftBarButtonItem = self.sceneSplitViewController.displayModeButtonItem;
    
   // [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self.sceneSplitViewController action:@selector(toggleMasterVisible:)];//
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
   // [self configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    BOOL b = self.tabSplitViewController.isCollapsed;
    self.clearsSelectionOnViewWillAppear = self.tabSplitViewController.isCollapsed;
    self.fetchedResultsController.delegate = self;
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    [self.tableView reloadData];
    [self configureView];
    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.tableView.mui_selectedVisibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {

    }];

    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:PersistentContainerResultsChanged object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(currentDetailItemChanged:) name:TabSplitViewControllerCurrentDetailItemChanged object:nil];
    [super viewWillAppear:animated];
    self.clearsSelectionOnViewWillAppear = YES; // back to default
}

- (void)currentDetailItemChanged:(NSNotification *)notification{
    [self configureView];
}

- (void)showDetailTargetDidChange:(NSNotification *)notification{
    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.fetchedResultsController.delegate = nil;
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    //if(animated){
        // because otherwise the checkmark gets selected when sliding back.
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [self configureView];
    }];
    [CATransaction commit];
}


- (void)configureView{
    if(self.isEditing){
        return;
    }
//    else if(!self.clearsSelectionOnViewWillAppear){
//        return;
//    }
    Event *event = self.tabSplitViewController.currentDetailItem;
    if(event){
        //NSIndexPath *indexPath = [(SplitViewController *)self.splitViewController indexPathForSelectedEvent];
        NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:event];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

//- (void)changed:(NSNotification *)notification{
//    NSDictionary *userInfo = notification.userInfo;
//    UITableView *tableView = self.tableView;
//    [tableView beginUpdates];
//    for(NSDictionary *change in userInfo[@"Changes"]){
//        NSFetchedResultsChangeType type = [change[@"ChangeType"] unsignedIntegerValue];
//        NSIndexPath *indexPath = change[@"IndexPath"];
//        NSIndexPath *newIndexPath = change[@"NewIndexPath"];
//        id anObject = change[@"Object"];
//        
//        switch(type) {
//               case NSFetchedResultsChangeInsert:
//                   [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//                   break;
//                   
//               case NSFetchedResultsChangeDelete:
//                   [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//                   break;
//                   
//               case NSFetchedResultsChangeUpdate:
//                   [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
//                   break;
//                   
//               case NSFetchedResultsChangeMove:
//                   [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
//                   [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
//                   break;
//           }
//    }
//    [tableView endUpdates];
//}

#pragma mark - Fetched results controller

- (NSFetchedResultsController<Event *> *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<Event *> *fetchRequest = Event.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Event *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.sceneViewController.persistentContainer.viewContext sectionNameKeyPath:nil cacheName:@"Master"];

    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

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
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Event *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        DetailNavigationController *n = (DetailNavigationController *)[segue destinationViewController];
     //   n.delegate = self;
        //n.detailItem = object;
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.detailItem = object;
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        self.detailViewController = controller;
    }
}


//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//}

#pragma mark - Table View

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Event *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //[self selectEvent:event sender:self];
   // [(SplitViewController *)self.splitViewController setSelectedEvent:event];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Event *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withEvent:event];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = self.fetchedResultsController.managedObjectContext;
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
            
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}


- (void)configureCell:(UITableViewCell *)cell withEvent:(Event *)event {
    cell.textLabel.text = event.timestamp.description;
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

@end
