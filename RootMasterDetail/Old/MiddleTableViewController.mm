//
//  MiddleTableViewController.m
//  BasicSplit
//
//  Created by Malcolm Hall on 04/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//
// If in portrait and delete item going back new cell doesn't re-highlight

// Bug is in landscape go and pick detail. rotate to portrait go back to root then  different folder then landscape. Because was in portrait when loading it didnt find existing detail.


#import "MiddleTableViewController.h"
#import "EndViewController.h"
#import "CollapseController.h"
#import "UIView+MH.h"
#import "NSManagedObjectContext+MCD.h"
#import "UIView+MH.h"
#import "DetailNavigationController.h"

@interface MiddleTableViewController () <CollapseControllerDelegate>

@property (strong, nonatomic) NSIndexPath *indexPathOfDeletedObject;

//@property (strong, nonatomic) EndViewController *detailViewController;

@end

@implementation MiddleTableViewController

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [super encodeRestorableStateWithCoder:coder];
//    if(self.masterItem){
    [coder encodeObject:self.selectedDetailItem.objectID.URIRepresentation forKey:@"SelectedEvent"];
    //[coder encodeObject:self.selectedDetailItem.managedObjectContext forKey:@"context"];
//    }
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
    [super decodeRestorableStateWithCoder:coder];

}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
//    UISplitViewController *splitViewController = self.splitViewController.splitViewController;//navigationController.collapseController.splitViewController.outermostSplitViewController;
//    id a = splitViewController.collapseController;
//    splitViewController.collapseController.masterViewController = self;
//    splitViewController.collapseController.delegate = self;
    
//    CollapseController *previousCollapseController = splitViewController.collapseController;
//    CollapseController *collapseController = [CollapseController.alloc initWithSplitViewController:splitViewController masterViewController:self];
//    collapseController.delegate = self;
//    if(previousCollapseController){
//        collapseController.detailNavigationController = previousCollapseController.detailNavigationController;
//        self.selectedDetailItem = previousCollapseController.detailNavigationController.detailItem;
//    }else{
//        collapseController.detailNavigationController = splitViewController.viewControllers.lastObject;
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
//    id detailItem = self.collapseController.detailNavigationController.detailItem;
//    id i = self.collapseController.detailNavigationController;
//    if([self.fetchedResultsController.fetchedObjects containsObject:self.collapseController.detailNavigationController.detailItem]){
//        self.selectedDetailItem = detailItem;
//    }
    //self.fetchedResultsController.delegate = self;
    // gets the current detail item without needing to search the hierarchy which is impossible collapsed.
    [self configureView];
    
    //id i = self.collapseController;
    //self.collapseController.middleViewController = self;
    
   /// EndViewController *detailViewController = self.collapseController.detailViewController;
   // detailViewController.delegate = self;
 //   [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(willDeleteMasterItem) name:@"WillDeleteMasterItem" object:nil];
    
    
    

}

//- (void)willDeleteMasterItem{
//    [self showDetailItem:nil];
//}

- (void)configureView {
    // Update the user interface for the detail item.
    //    if (!self.masterItem) {
    //        return;
    //    }
    if(self.fetchedResultsController){
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }else{
    //    [self showDetailItem:nil]; // test
    }
    //self.detailDescriptionLabel.text = self.detailItem.timestamp.description;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    if(!editing){
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [self updateRowSelectionForCurrentDetailItem];
        }];
    }
    [super setEditing:editing animated:animated];
    if(!editing){
        [CATransaction commit];
    }
}

- (void)tableViewDidEndEditing{
    [self updateRowSelectionForCurrentDetailItem];
}

- (BOOL)shouldAlwaysHaveSelectedRow{
    if(self.collapseController.splitViewController.isCollapsed){
        return NO;
    }
    if(self.isEditing){
        return NO;
    }
    return YES;
}

- (void)updateRowSelectionForCurrentDetailItem{
    if(!self.shouldAlwaysHaveSelectedRow){
        return;
    }
    [self selectRowForCurrentDetailItem];
}

- (void)viewWillAppear:(BOOL)animated {
   
    self.clearsSelectionOnViewWillAppear = self.collapseController.splitViewController.isCollapsed;

    [self selectRowForCurrentDetailItem]; // so it can be unhighlighted
    
    // need to reselect the row now
    [super viewWillAppear:animated];
    // by doing this in appear means it is only called when separating.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:self.collapseController.splitViewController];

    // causes crash on compact deleting last one
// in compact showing event going back to root then in a different venue then back, and in same venue again, expanding means it has gone.
    id detailItem;
    if((detailItem = self.collapseController.detailNavigationController.detailItem)){
        if(![self canSelectDetailItem:detailItem]){
            if(self.collapseController.isDetailViewControllerVisible){
                [self showDetailItem:nil]; // test
            }
        }
    }
    else{
        [self updateRowSelectionForCurrentDetailItem];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.fetchedResultsController.delegate = nil;
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIViewControllerShowDetailTargetDidChangeNotification object:self.collapseController.splitViewController];
}

