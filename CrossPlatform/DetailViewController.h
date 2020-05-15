//
//  DetailViewController.h
//  CrossPlatform
//
//  Created by Malcolm Hall on 19/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrossPlatform+CoreDataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

@interface UIViewController (DetailViewController)

- (void)selectDetailItem:(Event *)detailItem sender:(id)sender;

@end
