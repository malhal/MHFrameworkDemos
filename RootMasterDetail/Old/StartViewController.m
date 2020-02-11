//
//  StartViewController.m
//  BasicSplit
//
//  Created by Malcolm Hall on 08/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "StartViewController.h"
#import "MiddleViewController.h"
#import "EndViewController.h"
#import "UIView+MH.h"
#import "NSManagedObjectContext+MCD.h"

static NSString *kSelectedDetailItemKey = @"SelectedDetailItem";

@interface StartViewController ()

@property (strong, nonatomic) NSIndexPath *indexPathOfDeletedObject;

@property (assign, nonatomic) BOOL previousDetailItemWasDeleted;
//@property (strong, nonatomic) UINavigationController *otherDetailNavigationController;

@end

@implementation StartViewController

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject:self.selectedDetailItem.objectID.URIRepresentation forKey:kSelectedDetailItemKey];
   // [coder encodeObject:self.managedObjectContext forKey:@"managedObjectContext"];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
    [super decodeRestorableStateWithCoder:coder];

}

- (IBAction)unwindToRoot:(UIStoryboardSegue *)segue{
    
}

- (IBAction)unwind:(UIStoryboardSegue *)segue{
    
}

- (BOOL)canSelectDetailItem:(id)detailItem{
    return [self.fetchedResultsController.fetchedObjects containsObject:detailItem];
}

// not called in 50:50 split overlay because events list is pushed into master nav, happens when going back.
// self.splitViewController is getting primary by mistake
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    DetailNavigationController *detailNavigationController = self.splitViewController.viewControllers.lastObject;
    MiddleViewController *middle = detailNavigationController.viewControllers.firstObject;
    middle.middleEndCollapseController = self.middleEndCollapseController;
    
    CollapseController *collapseController = [CollapseController.alloc initWithSplitViewController:self.splitViewController];
    collapseController.masterViewController = self;
    collapseController.delegate = self;
    
//    id a = self.splitViewController;
//    id i = self.splitViewController.viewControllers;
//    id j = (MiddleViewController *)[[[self.splitViewController.viewControllers lastObject] childViewControllers] firstObject];
//    self.middleViewController = (MiddleViewController *)[[self.splitViewController.viewControllers lastObject] topViewController]; // must change to first
//
//
   //[self performSelector:@selector(mmm) withObject:nil afterDelay:7];
    
     [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(managedObjectContextDidChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.managedObjectContext];
    
    //CollapseController *collapseController = [CollapseController.alloc initWithSplitViewController:self.splitViewController masterViewController:self];
    //collapseController.delegate = self;
    //DetailNavigationController *dnc = self.splitViewController.viewControllers.lastObject;
    //collapseController.detailNavigationController = dnc;
    //self.selectedDetailItem = dnc.detailItem;

//    id i = self.splitViewController.collapseController;
//    self.splitViewController.collapseController.masterViewController = self;
//    self.splitViewController.collapseController.delegate = self;
}

- (DetailNavigationController *)recreateDetailNavigationControllerForCollapseController:(CollapseController *)collapseController{
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"MiddleNavigationController"];
    return nav;
}


- (void)mmm{
    NSLog(@"mmm");
 //   Venue *venue = self.fetchedResultsController.fetchedObjects.firstObject;
 //   self.masterItemForSegue = venue;
   //[self.collapseControllerForMaster.detailViewController performSegueWithIdentifier:@"unwind" sender:self];
   // [self performSegueWithIdentifier:@"showDetail" sender:self];
    
   // [self.managedObjectContext deleteObject:venue];
 //   [self.managedObjectContext save:nil];
    [self performSegueWithIdentifier:@"unwind" sender:self];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    if(!editing && animated){
        // because otherwise the checkmark gets selected when sliding back.
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [self tableViewDidEndEditing];
        }];
    }
    [super setEditing:editing animated:animated];
    if(!editing){
        if(animated){
            [CATransaction commit];
        }
        else{
            [self tableViewDidEndEditing];
        }
    }
}

- (void)tableViewDidEndEditing{
    [self updateRowSelectionForCurrentDetailItem];
}

