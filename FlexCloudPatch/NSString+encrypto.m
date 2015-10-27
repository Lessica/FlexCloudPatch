//
//  NSString+encrypto.m
//  FlexCloudPatch
//
//  Created by Zheng on 10/25/15.
//
//

#import "NSString+encrypto.h"

@implementation NSString (encrypto)
- (NSData *) base64_decode
{
    return [[NSData alloc] initWithBase64EncodedString:self
                                               options:0];
}
@end
