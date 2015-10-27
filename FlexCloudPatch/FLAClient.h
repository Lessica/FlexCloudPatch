//
//  FLAClient.h
//  FlexCloudPatch
//
//  Created by Zheng on 10/25/15.
//
//

#import <Foundation/Foundation.h>

@interface FLAClient : NSObject

+ (FLAClient *)sharedInstance;
- (NSURL *)apiURL;
- (NSData *)clientData;
- (NSData *)authData;
- (NSString *)getRemoteNotice;

@end
