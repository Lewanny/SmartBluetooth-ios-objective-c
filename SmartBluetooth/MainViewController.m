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

#import "MainViewController.h"
#import "SCUBluetoothDeviceManager.h"

#define kCellDevice @"cellDeviceIdentity"
@interface MainViewController () <SCUBluetoothDeviceManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) SCUBluetoothDeviceManager *bluetoothDeviceManager;
@property (weak, nonatomic) IBOutlet UITableView *deviceTabelView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.deviceTabelView.delegate = self;
    self.deviceTabelView.dataSource = self;
    [self.deviceTabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellDevice];
    [self bluetoothMethod];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellDevice forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (IBAction)scanDeviceMethod:(id)sender {
    [self.bluetoothDeviceManager startScanningWithType:SCUBluetoothDeviceManagerBluetoothTypeClassic];
}

- (IBAction)stopScanDeviceMethod:(id)sender {
    [self.bluetoothDeviceManager stopScanningWithType:SCUBluetoothDeviceManagerBluetoothTypeClassic];
}



- (void)bluetoothMethod {
    self.bluetoothDeviceManager = [SCUBluetoothDeviceManager sharedInstance];
    [self.bluetoothDeviceManager setSCUBluetoothDeviceManagerDelegate:self];
    
    dispatch_queue_t queue= dispatch_get_main_queue();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"Is support Bluetooth: %d", [[SCUBluetoothDeviceManager sharedInstance] isSupported]);
        NSLog(@"Is Bluetooth open: %d", [[SCUBluetoothDeviceManager sharedInstance] isEnabled]);
        
        
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
