//
//  NWPushListVC.m
//  NWPusher
//
//  Created by IOS on 1/23/17.
//  Copyright © 2017 noodlewerk. All rights reserved.
//

#import "NWPushListVC.h"
#import "NWPushItem.h"
#import "NWDataProvider.h"
#import "NWStatusCellView.h"

@interface NWPushListVC ()

//@property NSMutableArray<NWPushItem *> *pushItems;

@end

@implementation NWPushListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    _pushItems = [[NSMutableArray alloc] initWithArray:[[NWDataProvider sharedInstance] loadPushItems]];
    [self.tableView reloadData];
    [self.tableView setDoubleAction:@selector(tableViewDoubleAction)];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark - TableView
- (IBAction)tableViewClickAction:(id)sender {
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    NWPushItem *pushItem = (NWPushItem *)[[NWDataProvider sharedInstance] pushItems][row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showItem" object:nil
                                                      userInfo:@{@"itemID" : pushItem.iid}];
    return YES;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NWStatusCellView *cell = [tableView makeViewWithIdentifier:@"NWStatusCellViewID" owner:nil];
    
    if (cell) {
        [cell setDataWithItem:[[NWDataProvider sharedInstance] pushItems][row]];
    }
    
    return cell;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[NWDataProvider sharedInstance] pushItems].count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 40;
}

#pragma mark - Actions

- (void)tableViewDoubleAction {
    NSLog(@"double row: %ld", (long)_tableView.clickedRow);
    
}

- (IBAction)plusButtonAction:(id)sender {
    NWPushItem *newItem = [[NWPushItem alloc] initWithTitle:@"New item" andBody:@""];
    [[NWDataProvider sharedInstance] addPushItem:newItem];
    [self.tableView reloadData];
}

@end