- (IBAction)unwind:(UIStoryboardSegue *)segue{
    
}

- (IBAction)deleteButtonTapped:(id)sender{
    
}

// although the split might say collapsed it hasnt yet installed the detail in the second position so a delay is needed to get it.
- (void)showDetailTargetDidChange:(NSNotification *)notification
{
    //[self performSelector:@selector(updateSelectionForCurrentEndViewController) withObject:nil afterDelay:0];
    [self updateRowSelectionForCurrentDetailItem];
}

- (void)updateSelectionForCurrentEndViewController{
//    if(self.masterDetailSplitViewController.isCollapsed){
//        return;
//    }
//    EndViewController *detailViewController = (EndViewController *)[[self.masterDetailSplitViewController.viewControllers lastObject] topViewController];
//    self.selectedDetailItem = detailViewController.detailItem;
//    [self updateRowSelectionForCurrentDetailItem];
}

-(IBAction)unwindToMiddleTableViewController:(UIStoryboardSegue *)segue{
 //   self.masterDetailContext.detailItem = nil;
    NSLog(@"");
}

- (void)configureCell:(UITableViewCell *)cell detailItem:(DetailItem *)detailItem {
    cell.textLabel.text = detailItem.name;
    cell.detailTextLabel.text = detailItem.timestamp.description;
}

- (void)selectRowForCurrentDetailItem{
    Event *event = self.selectedDetailItem;// self.detailViewController.detailItem;
    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:event];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - View Controller

- (void)setFetchedResultsController:(NSFetchedResultsController<Event *> *)fetchedResultsController{
    if(fetchedResultsController == _fetchedResultsController){
        return;
    }
    _fetchedResultsController = fetchedResultsController;
    fetchedResultsController.delegate = self;
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(managedObjectContextDidChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:fetchedResultsController.managedObjectContext];
    if(self.isViewLoaded){
        [self configureView];
    }
}

#pragma mark - Segues

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    if (![identifier isEqualToString:@"showDetail"]) {
//        return NO;
//    }
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if(!indexPath){
        return NO;
    }
    id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if(!object){
        return NO;
    }
    self.selectedDetailItem = object;
    return YES;
}

//- (void)setDetailNavigationController:(DetailNavigationController *)detailNavigationController{
//    _detailNavigationController = detailNavigationController;
//    self.collapseController.detailNavigationController = detailNavigationController;
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier hasPrefix:@"show"]){ // showDetail showEmployee
        DetailNavigationController *detailNavigationController = (DetailNavigationController *)segue.destinationViewController;
        detailNavigationController.detailItem = self.selectedDetailItem;
        //[self.delegate middleTableViewController:self didCreateDetailNavigationController:detailNavigationController];
        
        //self.detailNavigationController = detailNavigationController;
        self.collapseController.detailNavigationController = detailNavigationController;
        
       // EndViewController *controller = (EndViewController *)[[segue destinationViewController] topViewController];
        //EndViewController *controller = (EndViewController *)[segue destinationViewController];
            //controller.detailItem = self.masterDetailContext.detailItem;
            // also need to set the item somewhere we can get it back from if this master is created again

          //  controller.managedObjectContext = self.managedObjectContext;
        
       //     controller.masterDetailContext = self.masterDetailContext;
            
            //self.masterDetailContext.detailItem = self.selectedDetailItem;
//        if(id detailItem = self.selectedDetailItem){
//            controller.detailItem = detailItem;
//        }
  //      controller.delegate = self;
        //[self configureEndNavigationController:segue.destinationViewController];
      //  self.detailViewController = controller;
        
      //  MySegue *mySegue = segue;
//        if(self.useDeleteSegue){
//            mySegue.animate = YES;
//            self.useDeleteSegue = NO;
//            if(!detailItem){
//                [mySegue setAnimationDidStop:^{
//                    [controller performSegueWithIdentifier:@"unwind" sender:self];
//                }];
//            }
//        }
  
        // deleteDetail sets it later
        //id i = controller.view;
    }
}


- (BOOL)canSelectDetailItem:(id)detailItem{
    return [self.fetchedResultsController.fetchedObjects containsObject:detailItem];
}

//- (void)configureEndNavigationController:(UINavigationController *)nc{
//    //self.collapseController.detailNavigationController = nc;
//    EndViewController *controller = (EndViewController *)nc.topViewController;
//    controller.detailItem = self.selectedDetailItem;
// //   controller.delegate = self;
//   // self.collapseController.detailNavigationController = nc;
//}

