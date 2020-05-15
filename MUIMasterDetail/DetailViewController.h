//
//  DetailViewController.h
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 23/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import "MUIMasterDetail+CoreDataModel.h"
//#import "DetailItemSelecting.h"

@class PersistentContainer;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) PersistentContainer *persistentContainer;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButtonItem, *previousButtonItem, *trashButtonItem;
//@property (weak, nonatomic) id<MUIViewControllerSelecting> selection;
@property (strong, nonatomic) Event *detailItem;

@end

