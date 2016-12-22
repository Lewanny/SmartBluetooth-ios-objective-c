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

#import "SCUDataConversionTool.h"

@implementation SCUDataConversionTool

static SCUDataConversionTool *_sharedInstance = nil;
+ (SCUDataConversionTool *)sharedInstance
{
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        _sharedInstance = [[SCUDataConversionTool alloc] init];
    });
    
    return _sharedInstance;
}


- (NSString *)hexStringFromString:(NSString *)string {
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];   
    }   
    return hexStr;   
}


// Converts a string to an array of hexadecimal bytes
-(NSData *)stringToHexByte:(NSString *)string {
    
    NSString *hexString = [[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2 != 0) {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0; i<[hexString length]; i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; // The first digit of the two-digit hexadecimal number (upper digit * 16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //  0 of the Ascii-48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //  A of Ascii-65
        else
            return nil;
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; // The second (lower) bit of a two-digit hexadecimal number
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //  0 of the Ascii-48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //  A of Ascii-65
        else
            return nil;
        
        tempbyt[0] = int_ch1+int_ch2;  // Put the converted number into the Byte array
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}

@end
