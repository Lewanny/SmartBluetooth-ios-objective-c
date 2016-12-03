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

#import "SCUBluetoothDeviceManager.h"

@interface SCUBluetoothDeviceManager () <CBCentralManagerDelegate> {
    
}

@property(nonatomic, strong)CBCentralManager *centralManager;
@property(nonatomic, assign)BOOL isSupportBle;
@property(nonatomic, assign)BOOL isBluetoothEnable;

@property(nonatomic, assign)BOOL isScaning;

@property(nonatomic, strong)NSDictionary *centralManagerOptionDic;
@property(nonatomic, strong)NSMutableArray *deviceListArray;

@end

@implementation SCUBluetoothDeviceManager

+ (SCUBluetoothDeviceManager*)sharedInstance
{
    static dispatch_once_t pred;
    static SCUBluetoothDeviceManager *_sharedInstance = nil;
    dispatch_once(&pred, ^{
        _sharedInstance = [[SCUBluetoothDeviceManager alloc] init];
        
        // Initialize CBCentralManager
        _sharedInstance.centralManager = [[CBCentralManager alloc] initWithDelegate:_sharedInstance queue:nil];
        // Default bluetooth supported
        _sharedInstance.isSupportBle = YES;
        // Default bluetooth close
        _sharedInstance.isBluetoothEnable = NO;
        
        // Default scaning close
        _sharedInstance.isScaning = NO;
        
        _sharedInstance.centralManagerOptionDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:false], CBCentralManagerScanOptionAllowDuplicatesKey, nil];
        
        _sharedInstance.deviceListArray = [NSMutableArray array];
    });
    
    return _sharedInstance;
}

- (void)setSCUBluetoothDeviceManagerDelegate:(id<SCUBluetoothDeviceManagerDelegate>)delegate
{
    self.delegate = delegate;
}

- (BOOL)isSupported
{
    return self.isSupportBle;
}

- (BOOL)isEnabled
{
    return self.isBluetoothEnable;
}

- (BOOL)isMACAddressValid:(NSString *)address
{
    if (address == nil || address.length != 17) {
        return NO;
    }
    for (int i = 0; i < 17; i++) {
        char c = [address characterAtIndex:i];
        switch (i % 3) {
            case 0:
            case 1:
                if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'F')) {
                    // hex character, OK
                    break;
                }
                return NO;
            case 2:
                if (c == ':') {
                    break;  // OK
                }
                return NO;
        }
    }
    return YES;
}


- (BOOL)isScanningWithType:(SCUBluetoothDeviceManagerBluetoothType)type
{
    return self.isScaning;
}


- (BOOL)isConnectedWithPeripheral:(CBPeripheral *)peripheral profile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)profile
{
    return NO;
}


/**
 Note: You can only scan for Bluetooth LE devices or scan for Classic Bluetooth devices, as described in Bluetooth. You cannot scan for both Bluetooth LE and classic devices at the same time.
 
 @param type Bluetooth Classic or BLE
 */
- (void)startScanningWithType:(SCUBluetoothDeviceManagerBluetoothType)type
{
    [self.centralManager scanForPeripheralsWithServices:nil options:self.centralManagerOptionDic];
    self.isScaning = YES;
}


/**
 Note: You can only scan for Bluetooth LE devices or scan for Classic Bluetooth devices, as described in Bluetooth. You cannot scan for both Bluetooth LE and classic devices at the same time.
 
 @param type Bluetooth Classic or BLE
 */
- (void)stopScanningWithType:(SCUBluetoothDeviceManagerBluetoothType)type
{
    [self.centralManager stopScan];
    self.isScaning = NO;
}

- (void)turnOn
{
}

- (void)turnOff
{
}

- (void)connectWithPeripheral:(CBPeripheral *)peripheral profile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)profile
{
    [self.centralManager connectPeripheral:peripheral options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
}

- (void)disConnectWithPeripheral:(CBPeripheral *)peripheral profile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)profile
{
    [self.centralManager cancelPeripheralConnection:peripheral];
}

#pragma mark - CBCentralManagerDelegate方法
// Discover bluetooth device
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (![self.deviceListArray containsObject:peripheral]) {
        [self.deviceListArray addObject:peripheral];

        NSLog(@"发现设备: %@", peripheral);
        NSLog(@"发现设备信息: %@", advertisementData);
        
        if ([self.delegate respondsToSelector:@selector(bluetoothDeviceDidDiscoverBluetoothDevice:advertisementData:)]) {
            [self.delegate bluetoothDeviceDidDiscoverBluetoothDevice:peripheral advertisementData:advertisementData];
        }
    }
}


// Connecte a bluetooth device successfully
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Connected to %@ successfully", peripheral.name);
}


// Connecte a bluetooth device failed
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Failed to connect to %@. (%@)", peripheral, [error localizedDescription]);
}

// Disconnecte a bluetooth device 
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    
    NSLog(@"Disconnecte to %@. (%@)", peripheral, [error localizedDescription]);
}


// Listening change of bluetooth state
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
            // PoweredOff
        case CBManagerStatePoweredOff:
            NSLog(@"PoweredOff");
            self.isBluetoothEnable = NO;
            break;
            
            // PoweredOn
        case CBManagerStatePoweredOn:
            NSLog(@"PoweredOn");
            self.isBluetoothEnable = YES;
            break;
            
            // Resetting
        case CBManagerStateResetting:
            break;
            
            // Unsupported
        case CBManagerStateUnsupported:
            NSLog(@"Unsupported");
            self.isSupportBle = NO;
            break;
            
            // Unauthorized
        case CBManagerStateUnauthorized:
            break;
            
            // Unknown state
        case CBManagerStateUnknown:
            break;
        default:
            break;
    }
}

@end
