//
//  PeripheralDetaiController.m
//  SmartBluetooth
//
//  Created by hao123 on 2016/12/14.
//  Copyright © 2016年 SmartCodeUnited. All rights reserved.
//

#import "PeripheralDetaiController.h"

NSString *const kCharacteristicCell = @"kCharacteristicCell";
NSString *const kServiceCell = @"kServiceCell";

@interface PeripheralDetaiController ()

@end

@implementation PeripheralDetaiController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _peripheral.name;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCharacteristicCell];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kServiceCell];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(discoverCharacteristicNotification:) name:@"DiscoverCharacteristicNotification" object:nil];
}

-(instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        self = [super initWithStyle:UITableViewStyleGrouped];
    }
    return self;
}

-(void)discoverCharacteristicNotification:(NSNotification*)noti{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [_peripheral.services count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CBService *service = [_peripheral.services objectAtIndex:section];
    return [service.characteristics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCharacteristicCell forIndexPath:indexPath];
    
    CBService *service = [_peripheral.services objectAtIndex:indexPath.section];
    CBCharacteristic *charactristic = [service.characteristics objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Charactristic UUID:%@",[charactristic.UUID UUIDString]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kServiceCell];
    if(!headerView){
        headerView = [[UITableViewHeaderFooterView alloc] init];
    }
    
    CBService *service = [_peripheral.services objectAtIndex:section];
    headerView.textLabel.text = [NSString stringWithFormat:@"Service UUID:%@",[service.UUID UUIDString]];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CBService *service = [_peripheral.services objectAtIndex:indexPath.section];
    CBCharacteristic *charactristic = [service.characteristics objectAtIndex:indexPath.row];
    
//    Byte common[4] = {6,6,6,6};
    uint8_t common[4] = {6,6,6,6};
    NSData *data = [NSData dataWithBytes:common length:4];
    [self.peripheral writeValue:data forCharacteristic:charactristic type:CBCharacteristicWriteWithResponse];
    
}

@end
