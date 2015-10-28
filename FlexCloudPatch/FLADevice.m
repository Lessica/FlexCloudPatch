//
//  FLADevice.m
//  FlexCloudPatch
//
//  Created by Zheng on 10/25/15.
//
//

#import "FLADevice.h"
#import "FLADeviceInfo.h"
#import "NSString+encrypto.h"
#import "NSData+encrypto.h"

@implementation FLADevice
static FLADevice *sharedDevice = nil;

+ (FLADevice *)sharedInstance
{
    @synchronized(self)
    {
        if (!sharedDevice)
            sharedDevice = [[FLADevice alloc] init];
    }
    
    return sharedDevice;
}

- (FLADevice *)init {
    if (self = [super init]) {
        _udid = nil;
    }
    return self;
}

- (NSString *)uniqueDeviceID {
    if (!_udid) {
        const char cipher_bytes[] = {
            0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
            0x09, 0x10, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
            0x11, 0x13, 0x15, 0x17, 0x19, 0x21, 0x23, 0x25,
            0x12, 0x14, 0x16, 0x18, 0x20, 0x22, 0x24, 0x26,
            0xA,  0xB,  0xC,  0xD,  0xE,  0xF,  0x2A, 0x2B,
            0x2C, 0x2D, 0x2E, 0x2F, 0x27, 0x28, 0x29, 0x00,
        };
        NSString *serialnumber = [FLADeviceInfo serialnumber];
        if ( serialnumber == nil )
            serialnumber = @"FFFFFF";
        NSString *batterysn = [FLADeviceInfo batterysn];
        if ( batterysn == nil )
            batterysn = @"000000";
        NSString *deviceID = [NSString stringWithFormat:@"%@!%@", batterysn, serialnumber];
        NSData *uniqueData = [deviceID dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableData *mutableData = [[NSMutableData alloc] initWithBytes:cipher_bytes length:48];
        [mutableData appendData:uniqueData];
        NSString *udid_md5 = [[NSData dataWithData:mutableData] md5];
        if (udid_md5) {
            _udid = udid_md5;
        }
    }
    return _udid;
}

@end
