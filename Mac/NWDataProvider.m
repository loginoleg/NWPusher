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
    NSMutableArray *_pushItems;
}

+ (NWDataProvider *)sharedInstance {
    static NWDataProvider *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NWDataProvider alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _pushItems = [[NSMutableArray alloc] initWithArray:[self loadPushItems]];
    }
    return self;
}

- (NSArray<NWPushItem *> *)pushItems {
    return _pushItems;
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

- (void)addPushItem:(NWPushItem *)item {
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:[self pushItems]];
    [newArray addObject:item];
    [[NWDataProvider sharedInstance] storePushItems:newArray];
}

- (NWPushItem *)selectedPushItem {
//    NSLog(@"get push item at row: %d", _selectedRow);
//    NSLog(@"push item:%@", _pushItems[_selectedRow]);
    return _pushItems[_selectedRow];
}

- (void)selectItemAtRow:(NSInteger)row {
    _selectedRow = row;
    NSLog(@"new selected row: %d", _selectedRow);
}

- (void)save {
    [self storePushItems:_pushItems];
}





@end
