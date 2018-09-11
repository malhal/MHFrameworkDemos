//
//  DemoCell.m
//  MUIDemo
//
//  Created by Malcolm Hall on 19/01/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "DemoCell.h"

@implementation DemoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
  //  UITableView *tableView = self.mui_tableView;
    
    NSLog(@"Test");
    // Configure the view for the selected state
}

@end
