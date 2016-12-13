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

@interface SCUBluetoothDeviceManager () <CBCentralManagerDelegate>
{
    
}

@property(nonatomic, strong)CBCentralManager *centralManager;

@property(nonatomic, assign)BOOL isSupportBle;
@property(nonatomic, assign)BOOL isBluetoothEnable;
@property(nonatomic, assign)BOOL isScanning;

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
        _sharedInstance.isScanning = NO;
        
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
    if ((address == nil) || (address.length != 17))
    {
        return NO;
    }
    
    for (int i = 0; i < 17; i++)
    {
        char c = [address characterAtIndex:i];
        switch (i % 3)
        {
            case 0:
            case 1:
                if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'F'))
                {
                    // hex character, OK
                    break;
                }
                return NO;
            case 2:
                if (c == ':')
                {
                    break;  // OK
                }
                return NO;
        }
    }
    
    return YES;
}


- (BOOL)isScanningWithType:(SCUBluetoothDeviceManagerBluetoothType)type
{
    
    return self.isScanning;
}


- (BOOL)isConnectedWithPeripheral:(CBPeripheral *)peripheral bluetoothType:(SCUBluetoothDeviceManagerBluetoothType)bluetoothType profile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)bluetoothDeviceProfile
{
    return NO;
}

- (void)startScanningWithType:(SCUBluetoothDeviceManagerBluetoothType)type
{
    [self.centralManager scanForPeripheralsWithServices:nil options:self.centralManagerOptionDic];
    self.isScanning = YES;
}

- (void)stopScanningWithType:(SCUBluetoothDeviceManagerBluetoothType)type
{
    [self.centralManager stopScan];
    self.isScanning = NO;
}

- (void)turnOn
{
}

- (void)turnOff
{
}

- (void)connectWithPeripheral:(CBPeripheral *)peripheral bluetoothType:(SCUBluetoothDeviceManagerBluetoothType)bluetoothType bluetoothDeviceProfile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)bluetoothDeviceProfile
{
    [self.centralManager connectPeripheral:peripheral options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
}

- (void)disconnectWithPeripheral:(CBPeripheral *)peripheral bluetoothType:(SCUBluetoothDeviceManagerBluetoothType)bluetoothType bluetoothDeviceProfile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)bluetoothDeviceProfile
{
    [self.centralManager cancelPeripheralConnection:peripheral];

}

#pragma mark - CBCentralManagerDelegate

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (![self.deviceListArray containsObject:peripheral])
    {
        [self.deviceListArray addObject:peripheral];
        
        if ([self.delegate respondsToSelector:@selector(bluetoothDeviceBluetoothScanningBLEDidReceiveWithPeripheral:RSSI:advertisementData:)])
        {
            [self.delegate bluetoothDeviceBluetoothScanningBLEDidReceiveWithPeripheral:peripheral RSSI:RSSI advertisementData:advertisementData];
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    if ([self.delegate respondsToSelector:@selector(bluetoothDeviceBluetoothConnectionStatusDidChangeWithPeripheral:bluetoothType:bluetoothDeviceProfile:bluetoothConnectionStatus:)])
    {
        [self.delegate bluetoothDeviceBluetoothConnectionStatusDidChangeWithPeripheral:peripheral bluetoothType:SCUBluetoothDeviceManagerBluetoothTypeBLE bluetoothDeviceProfile:SCUBluetoothDeviceManagerBluetoothDeviceProfileUnknown bluetoothConnectionStatus:SCUBluetoothDeviceManagerBluetoothConnectionStatusConnected];
    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(bluetoothDeviceBluetoothConnectionStatusDidChangeWithPeripheral:bluetoothType:bluetoothDeviceProfile:bluetoothConnectionStatus:)]) {
        [self.delegate bluetoothDeviceBluetoothConnectionStatusDidChangeWithPeripheral:peripheral bluetoothType:SCUBluetoothDeviceManagerBluetoothTypeBLE bluetoothDeviceProfile:SCUBluetoothDeviceManagerBluetoothDeviceProfileUnknown bluetoothConnectionStatus:SCUBluetoothDeviceManagerBluetoothConnectionStatusConnectionFailure];
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    if ([self.delegate respondsToSelector:@selector(bluetoothDeviceBluetoothConnectionStatusDidChangeWithPeripheral:bluetoothType:bluetoothDeviceProfile:bluetoothConnectionStatus:)]) {
        [self.delegate bluetoothDeviceBluetoothConnectionStatusDidChangeWithPeripheral:peripheral bluetoothType:SCUBluetoothDeviceManagerBluetoothTypeBLE bluetoothDeviceProfile:SCUBluetoothDeviceManagerBluetoothDeviceProfileUnknown bluetoothConnectionStatus:SCUBluetoothDeviceManagerBluetoothConnectionStatusDisconnected];
    }
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state)
    {
            // PoweredOff
        case CBManagerStatePoweredOff:
            self.isBluetoothEnable = NO;
            break;
            // PoweredOn
        case CBManagerStatePoweredOn:
            self.isBluetoothEnable = YES;
            break;
            // Resetting
        case CBManagerStateResetting:
            break;
            // Unsupported
        case CBManagerStateUnsupported:
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
