//
//  MyNavigationController.m
//  CloudEvents
//
//  Created by Malcolm Hall on 06/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MyNavigationController.h"
#import "RootViewController.h"
#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MyNavigationController ()

@end

@interface UISplitViewController ()

- (UISplitViewController *)_panelImpl;

- (UISplitViewController *)panelController;

- (UIViewController *)preservedDetailController;

@end

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.view layoutIfNeeded];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//      // [self.view layoutIfNeeded];
//}

-   (void)applicationFinishedRestoringState{
    //[self.view layoutIfNeeded];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// The default implementation restores the previous secondary controller.
- (nullable UIViewController *)separateSecondaryViewControllerForSplitViewController:(UISplitViewController *)splitViewController{
    
    UISplitViewController *x = splitViewController._panelImpl;
    id y = x.panelController.preservedDetailController;
    
    id a = self.viewControllers;
    id b = splitViewController.viewControllers;
    if([self.topViewController isKindOfClass:UINavigationController.class]){
        return [super separateSecondaryViewControllerForSplitViewController:splitViewController];
    }
    if(y){
        return nil;
    }
    
    UIViewController *vc = self.topViewController;
    if([vc isKindOfClass:RootViewController.class]){
       // vc = [(RootViewController *)vc shownViewController];
    }
    if([vc isKindOfClass:MasterViewController.class]){
        vc = nil;//[(MasterViewController *)vc shownViewController].navigationController;
        return vc;
    }
    return nil;
//    UIViewController *top = self.topViewController;
//    if([top isKindOfClass:RootViewController.class]){
//        RootViewController *rvc = (RootViewController *)top;
//        MasterViewController *mvc = rvc.masterViewController;
//        DetailViewController *dvc = mvc.detailViewController;
//        id c = dvc.navigationController;
//        return c;
//    }

    
    return nil;
}

// only called when there is a detail item
//- (void)collapseSecondaryViewController:(UIViewController *)secondaryViewController forSplitViewController:(UISplitViewController *)splitViewController{
    // we need to push on any shown view controllers before the secondary
//    UINavigationController *nav = splitViewController.viewControllers.firstObject;
//    UIViewController *top = nav.topViewController;
//    if([top isKindOfClass:RootViewController.class]){
//        RootViewController *rvc = (RootViewController *)top;
//        MasterViewController *mvc = nil;//rvc.shownViewController;
//        if(mvc){
//            [self pushViewController:mvc animated:NO];
//        }
//    }
    
    // we might need to push on the master for the detail item.
//    [self.viewControllers.firstObject collapseSecondaryViewController:secondaryViewController forSplitViewController:splitViewController];
//    [super collapseSecondaryViewController:secondaryViewController forSplitViewController:splitViewController];
//}

// cant set view controllers array cause miss out on _prepareForNestedDisplayWithNavigationController
// i think if on an event and the venue is deleted it shouldnt be showing an event in another venue.
// the same way if you delete the last event in a venue it doesnt go on to next venue.
//- (void)showViewController:(UIViewController *)vc sender:(id)sender{
    //NSMutableArray *vcs = self.viewControllers.mutableCopy;

    
    // old way before trying the pop inside the controller.
    //    UIViewController *topViewController = self.topViewController;
//    if(![sender isKindOfClass:UIViewController.class]){
//        [super showViewController:vc sender:sender];
//        return;
//    }
//    else if(![self.viewControllers containsObject:sender]){ // safety but likely will never happen
//        return;
//    }
//    else if(topViewController != sender){
//        if([vc isKindOfClass:UINavigationController.class]){
//            [self popToViewController:sender animated:NO];
//            [self pushViewController:vc animated:NO];
//        }
//    }
    
    
    
//    NSArray *poppedVCs = [self popToViewController:sender animated:NO];
//    [self pushViewController:vc animated:NO];
//    if(!poppedVCs){
//         [self popViewControllerAnimated:NO];
//        return;
//    }
//    for(NSUInteger i=1;i<poppedVCs.count;i++){
//        UIViewController *poppedVC = poppedVCs[i];
//        [self pushViewController:poppedVC animated:NO];
//    }
    

    // only show nav controllers if the user requested it.
    
    
// else if([topViewController isKindOfClass:UINavigationController.class]){
// }
//
//    else
//    if(topViewController != sender){
//
//            if([vc isKindOfClass:UINavigationController.class]){
//                [self popToViewController:sender animated:NO];
//                [self pushViewController:vc animated:NO];
//            }else{
//                [vcs replaceObjectAtIndex:1 withObject:vc];
//                self.viewControllers = vcs;
//
//                [self popViewControllerAnimated:YES];
//            }
//        }
//        else if([self.viewControllers containsObject:sender]){
//            [self popToViewController:sender animated:NO];
//            [self pushViewController:vc animated:NO];
//        }
//        else{
//            // when portrait root and deleting selected venue
//            [self pushViewController:vc animated:NO]; // causes re-entry for detail
//            [self popViewControllerAnimated:NO];
//        }
//    }
//}


@end


//NSMutableArray *vcs = self.viewControllers.mutableCopy;
//UIViewController *topViewController = self.topViewController;
//if(topViewController != sender){
//    if([topViewController isKindOfClass:UINavigationController.class]){
//
//        if([vc isKindOfClass:UINavigationController.class]){
//            [self popToViewController:sender animated:NO];
//            [self pushViewController:vc animated:NO];
//        }else{
//            [vcs replaceObjectAtIndex:1 withObject:vc];
//            self.viewControllers = vcs;
//
//            [self popViewControllerAnimated:YES];
//        }
//    }
//    else if([self.viewControllers containsObject:sender]){
//
//        [self popToViewController:sender animated:NO];
//        [self pushViewController:vc animated:NO];
//    }
//}
//else if([vc isKindOfClass:UINavigationController.class]){
//    return;
//}
//else{
//    // when portrait root and deleting selected venue
//    [self pushViewController:vc animated:NO]; // causes re-entry for detail
//    [self popViewControllerAnimated:NO];
//    }
