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
#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef NS_ENUM(NSUInteger, SCUBluetoothDeviceManagerBluetoothDeviceProfile)
{
    SCUBluetoothDeviceManagerBluetoothDeviceProfileA2DP = 1,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileATT = 2,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileAVRCP = 3,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileBIP = 4,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileBPP = 5,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileCIP = 6,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileCTP = 7,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileDIP = 8,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileDUN = 9,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileFAX = 10,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileFTP = 11,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileGAVDP = 12,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileGAP = 13,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileGATT = 14,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileGOEP = 15,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileHCRP = 16,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileHDP = 17,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileHFP = 18,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileHID = 19,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileHSP = 20,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileICP = 21,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileLAP = 22,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileMAP = 23,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileOBEX = 24,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileOPP = 25,
    SCUBluetoothDeviceManagerBluetoothDeviceProfilePAN = 26,
    SCUBluetoothDeviceManagerBluetoothDeviceProfilePBAP = 27,
    SCUBluetoothDeviceManagerBluetoothDeviceProfilePXP = 28,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileSPP = 29,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileSDAP = 30,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileSIMAP = 31,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileSYNCH = 32,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileSYNCML = 33,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileVDP = 34,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileWAPB = 35,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileUDI = 36,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileESDP = 37,
    SCUBluetoothDeviceManagerBluetoothDeviceProfileVCP = 38
};

typedef NS_ENUM(NSUInteger, SCUBluetoothDeviceManagerBluetoothType)
{
    SCUBluetoothDeviceManagerBluetoothTypeClassic = 1,
    SCUBluetoothDeviceManagerBluetoothTypeBLE = 2
};

typedef NS_ENUM(NSUInteger, SCUBluetoothDeviceManagerBluetoothStatus)
{
    SCUBluetoothDeviceManagerBluetoothStatusTurningOn = 1,
    SCUBluetoothDeviceManagerBluetoothStatusOn = 2,
    SCUBluetoothDeviceManagerBluetoothStatusTurningOff = 3,
    SCUBluetoothDeviceManagerBluetoothStatusOff = 4,
    SCUBluetoothDeviceManagerBluetoothStatusScanning = 5
};

typedef NS_ENUM(NSUInteger, SCUBluetoothDeviceManagerBluetoothConnectionStatus)
{
    SCUBluetoothDeviceManagerBluetoothConnectionStatusConnecting = 1,
    SCUBluetoothDeviceManagerBluetoothConnectionStatusConnected = 2,
    SCUBluetoothDeviceManagerBluetoothConnectionStatusDisconnecting = 3,
    SCUBluetoothDeviceManagerBluetoothConnectionStatusDisconnected = 4
};

@protocol SCUBluetoothDeviceManagerDelegate <NSObject>

@optional

- (void)bluetoothDeviceBluetoothStatusDidChange:(SCUBluetoothDeviceManagerBluetoothStatus)bluetoothStatus;

- (void)bluetoothDeviceBluetoothConnectionStatusDidChange:(SCUBluetoothDeviceManagerBluetoothConnectionStatus)bluetoothConnectionStatus;

/**
 TODO
 */
- (void)bluetoothDeviceBluetoothScanningClassicDidReceive;

- (void)bluetoothDeviceBluetoothScanningBLEDidReceiveWithPeripheral:(CBPeripheral *)peripheral RSSI:(NSNumber *)rssi advertisementData:(NSDictionary *)advertisementData;

@end

@interface SCUBluetoothDeviceManager : NSObject


+ (SCUBluetoothDeviceManager *)sharedInstance;

- (void)setSCUBluetoothDeviceManagerDelegate:(id<SCUBluetoothDeviceManagerDelegate>)delegate;

// Is bluetooth supported
- (BOOL)isSupported;

// Is bluetooth open
- (BOOL)isEnabled;

// Is macadress available
- (BOOL)isMACAddressValid:(NSString *)address;

- (BOOL)isScanningWithType:(SCUBluetoothDeviceManagerBluetoothType)type;

- (BOOL)isConnectedWithPeripheral:(CBPeripheral *)peripheral profile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)profile;


/**
 Note: You can only scan for Bluetooth LE devices or scan for Classic Bluetooth devices, as described in Bluetooth. You cannot scan for both Bluetooth LE and classic devices at the same time.
 
 @param type Bluetooth Classic or BLE
 */
- (void)startScanningWithType:(SCUBluetoothDeviceManagerBluetoothType)type;


/**
 Note: You can only scan for Bluetooth LE devices or scan for Classic Bluetooth devices, as described in Bluetooth. You cannot scan for both Bluetooth LE and classic devices at the same time.
 
 @param type Bluetooth Classic or BLE
 */
- (void)stopScanningWithType:(SCUBluetoothDeviceManagerBluetoothType)type;

- (void)turnOn;

- (void)turnOff;

- (void)connectWithPeripheral:(CBPeripheral *)peripheral profile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)profile;

- (void)disConnectWithPeripheral:(CBPeripheral *)peripheral profile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)profile;

@end


