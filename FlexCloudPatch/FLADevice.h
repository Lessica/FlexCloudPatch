//
//  FLADevice.h
//  FlexCloudPatch
//
//  Created by Zheng on 10/25/15.
//
//

#import <Foundation/Foundation.h>

@interface FLADevice : NSObject
@property (nonatomic, strong) NSString *udid;

+ (FLADevice *)sharedInstance;
- (NSString *)uniqueDeviceID;

@end
