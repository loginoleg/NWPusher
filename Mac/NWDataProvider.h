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

//@property NSUInteger selectedPushID;

+ (NWDataProvider *)sharedInstance;
//- (NSArray<NWPushItem *> *)pushItems;
//- (void)storePushItems: (NSArray<NWPushItem *> *)items;
//- (void)changeTitle:(NSString *)title forItemID:(NSNumber *)itemID;
//- (void)changeBody:(NSString *)body forItemID:(NSNumber *)itemID;
//- (void)addPushItem:(NWPushItem *)item;
//- (NWPushItem *)pushItemByID:(NSUInteger)itemID;

- (NWPushItem *)selectedPushItem;
- (void)selectItemAtRow:(NSInteger)row;
- (void)changeBodyForSelectedItem:(NSString *)newBody;

@end
