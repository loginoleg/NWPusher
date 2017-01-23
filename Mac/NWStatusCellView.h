//
//  NWStatusCellView.h
//  NWPusher
//
//  Created by IOS on 1/23/17.
//  Copyright © 2017 noodlewerk. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NWPushItem.h"
#import "NWDataProvider.h"

@interface NWStatusCellView : NSTableCellView <NSTextFieldDelegate>

- (void)setDataWithItem:(NWPushItem *)item;

@end
