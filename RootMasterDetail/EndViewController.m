//
//  EndViewController.m
//  BasicSplit
//
//  Created by Malcolm Hall on 04/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//
// need to look for it being deleted.

#import "EndViewController.h"
//#import "SelectedItemController.h"
#import "MiddleNavigationController.h"
#import "EndNavigationController.h";
#import "OuterSplitViewController.h"

//NSString * const kDetailItemKey = @"DetailItem";
static NSString * kManagedObjectContextStateKey = @"ManagedObjectContext";
static NSString * kDetailItemStateKey = @"DetailItem";

@interface EndViewController ()

//@property (strong, nonatomic) Event *detailItem;
@end

@implementation EndViewController
//@synthesize selectedItemControllerForDetail = _selectedItemControllerForDetail;

//- (void)setSelectedItemControllerForDetail:(SelectedItemController *)selectedItemControllerForDetail{
//    if(selectedItemControllerForDetail == _selectedItemControllerForDetail){
//        return;
//    }
//    _selectedItemControllerForDetail = selectedItemControllerForDetail;
//    if(!selectedItemControllerForDetail){
//        return;
//    }
//    self.navigationItem.leftBarButtonItem = selectedItemControllerForDetail.splitViewController.displayModeButtonItem; // looks like back button when app started in ipad portrait.
//    self.detailItem = selectedItemControllerForDetail.detailItem;
//}

//- (UIViewController *)targetViewControllerForAction:(SEL)action sender:(id)sender{
//    //NSLog(@"");
//    id i = self.detailNavigationController.selectedItemController.splitViewController;
//    return self.detailNavigationController.selectedItemController.splitViewController; // OuterSplitViewController
//}

- (id)mui_containedDetailItem{
    return self.detailItem;
}

- (void)configureBars{
    if (self.detailItem) {
        self.navigationItem.title = self.detailItem.name;
        self.deleteBarButtonItem.enabled = YES;
        self.deleteVenueButton.enabled  = YES;
    }
}

//- (void)detailNavigationControllerDidSetSelectedItemController:(SelectedItemController *)selectedItemController{
//    self.navigationItem.leftBarButtonItem = selectedItemController.splitViewController.displayModeButtonItem;
//}



- (void)afterAnimationStops{
    //[self.navigationController._outermostNavigationController popViewControllerAnimated:YES];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
//    UISplitViewController *splitViewController = self.splitViewController;
    //SelectedItemController *previousSelectedItemController = splitViewController.selectedItemController;
//    if(splitViewController){
//        SelectedItemController *selectedItemController = [SelectedItemController.alloc initWithSplitViewController:splitViewController detailViewController:self];
//
//    }
//    if(previousSelectedItemController){
//        selectedItemController.detailNavigationController = previousSelectedItemController.detailNavigationController;
//        self.selectedEvent = previousSelectedItemController.detailNavigationController.detailItem;
//    }else{
    //selectedItemController.detailNavigationController = splitViewController.viewControllers.lastObject;
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(detailNavigationControllerDetailItemDidChange:) name:MiddleNavigationControllerDetailItemDidChange object:self.detailNavigationController];
    // Do any additional setup after loading the view, typically from a nib.
    //[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(managedObjectContextDidChange:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.managedObjectContext];
    
 //   self.detailItem = self.splitViewController.masterDetailContext.detailItem; // split might not be in hierarchy
   // [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(detailItemDidChange:) name:SelectedItemControllerDetailItemDidChange object:self.splitViewController.masterDetailContext];
    //self.detailNavigationController.detailItem = self.detailItem;
    
    //self.detailItem = self. ;//self.detailNavigationController.detailItem;
    [self configureView];
    
    id i = self.outerSplitViewController;
    self.navigationItem.leftBarButtonItem = self.outerSplitViewController.displayModeButtonItem;//[self mui_currentDisplayModeButtonItemWithSender:self];
    
   // [self performSelector:@selector(deleteButtonTapped:) withObject:nil afterDelay:5];
}

