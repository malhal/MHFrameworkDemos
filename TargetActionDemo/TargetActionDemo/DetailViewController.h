//
//  DetailViewController.h
//  TargetActionDemo
//
//  Created by Malcolm Hall on 15/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCoreData/MCoreData.h>

#import "TargetActionDemo+CoreDataModel.h"

@interface DetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) Event *detailItem;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *trashButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *updateButtonItem;

@end

