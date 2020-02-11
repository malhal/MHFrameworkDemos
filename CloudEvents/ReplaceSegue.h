//
//  ReplaceSegue.h
//  AnotherSplitTest
//
//  Created by Malcolm Hall on 23/04/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DetailViewController;

@interface ReplaceSegue : UIStoryboardSegue

//@property (strong, nonatomic) DetailViewController *trashedDetailViewController;
//@property (assign, nonatomic) BOOL trashAnimation;

@end

@interface UIView ()

+ (void)setAnimationPosition:(CGPoint)p;

@end

@interface UINavigationController ()
- (UINavigationController *)_outermostNavigationController;
@end

NS_ASSUME_NONNULL_END
