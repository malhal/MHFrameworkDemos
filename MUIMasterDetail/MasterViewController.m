//
//  MasterViewController.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 23/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "PersistentContainer.h"
#import "FetchedResultsController.h"
#import <objc/runtime.h>
#import "MasterTableViewController.h"

@interface MasterPageContainerDataSource : MUIFetchedPageContainerDataSource

@end

@implementation MasterPageContainerDataSource

- (UIViewController *)viewControllerForObject:(id)object inPageViewController:(UIPageViewController *)pageViewController{
    MasterTableViewController *controller = (MasterTableViewController *)[pageViewController.storyboard instantiateViewControllerWithIdentifier:@"MasterTableViewController"];
    controller.managedObjectContext = self.fetchedResultsController.managedObjectContext;
    //self.displayedObject = self.fetchedPageContainerDataSource.fetchedResultsController.fetchedObjects.firstObject;
   // controller.venue = object;
    return controller;
}

@end

@interface MasterViewController ()

//@property (strong, nonatomic) MUIFetchedPageViewControllerDelegate *fetchedPageViewControllerDelegate;

@end

@implementation MasterViewController



- (MUIFetchedPageContainerDataSource *)newFetchedPageContainerDataSource{
    NSFetchRequest *fetchRequest = [Folder fetchRequestWithParentListItem:self.parentListItem];
    NSFetchedResultsController * fetchedResultsController = [NSFetchedResultsController.alloc initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    fetchedResultsController.delegate = self;
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    return [MasterPageContainerDataSource.alloc initWithFetchedResultsController:fetchedResultsController];
}

- (void)malc{
      
}


- (void)viewDidLoad {
  self.fetchedPageContainerDataSource = self.newFetchedPageContainerDataSource;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    //self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    //self.fetchedResultsController = [self newFetchedResultsController];
 
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

//- (void)configureView{
//    [super configureView];
//}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
//    for(UIViewController *vc in self.childViewControllers){
//        [vc setEditing:editing animated:animated];
//    }
}

//- (void)setSelectedPageObject:(ListItem *)selectedPageObject{
//    [super setSelectedPageObject:selectedPageObject];
//    if(!selectedPageObject){
////        [self.navigationController popViewControllerAnimated:YES];
////        return;
//    }
//    self.title = selectedPageObject.timestamp.description;
//    //self.masterTableViewController.venue = self.displayedObject;
//    //self.masterTableViewController.fetchRequest = [Event fetchRequestWithParentListItem:displayedObject];
//}

- (IBAction)deleteObject:(id)sender {
    //MasterViewController *controller = self.navigationController.viewControllers.firstObject;
    NSManagedObjectContext *context = self.managedObjectContext;
  //  [context deleteObject:self.displayedObject];
//    NSObject *object = self.displayedObject.parentVenue;
//    if(!object){
//        object = self.displayedObject;
//    }
//    [context deleteObject:object];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
    
- (IBAction)createVenue:(id)sender {
    NSManagedObjectContext *context = self.managedObjectContext;
    Folder *folder = [[Folder alloc] initWithContext:context];
        
    // If appropriate, configure the new managed object.
    folder.timestamp = [NSDate date];
   // folder.parent = self.selectedPageObject;
    //newEvent.venue = self.venue;
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (IBAction)insertNewObject:(id)sender {
    NSManagedObjectContext *context = self.managedObjectContext;
    Event *newEvent = [[Event alloc] initWithContext:context];
        
    // If appropriate, configure the new managed object.
    newEvent.timestamp = [NSDate date];
   // newEvent.folder = self.selectedPageObject;
    
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

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"embed"]) {
//        //MasterTableViewController *controller = segue.destinationViewController;
//        //controller.persistentContainer = self.persistentContainer;
//        //controller.managedObjectContext = self.managedObjectContext;
//        //controller.fetchRequest = [Event fetchRequestWithParentListItem:self.displayedObject];
//        self.childPageViewController = segue.destinationViewController;
//    }
//}

- (NSObject *)detailItemInDetailNavigationController:(UINavigationController *)navigationController{
    DetailViewController *controller = (DetailViewController *)navigationController.topViewController;
    return controller.detailItem;
}

#pragma mark - Fetched results controller

//- (NSFetchedResultsController *)newFetchedResultsController {
//    NSFetchRequest *fetchRequest = Event.myFetchRequest;
//    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"parentVenue = %@", self.displayedObject.parentVenue];
//    FetchedResultsController * fetchedResultsController = [FetchedResultsController.alloc initWithFetchRequest:fetchRequest managedObjectContext:self.persistentContainer.viewContext sectionNameKeyPath:nil cacheName:nil];
////    fetchedResultsController.delegate = self;
////    [fetchedResultsController performFetch:nil];
//    return fetchedResultsController;
//}

//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
//    [self.tableView beginUpdates];
//}

//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
//           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
//    switch(type) {
//        case NSFetchedResultsChangeInsert:
//            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//
//        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//
//        default:
//            return;
//    }
//}

//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
//       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
//      newIndexPath:(NSIndexPath *)newIndexPath {
//    UITableView *tableView = self.tableView;
//
//    switch(type) {
//        case NSFetchedResultsChangeInsert:
//            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//
//        case NSFetchedResultsChangeDelete:
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//        case NSFetchedResultsChangeMove:
//            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
//            // no break
//        case NSFetchedResultsChangeUpdate:
//            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
//            break;
//    }
//}

//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    [self.tableView endUpdates];
// //   [self configureView];
//}

@end

