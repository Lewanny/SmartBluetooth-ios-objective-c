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

/*!
 *  @enum SCUBluetoothDeviceManagerBluetoothDeviceProfile
 *
 *  @discussion Represents the Bluetooth device profile.
 *
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileA2DP   Profile A2DP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileATT    Profile ATT.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileA2DP   Profile A2DP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileATT    Profile ATT.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileAVRCP  Profile AVRCP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileBIP    Profile BIP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileBPP    Profile BPP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileCIP    Profile CIP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileCTP    Profile CTP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileDIP    Profile DIP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileDUN    Profile DUN.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileFAX    Profile FAX.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileFTP    Profile FTP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileGAVDP  Profile GAVDP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileGAP    Profile GAP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileGATT   Profile GATT.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileGOEP   Profile GOEP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileHCRP   Profile HCRP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileHDP    Profile HDP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileHFP    Profile HFP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileHID    Profile HID.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileHSP    Profile HSP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileICP    Profile ICP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileLAP    Profile LAP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileMAP    Profile MAP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileOBEX   Profile OBEX.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileOPP    Profile OPP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfilePAN    Profile PAN.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfilePBAP   Profile PBAP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfilePXP    Profile PXP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileSPP    Profile SPP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileSDAP   Profile SDAP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileSIMAP  Profile SIMAP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileSYNCH  Profile SYNCH.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileSYNCML Profile SYNCML.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileVDP    Profile VDP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileWAPB   Profile WAPB.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileUDI    Profile UDI.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileESDP   Profile ESDP.
 *  @constant SCUBluetoothDeviceManagerBluetoothDeviceProfileVCP    Profile VCP.
 *
 */
typedef NS_ENUM(NSUInteger, SCUBluetoothDeviceManagerBluetoothDeviceProfile)
{
    SCUBluetoothDeviceManagerBluetoothDeviceProfileUnknown = 0,
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

/*!
 *  @enum SCUBluetoothDeviceManagerBluetoothType
 *
 *  @discussion Represents the Bluetooth type.
 *
 *  @constant SCUBluetoothDeviceManagerBluetoothTypeClassic Bluetooth Classical.
 *  @constant SCUBluetoothDeviceManagerBluetoothTypeBLE     Bluetooth Low Energy.
 *
 */
typedef NS_ENUM(NSUInteger, SCUBluetoothDeviceManagerBluetoothType)
{
    SCUBluetoothDeviceManagerBluetoothTypeClassic = 1,
    SCUBluetoothDeviceManagerBluetoothTypeBLE = 2
};

/*!
 *  @enum SCUBluetoothDeviceManagerBluetoothStatus
 *
 *  @discussion Represents the Bluetooth status.
 *
 *  @constant SCUBluetoothDeviceManagerBluetoothStatusTurningOn  Turning on Bluetooth.
 *  @constant SCUBluetoothDeviceManagerBluetoothStatusOn         Bluetooth on.
 *  @constant SCUBluetoothDeviceManagerBluetoothStatusTurningOff Turning off Bluetooth.
 *  @constant SCUBluetoothDeviceManagerBluetoothStatusOff        Bluetooth off.
 *  @constant SCUBluetoothDeviceManagerBluetoothStatusScanning   Bluetooth scanning.
 *
 */
typedef NS_ENUM(NSUInteger, SCUBluetoothDeviceManagerBluetoothStatus)
{
    SCUBluetoothDeviceManagerBluetoothStatusTurningOn = 1,
    SCUBluetoothDeviceManagerBluetoothStatusOn = 2,
    SCUBluetoothDeviceManagerBluetoothStatusTurningOff = 3,
    SCUBluetoothDeviceManagerBluetoothStatusOff = 4,
    SCUBluetoothDeviceManagerBluetoothStatusScanning = 5
};

/*!
 *  @enum SCUBluetoothDeviceManagerBluetoothConnectionStatus
 *
 *  @discussion Represents the Bluetooth connection status.
 *
 *  @constant SCUBluetoothDeviceManagerBluetoothConnectionStatusConnecting    Bluetooth connecting.
 *  @constant SCUBluetoothDeviceManagerBluetoothConnectionStatusConnected     Bluetooth connected.
 *  @constant SCUBluetoothDeviceManagerBluetoothConnectionStatusDisconnecting Bluetooth disconnecting.
 *  @constant SCUBluetoothDeviceManagerBluetoothConnectionStatusDisconnected  Bluetooth disconnected.
 *
 */
typedef NS_ENUM(NSUInteger, SCUBluetoothDeviceManagerBluetoothConnectionStatus)
{
    SCUBluetoothDeviceManagerBluetoothConnectionStatusConnecting = 1,
    SCUBluetoothDeviceManagerBluetoothConnectionStatusConnected = 2,
    SCUBluetoothDeviceManagerBluetoothConnectionStatusConnectionFailure = 3,
    SCUBluetoothDeviceManagerBluetoothConnectionStatusDisconnecting = 4,
    SCUBluetoothDeviceManagerBluetoothConnectionStatusDisconnected = 5,
    SCUBluetoothDeviceManagerBluetoothConnectionStatusDisconnectionFailure = 6
};

/*!
 *  @protocol SCUBluetoothDeviceManagerDelegate
 *
 *  @discussion The delegate of a {@link SCUBluetoothDeviceManager} object,while the optional methods allow for the discovery and
 *              connection of peripherals and Bluetooth status.
 *
 */
@protocol SCUBluetoothDeviceManagerDelegate <NSObject>

@optional

/*!
 *  @method bluetoothDeviceBluetoothStatusDidChangeWithStatus:
 *
 *  @param bluetoothStatus  The Bluetooth status.
 *
 *  @discussion While the Bluetooth status changed.
 *
 *  @see SCUBluetoothDeviceManagerBluetoothStatus
 *
 */
- (void)bluetoothDeviceBluetoothStatusDidChangeWithStatus:(SCUBluetoothDeviceManagerBluetoothStatus)bluetoothStatus;

/*!
 *  @method bluetoothDeviceBluetoothConnectionStatusDidChangeWithPeripheral:bluetoothType:bluetoothDeviceProfile:bluetoothConnectionStatus:
 *
 *  @param peripheral  The Bluetooth connection peripheral.
 *  @param bluetoothType  The Bluetooth type.
 *  @param bluetoothDeviceProfile  The Bluetooth device profile.
 *  @param bluetoothConnectionStatus  The Bluetooth connection status.
 *
 *  @discussion While the Bluetooth connection status changed.
 *
 *  @see SCUBluetoothDeviceManagerBluetoothConnectionStatus
 *
 */
- (void)bluetoothDeviceBluetoothConnectionStatusDidChangeWithPeripheral:(CBPeripheral *)peripheral bluetoothType:(SCUBluetoothDeviceManagerBluetoothType)bluetoothType bluetoothDeviceProfile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)bluetoothDeviceProfile bluetoothConnectionStatus:(SCUBluetoothDeviceManagerBluetoothConnectionStatus)bluetoothConnectionStatus;

