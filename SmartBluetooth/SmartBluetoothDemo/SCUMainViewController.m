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

#import "SCUMainViewController.h"
#import "SCUBluetoothDeviceManager.h"
#import "SCUPeripheralDetailController.h"

#define kCellDevice @"cellDeviceIdentity"
@interface SCUMainViewController () <SCUBluetoothDeviceManagerDelegate, UITableViewDelegate, UITableViewDataSource>{
    CBPeripheral *connectPeripheral;
}

@property(nonatomic, strong) SCUBluetoothDeviceManager *bluetoothDeviceManager;
@property (weak, nonatomic) IBOutlet UITableView *deviceTabelView;

@property (nonatomic, strong)NSMutableArray *deviceListArr;

@end

@implementation SCUMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.deviceListArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.deviceTabelView.delegate = self;
    self.deviceTabelView.dataSource = self;
    [self.deviceTabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellDevice];
    
    [self bluetoothMethod];
    
    BOOL macAdressAvalid = [self.bluetoothDeviceManager isMACAddressValid:@"C9:A2:D3:F0:B9:E4"];
    DLog(@"Is macAdressAvailable:%d", macAdressAvalid);
    
    [self.bluetoothDeviceManager setSCUBluetoothDeviceManagerDelegate:self];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deviceListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellDevice forIndexPath:indexPath];
    CBPeripheral *peripheral = [self.deviceListArr objectAtIndex:indexPath.row];
    if (peripheral.name != nil) {
        cell.textLabel.text = peripheral.name;
    } else {
        cell.textLabel.text = @"<Null>";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral *peripheral = [self.deviceListArr objectAtIndex:indexPath.row];
    [self.bluetoothDeviceManager connectWithPeripheral:peripheral bluetoothType:SCUBluetoothDeviceManagerBluetoothTypeClassic bluetoothDeviceProfile:SCUBluetoothDeviceManagerBluetoothDeviceProfileUnknown];

}


#pragma mark - SCUBluetoothDeviceManagerDelegate Method
- (void)bluetoothDeviceBluetoothScanningBLEDidReceiveWithPeripheral:(CBPeripheral *)peripheral RSSI:(NSNumber *)rssi advertisementData:(NSDictionary *)advertisementData{
    
    [self.deviceListArr addObject:peripheral];
    [self.deviceTabelView reloadData];
}

// connect
- (void)bluetoothDeviceBluetoothConnectionStatusDidChangeWithPeripheral:(CBPeripheral *)peripheral bluetoothType:(SCUBluetoothDeviceManagerBluetoothType)bluetoothType bluetoothDeviceProfile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)bluetoothDeviceProfile bluetoothConnectionStatus:(SCUBluetoothDeviceManagerBluetoothConnectionStatus)bluetoothConnectionStatus{
    
    if (SCUBluetoothDeviceManagerBluetoothConnectionStatusConnected == bluetoothConnectionStatus) {
        SCUPeripheralDetailController *peripheralDetailVC = [[SCUPeripheralDetailController alloc] init];
        peripheralDetailVC.peripheral = peripheral;
        [self.navigationController pushViewController:peripheralDetailVC animated:YES];
    }
    connectPeripheral = peripheral;
}

- (IBAction)scanDeviceMethod:(id)sender {
    [self.deviceListArr removeAllObjects];
    [self.deviceTabelView reloadData];
    [self.bluetoothDeviceManager startScanningWithType:SCUBluetoothDeviceManagerBluetoothTypeClassic];
}

- (IBAction)stopScanDeviceMethod:(id)sender {
    [self.bluetoothDeviceManager stopScanningWithType:SCUBluetoothDeviceManagerBluetoothTypeClassic];
}

- (IBAction)disconnectDeviceMethod:(UIButton *)sender {
    if (!connectPeripheral) {
        return ;
    }
    [self.bluetoothDeviceManager disconnectWithPeripheral:connectPeripheral bluetoothType:SCUBluetoothDeviceManagerBluetoothTypeClassic bluetoothDeviceProfile:SCUBluetoothDeviceManagerBluetoothDeviceProfileUnknown];
}



- (void)bluetoothMethod {
    self.bluetoothDeviceManager = [SCUBluetoothDeviceManager sharedInstance];
    [self.bluetoothDeviceManager setSCUBluetoothDeviceManagerDelegate:self];
    
    dispatch_queue_t queue= dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), queue, ^{
        DLog(@"Is support Bluetooth: %d", [[SCUBluetoothDeviceManager sharedInstance] isSupported]);
        DLog(@"Is Bluetooth open: %d", [[SCUBluetoothDeviceManager sharedInstance] isEnabled]);
        
        [self.bluetoothDeviceManager startScanningWithType:SCUBluetoothDeviceManagerBluetoothTypeClassic];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
