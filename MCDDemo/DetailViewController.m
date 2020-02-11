//
//  DetailViewController.m
//  MCoreDataDemo
//
//  Created by Malcolm Hall on 15/06/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "DetailViewController.h"
//#import "AppDelegate.h"

//static NSString * const DetailViewControllerDetailObjectKey = @"DetailObject";

NSString * const DetailViewControllerDetailObjectKey = @"DetailViewControllerDetailObjectKey";

@interface DetailViewController ()<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
//@property (strong, nonatomic) Event *event;

@end

@implementation DetailViewController
@synthesize collapseControllerForDetail = _collapseControllerForDetail;

//@synthesize object = _object;

//+ (nullable UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder{
//    return nil;
//}

- (void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"awakeFromNib %@", self);
   // self.restorationClass = self.class;
}

//- (void)willMoveToParentViewController:(UIViewController *)parent{
//    NSLog(@"%@", parent);
//}
//
- (void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
    id i = parent.parentViewController;
    NSLog(@"%@", parent.navigationController);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    if(self.splitViewController.isCollapsed && self.navigationController.isMovingFromParentViewController){
//        self.object = nil;
//    }
//    if (!self.parentViewController.parentViewController){ //} || [self.parentViewController isMovingFromParentViewController])
//        NSLog(@"View controller was popped");
//    }
//    else
//    {
//        NSLog(@"New view controller was pushed");
//    }
    
//    UIViewController *u = self.presentingViewController;
//    UIViewController *pvc = self.parentViewController;
//    if(!pvc){
//        // when going back in landscape or portrait.
//        self.viewedObject = nil;
//    }
//    else if(!pvc.parentViewController){
//        // doesn't happen
//        self.viewedObject = nil;
//    }
}


//- (NSManagedObjectContext *)managedObjectContext{
//    if(!_managedObjectContext){
//        _managedObjectContext = self.object.managedObjectContext;
//    }
//    return _managedObjectContext;
//}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [super encodeRestorableStateWithCoder:coder];
    NSManagedObjectID *objectID = self.event.objectID;
    if(objectID){
        [coder encodeObject:objectID.URIRepresentation forKey:DetailViewControllerDetailObjectKey];
    }
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    NSURL *objectURI = [coder decodeObjectForKey:DetailViewControllerDetailObjectKey];
    if(objectURI){
        NSManagedObject *object = [self.managedObjectContext mcd_existingObjectWithURI:objectURI error:nil];
        if(object){
           // self.secondaryItem = object; // maybe could pop which solves the should it be created in first place issue
        }
    }
}

#pragma mark - Managing the detail item

- (void)configureView {
    //id detailItem = self.secondaryItem;
    self.detailDescriptionLabel.text = [[self.event valueForKey:@"timestamp"] description];

}

- (void)setEvent:(Event *)event{
    if (_event == event) {
        return;
    }
    _event = event;
    // Update the view.
    if(!self.isViewLoaded){
        return;
    }
    [self configureView];
//    if(!event){
//        [self performSegueWithIdentifier:@"unwind" sender:self];
//    }
//    else{
//        [self.navigationController popToRootViewControllerAnimated:NO];  // test in portrait
//    }
}

//
//- (void)configureView {
//    // Update the user interface for the detail item.
//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timestamp"] description];
//    }
//}

// splitview is nil in view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //id i = self.splitViewController;

    NSLog(@"viewDidLoad %@", self);
    // Do any additional setup after loading the view, typically from a nib.
    //self.event = self.splitViewController.masterDetailContext.detailItem;
    [self configureView];
   // [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(detailItemDidChange:) name:MUICollapseControllerDetailItemDidChange object:self.splitViewController.masterDetailContext];
    
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.navigationItem.leftItemsSupplementBackButton = YES;
   // [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(managedObjectContextDidChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.managedObjectContext];
}

//- (void)detailItemDidChange:(NSNotification *)notification{
//    id detailItem = notification.userInfo[@"DetailItem"];
//    self.event = detailItem; // when seperated this calls with same detail item as we already get but is ignored by the setter.
//}

// need to listen for changes in case the folder view controller no longer exists.
// in case of delete from folder list it will have already changed the detail item.
//- (void)managedObjectContextDidChange:(NSNotification *)notification{
//    NSSet *deletedObjects = notification.userInfo[NSDeletedObjectsKey];
//    if([deletedObjects containsObject:self.event]){
//        self.event = nil;
//    }
//}

- (IBAction)buttonTapped:(id)sender{
//    UIBarButtonItem *item = (UIBarButtonItem *)sender;
//    //item.enabled = NO;
//
//    NSManagedObject *detailItem = self.secondaryItem;
//    [self.managedObjectContext deleteObject:detailItem];
//    [self.managedObjectContext save:nil];
    [self showViewController:UITableViewController.alloc.init sender:self];
}

- (id)detailItem{
    return self.event;
}

@end
