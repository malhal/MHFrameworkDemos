//
//  Event+CoreDataClass.m
//  MUIMasterDetail
//
//  Created by Malcolm Hall on 17/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//
//

#import "Event.h"
#import "Folder.h"

@implementation Event

- (void)setFolder:(Folder *)folder{
    self.parent = folder;
}

- (Folder *)folder{
    return (Folder *)self.parent;
}

@end
