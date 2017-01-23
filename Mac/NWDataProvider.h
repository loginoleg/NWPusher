//
//  NWDataProvider.h
//  NWPusher
//
//  Created by IOS on 1/23/17.
//  Copyright © 2017 noodlewerk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWPushItem.h"

@interface NWDataProvider : NSObject

+ (NWDataProvider *)sharedInstance;
//- (NSArray<NWPushItem *> *)loadPushItems;
- (NSArray<NWPushItem *> *)pushItems;
- (void)storePushItems: (NSArray<NWPushItem *> *)items;
- (void)changeTitle:(NSString *) title forItemID: (NSNumber *)itemID;
- (void)addPushItem:(NWPushItem *)item;
@end