- (void)viewWillAppear:(BOOL)animated {
    //self.clearsSelectionOnViewWillAppear = self.collapseControllerForMaster.splitViewController.isCollapsed;
    self.clearsSelectionOnViewWillAppear = self.collapseController.splitViewController.isCollapsed;
    [self selectRowForCurrentDetailItem]; // causes number of sections to be called even tho table hasn't been loaded yet.
    [super viewWillAppear:animated];
    // by doing this in appear means it is only called when seperating.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:self.collapseController.splitViewController];
    [self updateRowSelectionForCurrentDetailItem];
    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.fetchedResultsController.delegate = nil;
    //[NSNotificationCenter.defaultCenter removeObserver:self name:UIViewControllerShowDetailTargetDidChangeNotification object:self.collapseControllerForMaster.splitViewController];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIViewControllerShowDetailTargetDidChangeNotification object:self.collapseController.splitViewController];
}

- (void)showDetailTargetDidChange:(NSNotification *)notification
{
    // if not editing and changing to collapsed then need to deseclect a selected row.
    // if editing then best not edit the selection.
    // if now seperated then we need to select the row if not editing.
    [self performSelector:@selector(updateRowSelectionForCurrentDetailItem) withObject:nil afterDelay:0];
    //[self updateRowSelectionForCurrentDetailItem];
}

- (BOOL)shouldAlwaysHaveSelectedRow{
    //if(self.collapseControllerForMaster.splitViewController.isCollapsed){
    if(self.collapseController.splitViewController.isCollapsed){
        return NO;
    }
    else if(self.isEditing){
        return NO;
    }
    return YES;
}

- (void)updateRowSelectionForCurrentDetailItem{
    if(!self.shouldAlwaysHaveSelectedRow){
        //[self.tableView selectRowAtIndexPath:nil animated:NO scrollPosition:UITableViewScrollPositionNone];
        return;
    }
    [self selectRowForCurrentDetailItem];
}

- (void)selectRowForCurrentDetailItem{
    id object = self.selectedDetailItem;// self.collapseController.detailViewController.detailItem;
    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:0];
}

- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    Venue *newVenue = [[Venue alloc] initWithContext:context];
    
    NSArray *names = [NSArray arrayWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"VenueNames" ofType:@"plist"]];
    uint32_t rnd = arc4random_uniform((uint32_t)names.count);
    newVenue.name = [names objectAtIndex:rnd];
    // If appropriate, configure the new managed object.
   // newVenue.timestamp = [NSDate date];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
//    self.collapseControllerForMaster.detailItem = newVenue;
//    [self performSegueWithIdentifier:@"showDetail" sender:sender];
//    [self updateRowSelectionForCurrentDetailItem];
}

#pragma mark - Segues

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
   // return NO;
    if ([identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        if(!indexPath){
            return NO;
        }
        Venue *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        if(!object){
            return NO;
        }
        self.selectedDetailItem = object;
    }
    return YES;
}

- (void)middleViewController:(MiddleViewController *)controller didFinishWithSave:(BOOL)save{
    NSLog(@"");
    [self.managedObjectContext save:nil];
}

- (void)setDetailNavigationController:(DetailNavigationController *)detailNavigationController{
    _detailNavigationController = detailNavigationController;
    self.collapseController.detailNavigationController = detailNavigationController;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    TestSegue *ts = (TestSegue *)segue;
//    self.splitViewController.delegate = ts;
//    self.testSegue = ts;
//    ts.detailItem = self.collapseControllerForMaster.detailItem
    // NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    // Venue *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // MiddleViewController *controller = (MiddleViewController *)[segue destinationViewController];
    DetailNavigationController *detailNavigationController = (DetailNavigationController *)segue.destinationViewController;
    ///controller.detailItem = self.selectedDetailItem;
    //controller.delegate = self;
    detailNavigationController.detailItem = self.selectedDetailItem;
    
    MiddleViewController *controller = (MiddleViewController *)[[segue destinationViewController] topViewController];
    //controller.selectedDetailItem = self.otherDetailNavigationController.detailItem;
    
    controller.delegate = self;
    
    // passing through 
    controller.middleEndCollapseController = self.middleEndCollapseController;
    
    self.detailNavigationController = detailNavigationController;
    //controller.managedObjectContext = self.managedObjectContext;
    //  controller.navigationItem.leftBarButtonItem = self.collapseControllerForMaster.splitViewController.displayModeButtonItem;
    //controller.detailSplitViewController = self.splitViewController;
   // controller.masterItem = self.selectedDetailItem;
   // controller.delegate = self;
    //id i = controller.middleTableViewController;
    //self.middleEndCollapseController.masterViewController = controller;
   // controller.middleEndCollapseController = self.middleEndCollapseController;
    
    //controller.innerCollapseController = self.innerCollapseController;
    //self.middleViewController = controller;
    // if ([[segue identifier] isEqualToString:@"showDetail"]) {
    //self.collapseControllerForMaster.detailViewController = controller;
    //self.collapseController.detailViewController = controller;
    //id i = controller.view; // leave in until figure out
    
   // [NSNotificationCenter.defaultCenter removeObserver:self name:NSManagedObjectContextObjectsDidChangeNotification object:self.managedObjectContext];
   
//    id masterItem = self.masterItemForSegue;
//    if(masterItem){
//        controller.masterItem = masterItem;
//    }
//    if(self.previousDetailItemWasDeleted){
//        self.previousDetailItemWasDeleted = NO;
//        MySegue *mySegue = (MySegue *)segue;
//        mySegue.animate = YES;
//        [mySegue setAnimationDidStop:^{
//            if(!masterItem){
//                [controller performSegueWithIdentifier:@"unwind" sender:self];
//            }
//        }];
//    }
}


