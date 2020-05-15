//
//  SplitViewController.m
//  CrossPlatform
//
//  Created by Malcolm Hall on 20/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "SplitViewController.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CrossPlatform+CoreDataModel.h"

@interface SplitViewController ()

@property (strong, nonatomic) Event *selectedEvent;

@end

@implementation SplitViewController

- (IBAction)toggleSidebar:(id)sender{
    NSLog(@"");
}



//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//
//    BOOL b = [super canPerformAction:action withSender:sender];
//    NSLog(@"yes? %ld", b);
//    return b;
//}

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

- (void)selectDetailItem:(Event *)detailItem sender:(id)sender{
    self.selectedEvent = detailItem;
}

- (Event *)selectedDetailItemWithSender:(id)sender{
    return self.selectedEvent;
}

@end