/*!
 * TODO
 *
 */
- (void)bluetoothDeviceBluetoothScanningClassicDidReceive;

/*!
 *  @method bluetoothDeviceBluetoothScanningBLEDidReceiveWithPeripheral:RSSI:advertisementData:
 *
 *  @param peripheral  The Bluetooth peripheral.
 *  @param rssi  The Bluetooth rssi.
 *  @param advertisementData  The Bluetooth advertisement data.
 *
 *  @discussion While the Bluetooth peripheral discovered.
 *
 */
- (void)bluetoothDeviceBluetoothScanningBLEDidReceiveWithPeripheral:(CBPeripheral *)peripheral RSSI:(NSNumber *)rssi advertisementData:(NSDictionary *)advertisementData;

// Received data callback
- (void)bluetoothDeviceDidReceivedData:(NSData *)data;

@end

/*!
 *  @class SCUBluetoothDeviceManager
 *
 *  @discussion The Bluetooth device manager.
 *
 */
@interface SCUBluetoothDeviceManager : NSObject

@property(nonatomic, strong)id<SCUBluetoothDeviceManagerDelegate> delegate;

+ (SCUBluetoothDeviceManager *)sharedInstance;


/*!
 *  @method setSCUBluetoothDeviceManagerDelegate:
 *  @param delegate SCUBluetoothDeviceManagerDelegate object.
 *
 *  @discussion Set the SCUBluetoothDeviceManagerDelegate object.
 *
 */
- (void)setSCUBluetoothDeviceManagerDelegate:(id<SCUBluetoothDeviceManagerDelegate>)delegate;

/*!
 *  @method isSupported
 *
 *  @discussion Whether the iOS device support Bluetooth.
 *
 */
- (BOOL)isSupported;

/*!
 *  @method isEnabled
 *
 *  @discussion Whether the iOS device Bluetooth is enabled.
 *
 */
