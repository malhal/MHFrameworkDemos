//
//  SplitViewController.m
//  SingleSource
//
//  Created by Malcolm Hall on 12/01/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "SplitViewController.h"

NSString * const SplitViewControllerDidChangeCurrentDetailItem = @"SplitViewControllerDidChangeCurrentDetailItem";
//NSString * const SplitViewControllerDidChangeMasterObjects = @"SplitViewControllerDidChangeMasterObjects";

extern NSString * const SplitViewControllerWillShowViewController;

@interface SplitViewController () <NSFetchedResultsControllerDelegate>

//@property (strong, nonatomic) NSArray *masterObjects;
@property (strong, nonatomic, readwrite) Event *currentDetailItem;

@end

@implementation SplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    if(action == @selector(next:)){
//        if(!self.detailItem){
//            return NO;
//        }
//        NSUInteger index = [self.masterObjects indexOfObject:self.detailItem];
//        if(index == self.masterObjects.count - 1){
//            return NO;
//        }
//        return YES;
//    }
//    else if(action == @selector(previous:)){
//        if(!self.detailItem){
//            return NO;
//        }
//        NSUInteger index = [self.masterObjects indexOfObject:self.detailItem];
//        if(index == 0){
//            return NO;
//        }
//        return YES;
//    }
//    return [super canPerformAction:action withSender:sender];
//}

//- (IBAction)next:(id)sender{
//    // maybe this logic should be in the detail?
//    NSLog(@"next");
//    NSUInteger index = [self.masterObjects indexOfObject:self.detailItem];
//    index++;
//    self.detailItem = self.masterObjects[index];
//}


//- (void)setMasterObjects:(NSArray *)objects sender:(id)sender{
//    if(self.detailItem && ![objects containsObject:self.detailItem]){
//        // select new detail item
//        Event *newDetailItem;
//        if(objects.count){
//            NSUInteger index = [self.masterObjects indexOfObject:self.detailItem];
//            if(index > objects.count - 1){
//                index = objects.count - 1;
//            }
//            newDetailItem = [objects objectAtIndex:index];
//        }
//        self.detailItem = newDetailItem;
//    }
//    self.masterObjects = objects;
//    [NSNotificationCenter.defaultCenter postNotificationName:SplitViewControllerDidChangeMasterObjects object:self];
//}

//- (void)setDetailItem:(Event *)detailItem fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController sender:(id)sender {
//
//}

- (void)setCurrentDetailItem:(Event *)event sender:(id)sender{
    self.currentDetailItem = event;
}

- (void)setCurrentDetailItem:(Event *)event{
    [self setCurrentDetailItem:event notify:YES];
}

- (void)setCurrentDetailItem:(Event *)currentDetailItem notify:(BOOL)notify{
    if(currentDetailItem == _currentDetailItem){
        return;
    }
    _currentDetailItem = currentDetailItem;
    if(notify){
        [NSNotificationCenter.defaultCenter postNotificationName:SplitViewControllerDidChangeCurrentDetailItem object:self];
    }
}

- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
    [super showDetailViewController:vc sender:sender];
}

- (void)beginAppearanceTransition:(BOOL)isAppearing animated:(BOOL)animated{
    [super beginAppearanceTransition:isAppearing animated:animated];
}

@end

@implementation UIViewController (SplitViewController)

//- (void)setMasterObjects:(NSArray *)objects sender:(id)sender{
//- (void)setMasterFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController sender:(id)sender{
//    // Find and ask the right view controller about settings
//    UIViewController *target = [self targetViewControllerForAction:@selector(setMasterFetchedResultsController:sender:) sender:sender];
//    if (target) {
//        return [target setMasterFetchedResultsController:fetchedResultsController sender:sender];
//    } else {
//        return;
//    }
//}

- (void)setCurrentDetailItem:(Event *)event sender:(id)sender
{
    // Find and ask the right view controller about settings
    UIViewController *target = [self targetViewControllerForAction:@selector(setCurrentDetailItem:sender:) sender:sender];
    if (target) {
        return [target setCurrentDetailItem:event sender:sender];
    } else {
        return;
    }
}

- (SplitViewController *)mh_splitViewController{
    UISplitViewController *svc = self.splitViewController;
       if([svc isKindOfClass:SplitViewController.class]){
           return (SplitViewController *)svc;
       }
       return svc.mh_splitViewController;
}

@end
