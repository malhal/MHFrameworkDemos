//
//  DetailViewController.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 23/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "DetailViewController.h"
#import "PersistentContainer.h"

@interface DetailViewController ()// <MCDSelectionControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController<Event *> *fetchedResultsController;
//@property (strong, nonatomic) MCDSelectionController *selectionController;
@property (strong, nonatomic) NSIndexPath *deletedIndexPath;
@property (strong, nonatomic) Event *replacementObject;

@end

@implementation DetailViewController

- (void)configureView {
    BOOL trashButtonEnabled = NO;
  //  NSString *detailDescriptionLabelText = self.defaultText;
    // Update the user interface for the detail item.
    Event *detailItem = self.detailItem;
    if (detailItem) {
        self.detailDescriptionLabel.text = detailItem.timestamp.description;
        trashButtonEnabled = YES;
    //    self.selectionController.objects = self.fetchedResultsController.fetchedObjects;
    }
    //self.detailDescriptionLabel.text = detailDescriptionLabelText;
    self.trashButtonItem.enabled = trashButtonEnabled;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
//    self.navigationItem.rightBarButtonItems = self.selectionController.buttonItems;
}

- (void)viewWillAppear:(BOOL)animated{
    //self.fetchedResultsController.delegate = self;
    //[self.fetchedResultsController performFetch:nil];
    [self configureView];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // self.fetchedResultsController.delegate = nil;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(Event *)newDetailItem {
    if (_detailItem == newDetailItem) {
        return;
    }
    _detailItem = newDetailItem;
    
        // Update the view.
    [self configureView];
}

//- (IBAction)next:(id)sender{
//    NSUInteger index = [self.fetchedResultsController.fetchedObjects indexOfObject:self.detailItem];
//    Event *event = self.fetchedResultsController.fetchedObjects[index + 1];
//    //self.selection.selectedObjectForViewController = event;
//    self.replacementObject = event;
//
//}

//- (void)selectionController:(MCDSelectionController *)selectionController didSelectObject:(id)object{
//    [self performSegueWithIdentifier:@"replace" sender:self];
//}

//- (IBAction)previous:(id)sender{
//    NSUInteger index = [self.fetchedResultsController.fetchedObjects indexOfObject:self.detailItem];
//    Event *event = self.fetchedResultsController.fetchedObjects[index - 1];
//    //self.selection.selectedObjectForViewController = event;
//    self.replacementObject = event;
//    [self performSegueWithIdentifier:@"replace" sender:self];
//}

- (IBAction)trash:(id)sender{
    [self.persistentContainer.viewContext deleteObject:self.detailItem];
    [self.persistentContainer.viewContext save:nil];
}

//- (MCDSelectionController *)selectionController{
//    if(!_selectionController){
//        _selectionController = [MCDSelectionController.alloc initWithInitialSelection:self.detailItem];
//        _selectionController.delegate = self;
//    }
//    return _selectionController;
//}

- (NSFetchedResultsController<Event *> *)fetchedResultsController {
    if (!_fetchedResultsController) {
        //_fetchedResultsController = aFetchedResultsController;
        NSFetchRequest *fetchRequest = [ListItem fetchRequestWithParentListItem:self.detailItem.parent];
        fetchRequest.includesSubentities = NO;
        
         _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.persistentContainer.viewContext sectionNameKeyPath:nil cacheName:nil];
        
        //_selectionController = [MCDSelectionController.alloc initWithFetchedResultsController:frc];
        _fetchedResultsController.delegate = self;
        [_fetchedResultsController performFetch:nil];
    }
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            break;
            
        case NSFetchedResultsChangeDelete:
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {

    switch(type) {
        case NSFetchedResultsChangeInsert:
            break;
            
        case NSFetchedResultsChangeDelete:
            if(anObject == self.detailItem){
                self.deletedIndexPath = indexPath;
            }
            break;
            
        case NSFetchedResultsChangeUpdate:
            break;
            
        case NSFetchedResultsChangeMove:
            break;
        default:
            return;
    }
}

// Note: how to pass the object to the segue if not setting it on the selection controller

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    if(self.deletedIndexPath){
//        Event *object;
//        @try {
//           object = [self.fetchedResultsController objectAtIndexPath:self.deletedIndexPath];
//        } @catch (NSException *exception) {
//           object = self.fetchedResultsController.fetchedObjects.lastObject;
//        } @finally {
//        }
//        //self.selection.selectedObjectForViewController = object;
//        self.replacementObject = object;
//        [self performSegueWithIdentifier:@"replace" sender:self];
//        return;
//    }
  //  self.selectionController.objects = controller.fetchedObjects;
    [self configureView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"replace"]) {
        DetailViewController *controller = (DetailViewController *)segue.destinationViewController;
        controller.persistentContainer = self.persistentContainer;
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
       // controller.selection = self.selection;
    //    controller.detailItem = self.selectionController.selectedObject;
       // self.detailViewController = controller;
    }
}

@end
