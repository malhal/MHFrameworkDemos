//
//  DetailViewController.h
//  BigSplit
//
//  Created by Malcolm Hall on 11/08/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import "BigSplit+CoreDataModel.h"

@interface DetailViewController : UIViewController <MUIDetailCollapsing>

@property (strong, nonatomic) Event *event;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) UIBarButtonItem *myItem;


@end