//- (void)setDetailViewController:(EndViewController *)detailViewController{
//    //self.collapseController.detailViewController = detailViewController;
//    _detailViewController = detailViewController;
//}

- (UIViewController *)targetViewControllerForAction:(SEL)action sender:(id)sender{
    //NSLog(@"");
    id i = self.collapseController.splitViewController;
    return self.collapseController.splitViewController; // OuterSplitViewController
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailItem *detailItem = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UITableViewCell *cell;
    if([detailItem isKindOfClass:Employee.class]){
        cell = [tableView dequeueReusableCellWithIdentifier:@"EmployeeCell" forIndexPath:indexPath];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    }
    [self configureCell:cell detailItem:detailItem];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
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

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editButtonItem.enabled = NO;
}

-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editButtonItem.enabled = YES;
    [self performSelector:@selector(tableViewDidEndEditing) withObject:nil afterDelay:0];
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
            // not sure about this yet
            //if(!self.collapseController.detailItem){
           //     self.indexPathOfDeletedObject = newIndexPath;
            //}
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            if(anObject == self.selectedDetailItem){//self.detailViewController.detailItem){
                self.indexPathOfDeletedObject = indexPath;
               
            }
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] detailItem:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] detailItem:anObject];
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
    
    NSIndexPath *indexPath = self.indexPathOfDeletedObject;
    if(indexPath){
        self.indexPathOfDeletedObject = nil;
        NSUInteger count = [self.tableView numberOfRowsInSection:indexPath.section];//self.fetchedResultsController.fetchedObjects.count;
        id object;
        if(count){
            NSUInteger row = count - 1;
            if(indexPath.row < row){
                row = indexPath.row;
            }
            NSIndexPath * newIndexPath = [NSIndexPath indexPathForRow:row inSection:indexPath.section];
            object = [self.fetchedResultsController objectAtIndexPath:newIndexPath];
        }
        
      //  dispatch_async(dispatch_get_main_queue(), ^{
        
        self.selectedDetailItem = object;
        if(self.collapseController.isDetailViewControllerVisible){ // may not be needed
            [self showDetailItem:object];
        }
    }
}

- (void)showDetailItem:(DetailItem *)detailItem{
    if([detailItem isKindOfClass:Employee.class]){
        [self performSegueWithIdentifier:@"showEmployee" sender:self];
    }
    else{
        [self performSegueWithIdentifier:@"showDetail" sender:self];
    }
    [self updateRowSelectionForCurrentDetailItem];
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

//- (BOOL)detailItem:(id)detailItem{
//    return [self.fetchedResultsController.fetchedObjects containsObject:detailItem];
//}

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)detailViewControllerDidTapDelete:(EndViewController *)detailViewController{
    //self.useDeleteSegue = YES;
    // if the item to be deleted isnt in the current fetch then we won't show another.
    // Problem tho is what if it isn't deleted by a tap when master isn't showing.
//    if(![self canSelectDetailItem:detailViewController.detailItem]){
//        [self showDetailItem:nil];
//    }
   
}

// For when in a master that doesnt contain current detail.
// fetch may choose another just before this so wont be needed.
- (void)managedObjectContextDidChange:(NSNotification *)notification{
    NSSet *deletedObjects = notification.userInfo[NSDeletedObjectsKey];
//    id i = self.collapseController.detailViewController.detailItem;
//    id j = self.collapseController;
    id i = self.collapseController.detailNavigationController;
    if([deletedObjects containsObject:self.collapseController.detailNavigationController.detailItem]){
        //id object;
        self.selectedDetailItem = nil; // maybe not needed becaue the reason we got here is because the selectedDetail item wasnt in the list.
        if(self.collapseController.isDetailViewControllerVisible){
            [self showDetailItem:nil];
        }
    }
}



#pragma mark - Restoration

// on encode it asks for first and selected. On restore it asks for first so maybe checks ID.
- (nullable NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view{
    //NSAssert(self.fetchedTableRowsController.fetchedResultsController.fetchedObjects, @"modelIdentifierForElementAtIndexPath requires fetchedObjects");
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:idx];
    return object.objectID.URIRepresentation.absoluteString;
}

- (nullable NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view{
    NSURL *objectURI = [NSURL URLWithString:identifier];
    //  NSAssert(self.managedObjectContext, @"indexPathForElementWithModelIdentifier requires a context");
    NSManagedObject *object = [self.fetchedResultsController.managedObjectContext mcd_objectWithURI:objectURI];
//    if(![object isKindOfClass:Venue.class]){
//        return nil;
//    }
    //Venue *venue = (Venue *)object;
    //[self.tableView reloadData];
    //  NSAssert(self.fetchedTableRowsController.fetchedResultsController.fetchedObjects, @"indexPathForElementWithModelIdentifier requires fetchedObjects");
    return [self.fetchedResultsController indexPathForObject:object];
}

@end
 
