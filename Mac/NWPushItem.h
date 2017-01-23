//
//  NWPushItem.h
//  NWPusher
//
//  Created by IOS on 1/23/17.
//  Copyright © 2017 noodlewerk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWPushItem : NSObject <NSCoding>

@property NSNumber *iid;
@property NSString *title;
@property NSString *body;

- (instancetype)initWithTitle:(NSString *) title andBody:(NSString *)body;

@end
