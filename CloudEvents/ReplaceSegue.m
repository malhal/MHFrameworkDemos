//
//  ReplaceSegue.m
//  AnotherSplitTest
//
//  Created by Malcolm Hall on 23/04/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "ReplaceSegue.h"
#import "DetailViewController.h"

@implementation ReplaceSegue

- (void)perform{
    UIViewController *masterViewController = self.sourceViewController;
    
    id b = self.sourceViewController.mui_viewedObjectViewController;
    id c = self.sourceViewController.navigationController;
    id d = self.sourceViewController.navigationController.viewControllers;
    id e = self.destinationViewController;
    [super perform];
    
    return;
    
    if(self.sourceViewController.navigationController.topViewController != self.sourceViewController){
//        NSArray *viewControllers = self.sourceViewController.navigationController.viewControllers;
//        NSArray *viewControllers2 = [viewControllers subarrayWithRange:NSMakeRange(0, [viewControllers indexOfObject:self.sourceViewController] + 1)];
//        NSArray *viewControllers3 = [viewControllers2 arrayByAddingObject:self.destinationViewController];
//
        NSMutableArray *viewControllers = self.sourceViewController.navigationController.viewControllers.mutableCopy;
        [viewControllers replaceObjectAtIndex:1 withObject:self.destinationViewController];
        [self.sourceViewController.navigationController setViewControllers:viewControllers animated:NO];
    }
    else{
        [super perform];
       // return;
    }
}

@end
