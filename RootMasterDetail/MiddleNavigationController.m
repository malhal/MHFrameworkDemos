//
//  MiddleNavigationController.m
//  RootMasterDetail
//
//  Created by Malcolm Hall on 29/01/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MiddleNavigationController.h"
//#import "SelectedItemController.h"
#import "OuterSplitViewController.h"

NSString * const MiddleNavigationControllerDetailItemDidChange = @"MiddleNavigationControllerDetailItemDidChange";
static NSString *kDetailItemStateKey = @"SelectedDetailItem";
static NSString *kManagedObjectContextStateKey = @"ManagedObjectContext";


@interface MiddleNavigationController ()

@property (nonatomic, nullable, readwrite) SelectedItemController* selectedItemController;


@end

@implementation MiddleNavigationController


// the current design just ignores anything that didn't come from a user, i.e. a view.
// this allows seperate to show the detail of the first item.
// maybe find the child that is the same class and replace it if it exists?
- (void)showViewController:(UIViewController *)vc sender:(id)sender{
    //if(![sender isKindOfClass:UIView.class]){
        //        NSMutableArray *array = self.viewControllers.mutableCopy;
        //        BOOL contains = NO;
        //        for(UIViewController *v in self.viewControllers.reverseObjectEnumerator){
        //            [array removeLastObject];
        //            if([v isKindOfClass:vc.class]){
        //                contains = YES;
        //                break;
        //            }
        //        }
        //        if(contains){
        //            [array addObject:vc];
        //            [self setViewControllers:array animated:NO];
        //        }
  //  NSArray *childViewControllers = self.childViewControllers;
    
    //if(![childViewControllers containsObject:sender]){
//    if(![sender isMemberOfViewControllerHierarchy:self]){
//        [self.parentViewController showViewController:vc sender:sender];
//        return;
//    }
    [super showViewController:vc sender:sender];
    
    
    
    /*
    return;
    
    if([vc isKindOfClass:MiddleNavigationController.class]){
        UINavigationController *parent = self.navigationController;
        NSAssert(parent, @"Parent cannot be nil");
        NSMutableArray *array = parent.viewControllers.mutableCopy;
        NSInteger i = [array indexOfObject:self];
        [array replaceObjectAtIndex:i withObject:vc];
        [parent setViewControllers:array animated:NO];
        return; // prevents pushing the detail when collapsed but the split has preserved it.
    }
    [super showViewController:vc sender:sender];
     */
    
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [super encodeRestorableStateWithCoder:coder];
    
//    [coder encodeObject:self.selectedItem.managedObjectContext forKey:kManagedObjectContextStateKey];
//    [coder encodeObject:self.detailItem.objectID.URIRepresentation forKey:kDetailItemStateKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
    [super decodeRestorableStateWithCoder:coder];
//    NSManagedObjectContext *managedObjectContext = [coder decodeObjectForKey:kManagedObjectContextStateKey];
//    NSURL *objectURI = [coder decodeObjectForKey:kDetailItemStateKey];
//    if(objectURI){
//        NSManagedObject *object = [managedObjectContext mcd_existingObjectWithURI:objectURI error:nil];
//        if(object){
//            self.detailItem = object;
//        }
//    }
}

//- (void)setDetailItem:(NSManagedObject *)detailItem{
//    if(detailItem == _detailItem){
//        return;
//    }
//    _detailItem = detailItem;
//    [self.viewControllers.firstObject detailNavigationControllerDidSetDetailItem:detailItem];
//}

//- (UIViewController *)targetViewControllerForAction:(SEL)action sender:(id)sender{
//    if(action == @selector(showDetailViewController:sender:)){
//        return self.resolvedOuterSplitViewController;
//    }
//    return [super targetViewControllerForAction:action sender:sender];
//}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // malc commented
    //[self.view layoutIfNeeded]; // also fixes nav bar item?
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    //self.resolvedOuterSplitViewController = self.outerSplitViewController;
    
    
//    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
//        NSLog(@"");
//    } completion:^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {
//        NSLog(@"");
//    }];
    
}



@end

//@implementation UIViewController (MiddleNavigationController)

//- (MiddleNavigationController *)detailNavigationController{
//    UINavigationController *nc = self.navigationController;
//    if(![nc isKindOfClass:MiddleNavigationController.class]){
//        return nil;
//    }
//    return (MiddleNavigationController *)nc;
//}

//@end
