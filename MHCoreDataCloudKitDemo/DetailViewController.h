//
//  DetailViewController.h
//  CoreDataCloudKitDemo2
//
//  Created by Malcolm Hall on 09/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <MCoreData/MCoreData.h>
#import "MHCoreDataCloudKitDemo+CoreDataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Post *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, strong) NSPersistentCloudKitContainer *persistentContainer;
@property (strong, nonatomic) UIBarButtonItem *trashButton;
@property (strong, nonatomic) MCDSelectionController *selectionController;

@end

