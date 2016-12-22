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

#define kHexFormat @"Hex"
#define kStringFormat @"UTF-8 String"

@interface ReadWriteDataController () <UIAlertViewDelegate, SCUBluetoothDeviceManagerDelegate>

@property(nonatomic, strong)NSMutableArray *sendDataArr;
@property(nonatomic, strong)NSMutableArray *receivedDataArr;

@property(nonatomic, strong)UIButton *formatButton;
@property(nonatomic, copy)NSString *formatStr;
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
    self.formatStr = kHexFormat;
    
    [self setRightNaviBtn];
}


- (void)setRightNaviBtn {
    
    self.formatButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.formatButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.formatButton.frame = CGRectMake(0, 0, 100,25);
    self.formatButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.formatButton setTitle:self.formatStr forState:UIControlStateNormal];
    self.formatButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    [self.formatButton sizeToFit];
    [self.formatButton addTarget:self action:@selector(navRightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView: self.formatButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}


- (void)navRightButtonClicked {
    if ([self.formatStr isEqualToString:kHexFormat]) {
        self.formatStr = kStringFormat;
    }else if ([self.formatStr isEqualToString:kStringFormat]) {
        self.formatStr = kHexFormat;
    }
    
    [self.formatButton setTitle:self.formatStr forState:UIControlStateNormal];
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
    NSData *dataSend = [NSData data];
    
    NSString *sendStr = @"";
    if ([self.formatStr isEqualToString:kHexFormat]) {
//        dataSend = [self hexToBytes:dataStr];
        dataSend = [dataStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
        uint8_t *dataByte = (uint8_t *)[dataSend bytes];
        sendStr = [self uint8ToStringWith:dataByte Length:dataSend.length];
        [self.sendDataArr addObject:sendStr];
        
    } else if ([self.formatStr isEqualToString:kStringFormat]) {
        dataSend = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        sendStr = dataStr;
        [self.sendDataArr addObject:sendStr];
        
    }
    
    [self.peripheral writeValue:dataSend forCharacteristic:self.charactristic type:CBCharacteristicWriteWithResponse];
    [self.tableView reloadData];
}





- (NSData*) hexToBytes:(NSString*)str {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= str.length; idx+=2)
    {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

- (NSString *)uint8ToStringWith:(uint8_t *)data Length:(NSInteger)len{
    NSMutableString *temStr = [[NSMutableString alloc] init];
    for (int i = 0; i < len; i++) {
        [temStr appendFormat:@" %02x",data[i]];
    }
    return temStr;
}


#pragma mark - BluetoothDelegate
- (void)bluetoothDeviceDidReceivedData:(NSData *)data {
    
    NSString *receivedStr = @"";
    if ([self.formatStr isEqualToString:kHexFormat]) {
        uint8_t *dataByte = (uint8_t *)[data bytes];
        receivedStr = [self uint8ToStringWith:dataByte Length:data.length];
     
        
    } else if ([self.formatStr isEqualToString:kStringFormat]) {
        receivedStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
       
    }
    
    [self.receivedDataArr addObject:receivedStr];
    [self.tableView reloadData];
}




@end
