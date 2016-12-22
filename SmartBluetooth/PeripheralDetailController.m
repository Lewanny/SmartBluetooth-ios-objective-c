/*
 * Copyright (C) 2016 SmartCodeUnited http://www.smartcodeunited.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "PeripheralDetailController.h"
#import "ReadWriteDataController.h"

typedef  void (^SendDataBlock)(NSData *data);

NSString *const kCharacteristicCell = @"kCharacteristicCell";
NSString *const kServiceCell = @"kServiceCell";

@interface PeripheralDetailController ()<UIAlertViewDelegate>{
    SendDataBlock sendDataBlock;
}

@end

@implementation PeripheralDetailController

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
    DLog(@"_peripheral.services.count = %lu",_peripheral.services.count);
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
  
    ReadWriteDataController *readWriteDataVC = [[ReadWriteDataController alloc] init];
    [self.navigationController pushViewController:readWriteDataVC animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Send data to device" message:[NSString stringWithFormat:@"Charactristic UUID:%@",[charactristic.UUID UUIDString]] delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
    
    if (charactristic.properties & CBCharacteristicPropertyWrite) {
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView addButtonWithTitle:@"send"];
    }
    else{
        alertView.title = @"Writing is not permitted";
    }
    
    [alertView show];
    
    __weak typeof(self) weakSelf = self;
    sendDataBlock = ^(NSData *data){
         [weakSelf.peripheral writeValue:data forCharacteristic:charactristic type:CBCharacteristicWriteWithResponse];
    };
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001f;
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        DLog(@"alert text = %@",textField.text);
        
        NSData *data = [textField.text dataUsingEncoding:NSUTF8StringEncoding];
        if (sendDataBlock) {
            sendDataBlock(data);
        }
    }
}
@end
