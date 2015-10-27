//
//  NSData+encrypto.h
//  FlexCloudPatch
//
//  Created by Zheng on 10/25/15.
//
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSData (encrypto)
- (NSString *) md5;
- (NSString *) sha1;
- (NSString *) base64_encode;
@end
