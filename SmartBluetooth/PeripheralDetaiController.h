//
//  PeripheralDetaiController.h
//  SmartBluetooth
//
//  Created by hao123 on 2016/12/14.
//  Copyright © 2016年 SmartCodeUnited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCUBluetoothDeviceManager.h"

@interface PeripheralDetaiController : UITableViewController

@property (nonatomic, strong) CBPeripheral *peripheral;

@end
