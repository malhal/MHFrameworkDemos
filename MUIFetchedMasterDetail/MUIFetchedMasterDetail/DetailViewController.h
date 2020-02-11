//
//  DetailViewController.h
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 16/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import "MUIFetchedMasterDetail+CoreDataModel.h"

extern NSString * const DetailViewControllerStateRestorationDetailItemKey;

@protocol DetailViewControllerDelegate;

@interface DetailViewController : UIViewController 

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trashButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteVenueButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (assign, nonatomic) id<DetailViewControllerDelegate> delegate;
//@property (assign, nonatomic) BOOL isTrashed;

@end

@protocol DetailViewControllerDelegate <NSObject>

- (void)detailViewControllerDidDelete:(DetailViewController *)detailViewController;

@end
