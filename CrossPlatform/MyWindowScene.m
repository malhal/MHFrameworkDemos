//
//  MyScene.m
//  CrossPlatform
//
//  Created by Malcolm Hall on 21/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MyWindowScene.h"

@implementation MyWindowScene

- (UIResponder *)nextResponder{
    return self.delegate;
}

@end
