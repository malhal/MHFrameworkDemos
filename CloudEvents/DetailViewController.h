//
//  DetailViewController.h
//  CloudEvents
//
//  Created by Malcolm Hall on 04/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import "CloudEvents+CoreDataModel.h"
#import <MCoreData/MCoreData.h>

//@protocol DetailViewControllerDelegate;

extern NSString * const DetailViewControllerStateRestorationDetailItemKey;

@interface DetailViewController : UIViewController <MUIDetail>

//@property (weak, nonatomic) 
@property (strong, nonatomic) Event *detailItem;
//@property (strong, nonatomic) NSManagedObjectID *detailItemObjectID;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

//@property (weak, nonatomic) id<DetailViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *deleteFirstCityButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *deleteVenueButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *updateButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *trashButton;


@end

//@protocol DetailViewControllerDelegate <NSObject>
//
//- (void)detailViewControllerDidSave:(DetailViewController *)vc;
//
//@end