// called slow when pushed but instantly when in split.
- (void)viewDidAppear:(BOOL)animated{
//    BOOL b = self.navigationController.navigationBarHidden;
//    NSLog(@"");
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[NSNotificationCenter.defaultCenter removeObserver:self name:SelectedItemControllerDetailItemDidChange object:self.masterDetailContext];
  //  [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)configureView{
    if(self.detailItem){
        self.detailDescriptionLabel.text = self.detailItem.timestamp.description;
    }
}

//- (void)detailItemDidChange:(NSNotification *)notification{
//    id detailItem = notification.userInfo[@"DetailItem"];
//    self..detailItem= detailItem; // when seperated this calls with same detail item as we already get but is ignored by the setter.
//}

// need to listen for changes in case the folder view controller no longer exists.
// in case of delete from folder list it will have already changed the detail item.
//- (void)managedObjectContextDidChange:(NSNotification *)notification{
//    NSSet *deletedObjects = notification.userInfo[NSDeletedObjectsKey];
//    if([deletedObjects containsObject:self.detailItem]){
//        self..detailItem= nil;
//    }
//}

#pragma mark - Managing the detail item

//- (void)setSelectedItemController:(SelectedItemController *)masterDetailContext{
//    if(masterDetailContext == _masterDetailContext){
//        return;
//    }
//    _masterDetailContext = masterDetailContext;
//    self..detailItem= masterDetailContext.detailItem;
//}

- (void)setDetailItem:(Event *)detailItem{
    if (_detailItem == detailItem) {
        return;
    }
    _detailItem = detailItem;
    //EndNavigationController *nav = self.navigationController;
    //nav.detailItem = detailItem;
    //self.detailNavigationController.detailItem = detailItem;
    //self.detailNavigationController.selectedItem = detailItem;
    //MiddleNavigationController *dnc = (MiddleNavigationController *)self.navigationController;
//    dnc.detailItem = detailItem;
    [self configureBars];
    // Update the view.
    if(self.isViewLoaded){
        [self configureView];
    }
}

- (IBAction)deleteButtonTapped:(id)sender{
    /*
    UIView *snapshotView = [self.navigationController._outermostNavigationController.view snapshotViewAfterScreenUpdates:NO];

    UIView *view = [self.deleteBarButtonItem valueForKey:@"view"];
    CGRect rect = [view convertRect:view.frame toView:self.view.window];
    
    SelectedItemController *selectedItemController = self.selectedItemControllerForDetail;
    
    */
    NSManagedObjectContext *moc = self.detailItem.managedObjectContext;
    [moc deleteObject:self.detailItem];
    [moc save:nil];
    /*
    // new detail controller gets set.
    
    EndViewController *newEndViewController = selectedItemController.detailViewController;
    
    [newEndViewController.navigationController._outermostNavigationController.view addSubview:snapshotView];
    
    [CATransaction flush];
    [UIView beginAnimations:@"delete" context:NULL];
    //if(!detailController.detailItem){
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:)];
    //}
    //[UIView setAnimationTransition:103 forView:detailController.navigationController._outermostNavigationController.view cache:YES];
    [UIView setAnimationTransition:103 forView:newEndViewController.navigationController._outermostNavigationController.view cache:YES];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationPosition:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))];
    [snapshotView removeFromSuperview];
    [UIView commitAnimations];
    */
}

- (void)animationDidStop:(id)sender{
//    if(self.animationDidStop){
//        self.animationDidStop();
//    }
    NSLog(@"animationDidStop");
}

- (IBAction)deleteVenue:(id)sender {
    NSManagedObjectContext *moc = self.detailItem.managedObjectContext;
    [moc deleteObject:self.detailItem.venue];
    [moc save:nil];
}


#pragma mark - State Restoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject:self.detailItem.managedObjectContext forKey:kManagedObjectContextStateKey];
    [coder encodeObject:self.detailItem.objectID.URIRepresentation forKey:kDetailItemStateKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
    [super decodeRestorableStateWithCoder:coder];
    NSManagedObjectContext *context = [coder decodeObjectForKey:kManagedObjectContextStateKey];
    NSURL *objectURI = [coder decodeObjectForKey:kDetailItemStateKey];
    if(objectURI){
        NSManagedObject *object = [context mcd_existingObjectWithURI:objectURI error:nil];
        if(object){
            self.detailItem = object;
        }
    }
}


@end
