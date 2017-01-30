//
//  NWDataProvider.m
//  NWPusher
//
//  Created by IOS on 1/23/17.
//  Copyright © 2017 noodlewerk. All rights reserved.
//

#import "NWDataProvider.h"

static NSString *kPushItemsKey = @"kPushItemsKey";

@implementation NWDataProvider {
    NSInteger _selectedRow;
}

+ (NWDataProvider *)sharedInstance {
    //  Static local predicate must be initialized to 0
    static NWDataProvider *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NWDataProvider alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}


- (NSArray<NWPushItem *> *)pushItems {
    return [self loadPushItems];
}

- (NSArray<NWPushItem *> *)loadPushItems {

    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kPushItemsKey];
    NSArray *pushItems = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    for (NWPushItem *item in pushItems) {
        NSLog(@"load item body: %@", item.body);
    }
    return pushItems;
}

- (void)storePushItems:(NSArray<NWPushItem *> *)items {
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:items];
    [currentDefaults setObject:data forKey:kPushItemsKey];
    
    for (NWPushItem *item in items) {
        NSLog(@"store item body: %@", item.body);
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)changeTitle:(NSString *) title forItemID: (NSNumber *)itemID {
    NSArray<NWPushItem *> *items = [self loadPushItems];
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    
    for (NWPushItem *item in items) {
        if ([item.iid integerValue] == [itemID integerValue]) {
            NWPushItem *changedItem = [[NWPushItem alloc] initWithTitle:title andBody:item.body];
            [newArray addObject:changedItem];
        } else {
            [newArray addObject:item];
        }
    }
    
    [self storePushItems:newArray];
}

- (void)changeBody:(NSString *)body forItemID:(NSNumber *)itemID {
    NSLog(@"[%@]body to save: %@", itemID, body);
    NSArray<NWPushItem *> *items = [self loadPushItems];
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    
    for (NWPushItem *item in items) {
        NSLog(@"%ld == %ld", [item.iid integerValue], [itemID integerValue]);
        if ([item.iid integerValue] == [itemID integerValue]) {
            NWPushItem *changedItem = [[NWPushItem alloc] initWithTitle:item.title andBody:body];
            [newArray addObject:changedItem];
        } else {
            [newArray addObject:item];
        }
    }
    
    [self storePushItems:newArray];
}


- (void)addPushItem:(NWPushItem *)item {
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:[self pushItems]];
    [newArray addObject:item];
    [[NWDataProvider sharedInstance] storePushItems:newArray];
}

- (NWPushItem *)pushItemByID:(NSUInteger)itemID {
    NSArray *items = [self loadPushItems];
    NWPushItem *returnItem;
    for (NWPushItem *item in items) {
        if ([item.iid integerValue] == itemID) {
            returnItem = item;
        }
    }
    
    return returnItem;
}

- (NWPushItem *)selectedPushItem {
    return self.pushItems[_selectedRow];
}
- (void)selectItemAtRow:(NSInteger)row {
    _selectedRow = row;
}

- (void)changeBodyForSelectedItem:(NSString *)newBody {
    self.pushItems[_selectedRow].body = newBody;
    [self storePushItems:self.pushItems];
}





@end
