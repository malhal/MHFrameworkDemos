//
//  NavigationController.m
//  RootMasterDetail
//
//  Created by Malcolm Hall on 08/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "StartNavigationController.h"
//#import "MiddleTableViewController.h"
//#import "SelectedItemController.h"
#import "StartViewController.h"

@interface StartNavigationController ()
- (BOOL)_allowNestedNavigationControllers;
//@property (strong, nonatomic) id test;
@end

@implementation StartNavigationController

// Ensures we only seperate the detail navigation controller. Required when multiple controllers on the primary nav stack.
// The the preserved detail controller will be shown.
-(UIViewController *)separateSecondaryViewControllerForSplitViewController:(UISplitViewController *)splitViewController{
    if(![self.topViewController isKindOfClass:UINavigationController.class]){
        return nil;
    }
    return [super separateSecondaryViewControllerForSplitViewController:splitViewController];
}



// the current design just ignores anything that didn't come from a user, i.e. a view.
// this allows seperate to show the detail of the first item.
// maybe find the child that is the same class and replace it if it exists?
- (void)showViewController:(UIViewController *)vc sender:(id)sender{ // sender is a table cell in the middle view controller.
    UINavigationController *source = [sender navigationController];
    if(source == self){
        source = self.viewControllers.firstObject;
    }
    if(self.topViewController == source){
        [super showViewController:vc sender:sender];
        return;
    }
    [self popToViewController:source animated:NO];
    [UIView performWithoutAnimation:^{
        [super showViewController:vc sender:sender];
    }];
    return;
    if([[sender class] isEqual:StartViewController.class]){
        return [super showViewController:vc sender:sender];
    }
    [super showViewController:vc sender:sender];
   // [self pushViewController:vc animated:NO];
    return;
    
    if([sender isKindOfClass:UIView.class]){
        [super showViewController:vc sender:sender];
        return;
    }
    
    
    // in 3 col delete venue on end. vc is middle nav. sender is start vc.
    
    BOOL b = self._allowNestedNavigationControllers; // yes
    if([self.topViewController isKindOfClass:UINavigationController.class]){
//        [self.topViewController showViewController:vc sender:sender];
//        return;
    }
    id i = self.viewControllers;

    //sUINavigationController *nav = self.navigationController;
    NSArray *viewControllers = self.viewControllers;
    //    if(viewControllers.count > 1){
    //        nav.viewControllers = @[viewControllers.firstObject, vc];
    //    }
    NSArray *viewControllerClasses = [viewControllers valueForKey:@"class"];
    if([viewControllerClasses containsObject:vc.class]){
        
        NSUInteger i = [viewControllerClasses indexOfObject:vc.class];
        if(i >= 0){
            //self.test =
            id vc = [viewControllers objectAtIndex:i];
           // NSMutableArray *a = viewControllers.mutableCopy;
          //  [a replaceObjectAtIndex:i withObject:vc];
            NSArray *a = [viewControllers subarrayWithRange:NSMakeRange(0, i)];
            a = [a arrayByAddingObject:vc];
            [self setViewControllers:a animated:NO];
            
            NSArray *aa = self.viewControllers;
            
            NSLog(@"");
            
        }
    }
    
    // delete venue from end
    // sender is start
    // i contains start middle end
    // vc is middle
    
//    else if(self.viewControllers.count > 1){
//        NSMutableArray *array = self.viewControllers.mutableCopy; // start and middle in the array but going to show end so want to skip it
//        [array removeLastObject];
//        [array addObject:vc];
//        self.viewControllers = array;//@[self.viewControllers.firstObject, vc];
//    }
    
//    if(![sender isKindOfClass:UIView.class]){
//        NSMutableArray *array = self.viewControllers.mutableCopy;
//        [array replaceObjectAtIndex:1 withObject:vc];
//        [self setViewControllers:array animated:NO];
//        return; // prevents pushing the detail when collapsed but the split has preserved it.
//    }
  //  NSArray *viewControllers = self.viewControllers;
  //  id child = [self childContainingSender:sender];
    // e.g. if compact and at end. Deleting the middle item we replace the middle controller.
    
    //if([vc isKindOfClass:MiddleNavigationController.class]){
    //if(child && [vc isKindOfClass:UINavigationController.class]){
        //UINavigationController *parent = self.navigationController;
        //NSAssert(parent, @"Parent cannot be nil");
        

//        if(viewControllers.lastObject != child){
//            NSUInteger i = [viewControllers indexOfObject:child];
//            NSMutableArray *array = viewControllers.mutableCopy;
//            [array replaceObjectAtIndex:i + 1 withObject:vc];
//            self.viewControllers = array;
//            return;
//        }
        
        
        
//        MiddleNavigationController *nav = (MiddleNavigationController *)vc;
//        UIViewController *rootViewController = nav.viewControllers.firstObject;
//        MiddleNavigationController *targetToReplace;
//        NSArray *viewControllers = self.viewControllers;
//        for(UIViewController *child in viewControllers){
//            if(![child isKindOfClass:MiddleNavigationController.class]){
//                continue;
//            }
//            MiddleNavigationController *n = (MiddleNavigationController *)child;
//            id i = n.viewControllers.firstObject;
//            if([n.viewControllers.firstObject isKindOfClass:rootViewController.class]){
//                targetToReplace = n;
//                break;
//            }
//        }
//        if(targetToReplace){
//            NSMutableArray *array = self.viewControllers.mutableCopy;
//            [array replaceObjectAtIndex:[array indexOfObject:targetToReplace] withObject:vc];
//            self.viewControllers = array;
//
//            [self popToViewController:vc animated:YES];
//            return;
//        }
        
       
     //   [array replaceObjectAtIndex:i withObject:vc];
      //  [self setViewControllers:array animated:NO];
       // return; // prevents pushing the detail when collapsed but the split has preserved it.
//    }
    
//    [super showViewController:vc sender:sender];
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    super.viewControllers = viewControllers;
}

- (UIViewController *)childContainingSender:(id)sender{
    for(UIViewController *vc in self.viewControllers){
        
//        if([sender isMemberOfViewControllerHierarchy:vc]){
//            return vc;
//        }
    }
    return nil;
}

@end


@implementation UIViewController (StartNavigationController)

- (MiddleNavigationController *)innerMasterNavigationController{
    UINavigationController *nc = self.navigationController;
    if(![nc isKindOfClass:StartNavigationController.class]){
        return nil;
    }
    return (StartNavigationController *)nc;
}

@end
