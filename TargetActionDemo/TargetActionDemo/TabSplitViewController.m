//
//  SplitViewController.m
//  TargetActionDemo
//
//  Created by Malcolm Hall on 15/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "TabSplitViewController.h"
#import "SceneDelegate.h"
#import "PersistentContainer.h"
#import "DetailViewController.h"
#import "DetailNavigationController.h"
#import "DetailViewController.h"
#import "SceneSplitViewController.h"
#import "SceneViewController.h"

NSString * const PersistentContainerResultsChanged = @"PersistentContainerResultsChanged";
NSString * const SelectedEventChanged = @"SelectedEventChanged";
NSString * const TabSplitViewControllerCurrentDetailItemChanged = @"TabSplitViewControllerCurrentDetailItemChanged";

@interface TabSplitViewController () <UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableArray *changes;
//@property (strong, nonatomic, readwrite) Event *selectedEvent;
@property (strong, nonatomic) DetailNavigationController *detailNavigationController;

@end

@implementation TabSplitViewController

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    if(action == @selector(toggleMasterVisible:)){
//        return NO;
//    }
    return [super canPerformAction:action withSender:sender];
}

//- (void)selectEvent:(Event *)event sender:(id)sender{
//    self.selectedEvent = event;
//}

- (Event *)currentDetailItem{
    DetailViewController *dvc = self.detailNavigationController.viewControllers.firstObject;
    return dvc.detailItem;
}

//- (PersistentContainer *)persistentContainer{
//    return (PersistentContainer *)[self mcd_persistentContainerWithSender:self];
//}

- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
    [super showDetailViewController:vc sender:sender];
    self.detailNavigationController = (DetailNavigationController *)vc;
}

- (void)setDetailNavigationController:(DetailNavigationController *)detailNavigationController{
    if(detailNavigationController == _detailNavigationController){
        return;
    }
    _detailNavigationController = detailNavigationController;
    detailNavigationController.delegate = self;
}

//- (void)setSelectedEvent:(Event *)selectedEvent{
//    _selectedEvent = selectedEvent;
//    [NSNotificationCenter.defaultCenter postNotificationName:SelectedEventChanged object:self];
//}

//- (IBAction)selectNext:(id)sender{
////    NSArray *fetchedObjects = self.fetchedResultsController.fetchedObjects;
////    NSUInteger index = [fetchedObjects indexOfObject:self.selectedEvent] + 1;
////    self.selectedEvent = fetchedObjects[index];
//}


- (IBAction)updateSelectedObject:(id)sender {

    NSManagedObjectContext *context = self.sceneViewController.persistentContainer.viewContext;
    Event *event = self.currentDetailItem;
        
    // If appropriate, configure the new managed object.
    event.timestamp = [NSDate date];
        
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
}

//- (PersistentContainer *)mcd_persistentContainerWithSender:(id)sender{
//    return self.persistentContainer;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
//    self.changes = NSMutableArray.array;
//}

//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
//           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
//
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
//
//    NSMutableDictionary *dict = NSMutableDictionary.dictionary;
//    if(anObject){
//        dict[@"Object"] = anObject;
//    }
//    if(indexPath){
//        dict[@"IndexPath"] = indexPath;
//    }
//    dict[@"ChangeType"] = @(type);
//    if(newIndexPath){
//        dict[@"NewIndexPath"] = newIndexPath;
//    }
//    [self.changes addObject:dict];
//}

//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    [NSNotificationCenter.defaultCenter postNotificationName:PersistentContainerResultsChanged object:self userInfo:@{@"Changes" : self.changes}];
//    self.changes = nil;
//}

//- (NSIndexPath *)indexPathForSelectedEvent{
//    return [self.fetchedResultsController indexPathForObject:self.selectedEvent];
//}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //UINavigationController *nav = viewController;
    DetailViewController *dvc = (DetailViewController *)viewController;
    //self.selectedEvent = dvc.detailItem;
    [NSNotificationCenter.defaultCenter postNotificationName:TabSplitViewControllerCurrentDetailItemChanged object:self];
}

@end

@implementation UIViewController(TabSplitViewController)

- (TabSplitViewController *)tabSplitViewController{
    UISplitViewController *svc = self.splitViewController;
       if([svc isKindOfClass:TabSplitViewController.class]){
           return (TabSplitViewController *)svc;
       }
       return svc.tabSplitViewController;
}

@end
