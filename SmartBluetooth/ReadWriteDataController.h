//
//  ReadWriteDataController.h
//  SmartBluetooth
//
//  Created by 李宏远 on 2016/12/22.
//  Copyright © 2016年 SmartCodeUnited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCUBluetoothDeviceManager.h"

@interface ReadWriteDataController : UITableViewController

@property(nonatomic, strong)CBCharacteristic *charactristic;
@property (nonatomic, strong) CBPeripheral *peripheral;

@end
