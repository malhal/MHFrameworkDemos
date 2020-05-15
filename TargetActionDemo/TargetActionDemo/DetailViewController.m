//
//  DetailViewController.m
//  TargetActionDemo
//
//  Created by Malcolm Hall on 15/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "DetailViewController.h"
#import "PersistentContainer.h"
#import "TabSplitViewController.h"
#import "DetailNavigationController.h"
#import "SceneSplitViewController.h"
#import "SceneViewController.h"

@interface DetailViewController ()<NSFetchedResultsControllerDelegate>

//@property (strong, nonatomic, readonly) Event *detailItem;
//@property (strong, nonatomic, readonly) TabSplitViewController *splitViewController;

//@property (strong, nonatomic, readonly) PersistentContainer* persistentContainer;
@property (strong, nonatomic) Event *selectedObject;
@property (copy, nonatomic) NSString *defaultText;
//@property (strong, nonatomic, readonly) Event *detailItem;

@end

@implementation DetailViewController
//@dynamic splitViewController;

//- (Event *)detailItem{
//    return self.detailNavigationController.detailItem;
//}

- (IBAction)trash:(id)sender{
    [self.persistentContainer.viewContext deleteObject:self.detailItem];
    [self.persistentContainer.viewContext save:nil];
}

//- (SplitViewController *)splitViewController{
//    return (SplitViewController *)super.splitViewController;
//}

- (PersistentContainer *)persistentContainer{
    return self.sceneViewController.persistentContainer;
}

//- (NSFetchedResultsController<Event *> *)fetchedResultsController{
//    return self.splitViewController.fetchedResultsController;
//}

//- (Event *)detailItem{
//    return self.splitViewController.selectedEvent;
//}
//
//- (void)configureView {
//    // Update the user interface for the detail item.
//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = self.detailItem.timestamp.description;
//     //   self.splitViewController.selectedEvent = self.detailItem;
//
//    }
//}

- (void)configureView {
   // BOOL nextEnabled = NO;
   // BOOL previousEnabled = NO;
    BOOL trashEnabled = NO;
    NSString *detailDescriptionLabelText = self.defaultText;
    // Update the user interface for the detail item.
    Event *detailItem = self.detailItem;
    if (detailItem) {
        detailDescriptionLabelText = detailItem.timestamp.description;
        trashEnabled = YES;
       // NSArray *fetchedObjects = self.fetchedResultsController.fetchedObjects;
      //  nextEnabled = fetchedObjects.count > 1 && fetchedObjects.lastObject != detailItem;//[self targetViewControllerForAction:@selector(next:) sender:self];
    //    previousEnabled = fetchedObjects.count > 1 && fetchedObjects.firstObject != detailItem;//[self targetViewControllerForAction:@selector(previous:) sender:self];
    }
    self.detailDescriptionLabel.text = detailDescriptionLabelText;
    self.trashButtonItem.enabled = trashEnabled;
  //  self.nextButtonItem.enabled = nextEnabled;
  //  self.previousButtonItem.enabled = previousEnabled;
  //  self.fetchedResultsController.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultText = self.detailDescriptionLabel.text;
 
    // Do any additional setup after loading the view.
    //[self configureView];
 
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(changed:) name:PersistentContainerResultsChanged object:nil];
    self.navigationItem.rightBarButtonItems = @[self.detailNavigationController.nextButtonItem, self.detailNavigationController.previousButtonItem];
     self.navigationItem.leftBarButtonItem = self.tabSplitViewController.displayModeButtonItem;
     self.navigationItem.leftItemsSupplementBackButton = YES;
    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self];
  
}

//- (void)changed:(NSNotification *)notification{
//
//
//    NSDictionary *userInfo = notification.userInfo;
// //   UITableView *tableView = self.tableView;
//  //  [tableView beginUpdates];
//    for(NSDictionary *change in userInfo[@"Changes"]){
//
//        id anObject = change[@"Object"];
//        if(anObject != self.detailItem){
//            continue;
//        }
//
//        NSFetchedResultsChangeType type = [change[@"ChangeType"] unsignedIntegerValue];
//        NSIndexPath *indexPath = change[@"IndexPath"];
//        NSIndexPath *newIndexPath = change[@"NewIndexPath"];
//
//
//        switch(type) {
//               case NSFetchedResultsChangeInsert:
//             //      [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//                   break;
//
//               case NSFetchedResultsChangeDelete:
//            //       [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//                [self performSegueWithIdentifier:@"replace" sender:self];
//                   break;
//
//               case NSFetchedResultsChangeUpdate:
//           //        [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
//                 [self configureView];
//                   break;
//
//               case NSFetchedResultsChangeMove:
//                 [self configureView];
//            //       [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
//           //        [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
//                   break;
//           }
//    }
//}



#pragma mark - Managing the detail item

- (void)setDetailItem:(Event *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;

        // Update the view.
       // [self configureView];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
    controller.detailItem = self.selectedObject;
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
}

@end
