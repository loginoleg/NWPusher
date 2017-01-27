//
//  NWPushItem.m
//  NWPusher
//
//  Created by IOS on 1/23/17.
//  Copyright © 2017 noodlewerk. All rights reserved.
//

#import "NWPushItem.h"

@implementation NWPushItem

- (instancetype)initWithTitle:(NSString *) title andBody:(NSString *)body {
    self = [super init];
    if (self) {
        self.title = title;
        self.body = body;
        self.iid = @(arc4random() % 10000);
        
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.body = [aDecoder decodeObjectForKey:@"body"];
        self.iid = [aDecoder decodeObjectForKey:@"iid"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.body forKey:@"body"];
    [coder encodeObject:self.iid forKey:@"iid"];
}

@end
