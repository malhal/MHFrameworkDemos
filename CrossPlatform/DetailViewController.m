//
//  DetailViewController.m
//  CrossPlatform
//
//  Created by Malcolm Hall on 19/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = self.detailItem.timestamp.description;
        [self selectDetailItem:self.detailItem sender:self];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(Event *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:NO];
}

@end

@implementation UIViewController (DetailViewController)

- (void)selectDetailItem:(Event *)detailItem sender:(id)sender
{
    // Find and ask the right view controller about showing detail
    UIViewController *target = [self targetViewControllerForAction:@selector(selectDetailItem:sender:) sender:self];
    if (target) {
       [target selectDetailItem:detailItem sender:sender];
    }
}

@end
