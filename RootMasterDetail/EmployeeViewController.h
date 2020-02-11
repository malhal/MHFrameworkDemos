//
//  EmployeeViewController.h
//  RootMasterDetail
//
//  Created by Malcolm Hall on 21/01/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import "BasicSplit+CoreDataModel.h"
//#import "SelectedItemController.h"

NS_ASSUME_NONNULL_BEGIN
//@protocol EmployeeViewControllerDelegate;

@interface EmployeeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (weak, nonatomic) id<EmployeeViewControllerDelegate> delegate;
//@property (strong, nonatomic) SelectedItemController *masterDetailContext;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *deleteBarButtonItem;
@property (strong, nonatomic) Employee *detailItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteVenueButton;



@end

//@protocol EmployeeViewControllerDelegate
//- (void)detailViewControllerDidTapDelete:(EmployeeViewController *)detailViewController;
//@end

NS_ASSUME_NONNULL_END