- (BOOL)isEnabled;

/*!
 *  @method isMACAddressValid:
 *  @param address Bluetooth MAC address.

 *  @discussion Whether the Bluetooth MAC address is valid.
 *
 */
- (BOOL)isMACAddressValid:(NSString *)address;

/*!
 *  @method isScanningWithType:
 *  @param bluetoothType Bluetooth type.
 *
 *  @discussion Whether Bluetooth is scanning with different type.
 *  
 *  @see SCUBluetoothDeviceManagerBluetoothType
 */
- (BOOL)isScanningWithType:(SCUBluetoothDeviceManagerBluetoothType)bluetoothType;

/*!
 *  @method isConnectedWithPeripheral:bluetoothType:profile:
 *  @param peripheral Bluetooth peripheral.
 *  @param bluetoothType Bluetooth type.
 *  @param bluetoothDeviceProfile Bluetooth device profile.
 *
 *  @discussion Whether the Bluetooth peripheral is connected with different type and device profile.
 *
 *  @see SCUBluetoothDeviceManagerBluetoothType
 *  @see SCUBluetoothDeviceManagerBluetoothDeviceProfile
 */
- (BOOL)isConnectedWithPeripheral:(CBPeripheral *)peripheral bluetoothType:(SCUBluetoothDeviceManagerBluetoothType)bluetoothType profile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)bluetoothDeviceProfile;


/**
 Note: You can only scan for Bluetooth LE devices or scan for Classic Bluetooth devices, as described in Bluetooth. You cannot scan for both Bluetooth LE and classic devices at the same time.
 
 @param type Bluetooth Classic or BLE
 */

/*!
 *  @method startScanningWithType:
 *  @param bluetoothType Bluetooth type.
 *
 *  @discussion Start Bluetooth scanning with different type. Note: You can only scan for Bluetooth LE devices or scan for Classic Bluetooth devices, as described in Bluetooth. You cannot scan for both Bluetooth LE and classic devices at the same time.
 *
 *  @see SCUBluetoothDeviceManagerBluetoothType
 */
- (void)startScanningWithType:(SCUBluetoothDeviceManagerBluetoothType)bluetoothType;

/*!
 *  @method stopScanningWithType:
 *  @param bluetoothType Bluetooth type.
 *
 *  @discussion Stop Bluetooth scanning with different type. 
 *
 *  @see SCUBluetoothDeviceManagerBluetoothType
 */
- (void)stopScanningWithType:(SCUBluetoothDeviceManagerBluetoothType)bluetoothType;

/*!
 *  @method turnOn:
 *
 *  @discussion Turn on iOS device's Bluetooth.
 *
 */
- (void)turnOn;

/*!
 *  @method turnOff:
 *
 *  @discussion Turn off iOS device's Bluetooth.
 *
 */
- (void)turnOff;

/*!
 *  @method connectWithPeripheral:bluetoothType:bluetoothDeviceProfile:
 *  @param peripheral Bluetooth peripheral.
 *  @param bluetoothType Bluetooth type.
 *  @param bluetoothDeviceProfile Bluetooth device profile.
 *
 *  @discussion Connect Bluetooth peripheral with different Bluetooth type and device profile.
 *
 *  @see SCUBluetoothDeviceManagerBluetoothType
 *  @see SCUBluetoothDeviceManagerBluetoothDeviceProfile
 */
- (void)connectWithPeripheral:(CBPeripheral *)peripheral bluetoothType:(SCUBluetoothDeviceManagerBluetoothType)bluetoothType bluetoothDeviceProfile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)bluetoothDeviceProfile;

/*!
 *  @method connectWithPeripheral:bluetoothType:bluetoothDeviceProfile:
 *  @param peripheral Bluetooth peripheral.
 *  @param bluetoothType Bluetooth type.
 *  @param bluetoothDeviceProfile Bluetooth device profile.
 *
 *  @discussion Disconnect Bluetooth peripheral with different Bluetooth type and device profile.
 *
 *  @see SCUBluetoothDeviceManagerBluetoothType
 *  @see SCUBluetoothDeviceManagerBluetoothDeviceProfile
 */
- (void)disconnectWithPeripheral:(CBPeripheral *)peripheral bluetoothType:(SCUBluetoothDeviceManagerBluetoothType)bluetoothType bluetoothDeviceProfile:(SCUBluetoothDeviceManagerBluetoothDeviceProfile)bluetoothDeviceProfile;

@end


