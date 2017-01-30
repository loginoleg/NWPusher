//
//  NWStatusCellView.m
//  NWPusher
//
//  Created by IOS on 1/23/17.
//  Copyright © 2017 noodlewerk. All rights reserved.
//

#import "NWStatusCellView.h"


@interface NWStatusCellView () 

@property NWPushItem *pushItem;
@property (weak) IBOutlet NSTextField *subTitleTF;
@property (weak) IBOutlet NSTextField *titleTF;

@end

@implementation NWStatusCellView

- (void)controlTextDidEndEditing:(NSNotification *)obj {
//    [[NWDataProvider sharedInstance] changeTitle:self.titleTF.stringValue forItemID:_pushItem.iid];
    NSLog(@"controlTextDidEndEditing: %@:%@", self.titleTF.stringValue, _pushItem.iid);
    
}

- (void)setDataWithItem:(NWPushItem *)item {
    self.pushItem = item;
    self.titleTF.stringValue = item.title;
    self.subTitleTF.stringValue = item.body;
}

@end
