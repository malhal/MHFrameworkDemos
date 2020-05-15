//
//  DetailNavigationController.m
//  TargetActionDemo
//
//  Created by Malcolm Hall on 16/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "DetailNavigationController.h"
#import "TabSplitViewController.h"
#import "DetailNavigationController.h"
#import "PersistentContainer.h"
#import "DetailViewController.h"
#import "SceneSplitViewController.h"
#import "SceneViewController.h"

@interface DetailNavigationController ()

@property (strong, nonatomic) NSFetchedResultsController<Event *> *fetchedResultsController;
//@property (strong, nonatomic)
 
@end

@implementation DetailNavigationController

//- (void)setDetailItem:(Event *)detailItem{
//    if(detailItem == _detailItem){
//        return;
//    }
//    _detailItem = detailItem;
//    [self configureView];
//}

//- (Event *)detailItem{
//    DetailViewController *dvc = self.viewControllers.firstObject;
//    return dvc.detailItem;
//}

- (DetailViewController *)detailViewController{
    return self.viewControllers.firstObject;
}

- (Event *)detailItem{
    return self.detailViewController.detailItem;
}

- (void)configureView {
    BOOL nextEnabled = NO;
    BOOL previousEnabled = NO;
   // BOOL trashEnabled = NO;
   // NSString *detailDescriptionLabelText = self.defaultText;
    // Update the user interface for the detail item.
    Event *detailItem = self.detailItem;
    if (detailItem) {
     //   detailDescriptionLabelText = detailItem.timestamp.description;
      //  trashEnabled = YES;
        NSArray *fetchedObjects = self.fetchedResultsController.fetchedObjects;
        nextEnabled = fetchedObjects.count > 1 && fetchedObjects.lastObject != detailItem;//[self targetViewControllerForAction:@selector(next:) sender:self];
        previousEnabled = fetchedObjects.count > 1 && fetchedObjects.firstObject != detailItem;//[self targetViewControllerForAction:@selector(previous:) sender:self];
        self.detailViewController.detailItem = detailItem;
    }
    //self.detailDescriptionLabel.text = detailDescriptionLabelText;
   // self.trashButtonItem.enabled = trashEnabled;
    self.nextButtonItem.enabled = nextEnabled;
    self.previousButtonItem.enabled = previousEnabled;
  //  self.fetchedResultsController.delegate = self;
}

- (IBAction)next:(id)sender{
    NSUInteger index = [self.fetchedResultsController.fetchedObjects indexOfObject:self.detailItem];
    Event *detailItem = [self.fetchedResultsController.fetchedObjects objectAtIndex:index + 1];
    //[self performSegueWithIdentifier:@"replace" sender:sender];
    DetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    dvc.detailItem = detailItem;
    self.viewControllers = @[dvc];
    [self configureView];
}

- (IBAction)previous:(id)sender{
    NSUInteger index = [self.fetchedResultsController.fetchedObjects indexOfObject:self.detailItem];
    Event *detailItem = [self.fetchedResultsController.fetchedObjects objectAtIndex:index - 1];
    //[self performSegueWithIdentifier:@"replace" sender:sender];
    
    DetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    dvc.detailItem = detailItem;
    self.viewControllers = @[dvc];
    [self configureView];
}

- (PersistentContainer *)persistentContainer{
    return self.sceneViewController.persistentContainer;
}

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
    NSFetchedResultsController<Event *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.persistentContainer.viewContext sectionNameKeyPath:nil cacheName:@"Master"];

    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
   // [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {

}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {

    switch(type) {
        case NSFetchedResultsChangeInsert:

            break;
            
        case NSFetchedResultsChangeDelete:
        {
            Event *object;
            @try {
               object = [self.fetchedResultsController objectAtIndexPath:indexPath];
            } @catch (NSException *exception) {
               object = self.fetchedResultsController.fetchedObjects.lastObject;
            } @finally {
            }
            //self.selectedObject = object;
            //[self performSegueWithIdentifier:@"replace" sender:self];
        }
            break;
            
        case NSFetchedResultsChangeUpdate:

            
            break;
            
        case NSFetchedResultsChangeMove:
            
            
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
   [self configureView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nextButtonItem = [UIBarButtonItem.alloc initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:nil action:@selector(next:)];
    self.previousButtonItem = [UIBarButtonItem.alloc initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:nil action:@selector(previous:)];
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.fetchedResultsController.delegate = self;
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.fetchedResultsController.delegate = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// cannot have this because showDetail is for showing modally.
//- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
//    self.viewControllers = @[vc];
//}

@end

@implementation UIViewController (DetailNavigationController)

- (DetailNavigationController *)detailNavigationController{
    return (DetailNavigationController *)self.navigationController;
}

@end
