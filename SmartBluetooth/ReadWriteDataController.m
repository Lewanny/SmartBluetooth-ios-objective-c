//
//  ReadWriteDataController.m
//  SmartBluetooth
//
//  Created by 李宏远 on 2016/12/22.
//  Copyright © 2016年 SmartCodeUnited. All rights reserved.
//

#import "ReadWriteDataController.h"

NSString *const kWriteHeaderCell = @"WriteHeaderCellIdentify";
NSString *const kWriteCell = @"kWriteCellIdentify";


@interface ReadWriteDataController () <UIAlertViewDelegate, SCUBluetoothDeviceManagerDelegate>

@property(nonatomic, strong)NSMutableArray *sendDataArr;
@property(nonatomic, strong)NSMutableArray *receivedDataArr;

@end

@implementation ReadWriteDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [self.charactristic.UUID UUIDString];
    [[SCUBluetoothDeviceManager sharedInstance] setSCUBluetoothDeviceManagerDelegate:self];
    
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:kWriteHeaderCell];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kWriteCell];
    
    self.sendDataArr = [NSMutableArray array];
    self.receivedDataArr = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kWriteHeaderCell];
    if(!headerView){
        headerView = [[UITableViewHeaderFooterView alloc] init];
    }
    
    switch (section) {
        case 0:
            headerView.textLabel.text = [NSString stringWithFormat:@"Service UUID:%@",@"aaa"];
            break;
        case 1:
            headerView.textLabel.text = [NSString stringWithFormat:@"Data Written"];
            break;
        case 2:
            headerView.textLabel.text = [NSString stringWithFormat:@"Data Received"];
            break;
        default:
            break;
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.sendDataArr.count;
            break;
        case 2:
            return self.receivedDataArr.count;
            break;
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWriteCell forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"Write New Data"];
            cell.textLabel.textColor = [UIColor blueColor];
            break;
        case 1:
            cell.textLabel.text = [self.sendDataArr objectAtIndex:indexPath.row];;
            break;
        case 2:
            cell.textLabel.text = [self.receivedDataArr objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Send data to device" message:[NSString stringWithFormat:@"Charactristic UUID:%@",[self.charactristic.UUID UUIDString]] delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView addButtonWithTitle:@"send"];
            [alertView show];
        }
            break;
        case 1:
//            cell.textLabel.text = [NSString stringWithFormat:@"Charactristic UUID:%@",@"a"];
            break;
        case 2:
//            cell.textLabel.text = [NSString stringWithFormat:@"Charactristic UUID:%@",@"a"];
            break;
        default:
            break;
    }
    
}



#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        DLog(@"alert text = %@",textField.text);
        [self sendDataWithDataStr:textField.text];
    }
}


- (void)sendDataWithDataStr:(NSString *)dataStr {
    NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    [self.peripheral writeValue:data forCharacteristic:self.charactristic type:CBCharacteristicWriteWithResponse];
    
    [self.sendDataArr addObject:dataStr];
    [self.tableView reloadData];
}


#pragma mark - BluetoothDelegate
- (void)bluetoothDeviceDidReceivedData:(NSData *)data {
    uint8_t *dataByte = (uint8_t *)[data bytes];
    NSMutableString *temStr = [[NSMutableString alloc] init];
    for (int i = 0; i < data.length; i++) {
        [temStr appendFormat:@"%02x ",dataByte[i]];
    }
    DLog(@"update value:%@",temStr);
    NSString *receivedStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self.receivedDataArr addObject:receivedStr];
    [self.tableView reloadData];
}


@end
