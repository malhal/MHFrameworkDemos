//
//  DetailViewController.m
//  CoreDataCloudKitDemo2
//
//  Created by Malcolm Hall on 09/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) UIBarButtonItem *nextButtonItem;
@property (strong, nonatomic) UIBarButtonItem *previousButtonItem;

@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = self.detailItem.title;
        // shouldnt modify parent state
        self.navigationController.mui_detailModelIdentifier = self.detailItem.objectID.URIRepresentation.absoluteString; // since not shown yet doesn't fire any events
        self.selectionController.delegate = self;
        self.nextButtonItem.enabled = self.selectionController.canSelectNext;
        self.previousButtonItem.enabled = self.selectionController.canSelectPrevious;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configureView];
    //[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(currentDetailModelIdentifierDidChangeNotification:) name:UIViewControllerCurrentDetailModelIdentifierDidChangeNotification object:self.splitViewController];
}

- (void)selectionController:(MCDSelectionController *)selectionController didSelectObject:(id)object{
    NSLog(@"fefee");
    [self performSegueWithIdentifier:@"replace" sender:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    id i = self.mui_detailNavigationController;
    self.trashButton = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delete:)];
    //self.navigationItem.rightBarButtonItems = @[self.mui_detailNavigationController.nextDetailButtonItem, self.mui_detailNavigationController.previousDetailButtonItem, self.trashButton];
    self.nextButtonItem = [UIBarButtonItem.alloc initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self.selectionController action:@selector(selectNext:)];
    self.previousButtonItem = [UIBarButtonItem.alloc initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:self.selectionController action:@selector(selectPrevious:)];
    self.navigationItem.rightBarButtonItems = @[self.nextButtonItem, self.previousButtonItem];
}

- (void)next:(id)sender{
    [self.selectionController selectNext:sender];
}

- (void)delete:(id)sender{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    [context deleteObject:self.detailItem];

    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(Post *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailViewController *dvc = segue.destinationViewController;
  //  NSString *identifier = self.mui_splitViewController.mui_currentDetailModelIdentifier;
  //  NSURL *objectURI = [NSURL URLWithString:identifier];
    //Post *object = (Post *)[self.persistentContainer.viewContext mcd_objectWithURI:objectURI];
    Post *object = self.selectionController.selectedObject;
    dvc.detailItem = object;
    dvc.persistentContainer = self.persistentContainer;
    dvc.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    dvc.navigationItem.leftItemsSupplementBackButton = YES;
    dvc.selectionController = self.selectionController;
    
}

@end
