//
//  DetailViewController.m
//  BigSplit
//
//  Created by Malcolm Hall on 11/08/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
//@synthesize collapseControllerForDetail = _collapseControllerForDetail;

- (void)configureView {
    // Update the user interface for the detail item.
    //if (self.detailItem) {
        self.detailDescriptionLabel.text = self.event.timestamp.description;
    //}
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
  
}



- (void)malc:(id)sender{
    MUISplitViewController *split = UIApplication.sharedApplication.keyWindow.rootViewController;
   // [split changeTraits];
}

//- (void)showDetailTargetDidChange:(NSNotification *)notification{
// self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UISplitViewController *split = self.mui_collapseControllerForDetail.splitViewController;//UIApplication.sharedApplication.keyWindow.rootViewController;
    // self.myItem =
    if(!split){
        return;
    }
    self.navigationItem.leftBarButtonItems = @[split.displayModeButtonItem];//, self.myItem];;
    
//    UISplitViewController *split = self.splitViewController;
   //  self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:self.splitViewController];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
  //   self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.navigationItem.leftBarButtonItems = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setEvent:(Event *)event{
    if (_event == event) {
        return;
    }
    _event = event;
    if(!self.isViewLoaded){
        return;
    }
    // Update the view.
    [self configureView];
}

//- (UIViewController *)targetViewControllerForAction:(SEL)action
//                                             sender:(id)sender{
//    NSLog(@"");
//    return nil;
//}

- (id)detailItem{
    return self.event;
}

- (IBAction)buttonTappded:(id)sender{
    //self.navigationController.navigationBarHidden = NO;
    UITableViewController *v =    UITableViewController.alloc.init;
    v.navigationItem.title = @"Table";
    [self showViewController:v sender:self];
}

@end
