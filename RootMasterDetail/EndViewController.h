//
//  EndViewController.h
//  BasicSplit
//
//  Created by Malcolm Hall on 04/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <MCoreData/MCoreData.h>
#import "BasicSplit+CoreDataModel.h"
//#import "SelectedItemController.h"
//#import "MasterTableViewController.h"

@protocol EndViewControllerDelegate;

@interface EndViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) id<EndViewControllerDelegate> delegate;
//@property (strong, nonatomic) SelectedItemController *masterDetailContext;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *deleteBarButtonItem;
@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteVenueButton;

@end

@protocol EndViewControllerDelegate <NSObject>

- (void)detailViewControllerDidTapDelete:(EndViewController *)detailViewController;
//- (void)observerAddedByEndViewController:(EndViewController *)detailViewController;

@end