//- (UIViewController *)targetViewControllerForAction:(SEL)action sender:(id)sender{
//    //NSLog(@"");
//    //id i = self.collapseControllerForMaster.splitViewController;
//    //return self.collapseControllerForMaster.splitViewController;
//    return self.collapseController.splitViewController;
//}

#pragma mark - Table View

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.navigationController pushViewController:MiddleViewController.alloc.init animated:YES];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger i = [[self.fetchedResultsController sections] count];
    return i;
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

- (void)configureCell:(UITableViewCell *)cell withVenue:(Venue *)venue {
    cell.textLabel.text = venue.name;//timestamp.description;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController<Venue *> *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    else if(!self.managedObjectContext){
        return nil;
    }
    NSFetchRequest<Venue *> *fetchRequest = Venue.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Venue *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil]; // @"Master"
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
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
            //self.indexPathOfDeletedObject = newIndexPath;
            break;
            
        case NSFetchedResultsChangeDelete:
        {
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            Event *event = (Event *)anObject;
//            NSArray *events = event.changedValuesForCurrentEvent[@"events"];
//            if([events containsObject:self.innerCollapseController.detailItem]){
//                self.indexPathOfDeletedObject = indexPath;
//            }
            //id i = self.collapseControllerForMaster.detailViewController.detailItem;
            //if(anObject == self.collapseControllerForMaster.detailViewController.detailItem){
            if(anObject == self.selectedDetailItem){
                self.indexPathOfDeletedObject = indexPath;
            }
            break;
        }
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withVenue:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withVenue:anObject];
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

// called before did change
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
            object = [controller objectAtIndexPath:newIndexPath];
        }
        self.selectedDetailItem = object;
        // only replace it if it is visible. So it can respond to its change and set a blank detail. It will be replaced upon either seperate or select another.
        if(self.collapseController.isDetailViewControllerVisible){
           [self showSelectedDetailItem];
        }
    }
}

- (void)showSelectedDetailItem{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    [self updateRowSelectionForCurrentDetailItem];
}

- (void)managedObjectContextDidChange:(NSNotification *)notification{
   // return;
    NSSet *deletedObjects = notification.userInfo[NSDeletedObjectsKey];
    Venue *venue = nil;//self.collapseController.detailNavigationController.detailItem;
    NSLog(@"%@", venue.name);
 //   if([deletedObjects containsObject:self.collapseController.detailNavigationController.detailItem]){
//        NSLog(@"");
//        if(self.collapseControllerForMaster.isDetailViewControllerVisible){
//            [self showDetailItem:nil];
//        }
 //   }
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

- (void)middleViewControllerDeleteTapped:(MiddleViewController *)middleViewController{
    self.previousDetailItemWasDeleted = YES;
    [self.managedObjectContext deleteObject:middleViewController.detailItem];
    [self.managedObjectContext save:nil];
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
    Venue *venue = (Venue *)object;
    //[self.tableView reloadData];
    //  NSAssert(self.fetchedTableRowsController.fetchedResultsController.fetchedObjects, @"indexPathForElementWithModelIdentifier requires fetchedObjects");
    return [self.fetchedResultsController indexPathForObject:venue];
}

- (void)middleViewController:(MiddleViewController *)controller didCreateDetailNavigationController:(DetailNavigationController *)detailNavigationController{
    //self.otherDetailNavigationController = detailNavigationController;
}

@end
