//
//  FLADeviceInfo.h
//  FlexCloudPatch
//
//  Created by Zheng on 10/25/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SUPPORTS_IOKIT_EXTENSIONS 1
//To use, you must add the (semi)public IOKit framework before compiling
#if SUPPORTS_IOKIT_EXTENSIONS

@interface FLADeviceInfo : NSObject

NSArray *getValue(NSString *iosearch);
+ (NSString *)imei;
+ (NSString *)serialnumber;
+ (NSString *)batterysn;

@end

#endif
