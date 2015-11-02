//
//  FlexCloudSettingsController.m
//  FlexCloudSettings
//
//  Created by Zheng on 10/28/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FLADevice.h"
#import "FlexCloudSettingsController.h"
#import <Preferences/PSSpecifier.h>

#define accountConfig @"/private/var/mobile/Library/Preferences/com.johncoates.Flex.plist"
#define kPrefs_Path @"/private/var/mobile/Library/Preferences"
#define kPrefs_KeyName_Key @"key"
#define kPrefs_KeyName_Defaults @"defaults"

@implementation FlexCloudSettingsController

- (id)getValueForSpecifier:(PSSpecifier*)specifier
{
	id value = nil;
	
	NSDictionary *specifierProperties = [specifier properties];
	NSString *specifierKey = [specifierProperties objectForKey:kPrefs_KeyName_Key];
    
    NSMutableString *plistPath = [[NSMutableString alloc] initWithString:[specifierProperties objectForKey:kPrefs_KeyName_Defaults]];
    #if ! __has_feature(objc_arc)
    plistPath = [plistPath autorelease];
    #endif
    if (plistPath)
    {
        NSDictionary *dict = (NSDictionary*)[self initDictionaryWithFile:&plistPath asMutable:NO];
        
        id objectValue = [dict objectForKey:specifierKey];
        
        if (objectValue)
        {
            value = [NSString stringWithFormat:@"%@", objectValue];
        }
        
        #if ! __has_feature(objc_arc)
        [dict release];
        #endif
    }
	
	return value;
}

- (void)setValue:(id)value forSpecifier:(PSSpecifier*)specifier;
{
	NSDictionary *specifierProperties = [specifier properties];
	NSString *specifierKey = [specifierProperties objectForKey:kPrefs_KeyName_Key];
	
    NSMutableString *plistPath = [[NSMutableString alloc] initWithString:[specifierProperties objectForKey:kPrefs_KeyName_Defaults]];
    #if ! __has_feature(objc_arc)
    plistPath = [plistPath autorelease];
    #endif
    if (plistPath)
    {
        NSMutableDictionary *dict = (NSMutableDictionary*)[self initDictionaryWithFile:&plistPath asMutable:YES];
        [dict setObject:value forKey:specifierKey];
        [dict writeToFile:plistPath atomically:YES];
        #if ! __has_feature(objc_arc)
        [dict release];
        #endif
    }
}

- (id)initDictionaryWithFile:(NSMutableString**)plistPath asMutable:(BOOL)asMutable
{
	if ([*plistPath hasPrefix:@"/"])
		*plistPath = [NSMutableString stringWithFormat:@"%@.plist", *plistPath];
	else
		*plistPath = [NSMutableString stringWithFormat:@"%@/%@.plist", kPrefs_Path, *plistPath];
	
	Class class;
	if (asMutable)
		class = [NSMutableDictionary class];
	else
		class = [NSDictionary class];
	
	id dict;	
	if ([[NSFileManager defaultManager] fileExistsAtPath:*plistPath])
		dict = [[class alloc] initWithContentsOfFile:*plistPath];	
	else
		dict = [[class alloc] init];
	
	return dict;
}

- (void)copyUDID:(PSSpecifier *)specifier
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [[FLADevice sharedInstance] uniqueDeviceID];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"云端设备号已经被拷贝到了剪贴板. "
                                                   delegate:nil
                                          cancelButtonTitle:@"好"
                                          otherButtonTitles:nil];
    
    [alert show];
}

- (void)logout:(PSSpecifier *)specifier
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:accountConfig];
    if (prefs) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:[NSString stringWithFormat:@"你确定要注销用户 %@ 吗? ", [prefs objectForKey:@"username"]]
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:accountConfig];
    if (prefs && buttonIndex == 1) {
        [prefs setObject:nil forKeyedSubscript:@"session"];
        [prefs writeToFile:accountConfig atomically:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"注销成功, 重启 Flex 2 生效. "
                                                       delegate:nil
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (id)specifiers
{
	if (_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"FlexCloudSettings" target:self];
		#if ! __has_feature(objc_arc)
		[_specifiers retain];
		#endif
	}
	
	return _specifiers;
}

- (id)init
{
	if ((self = [super init]))
	{
	}
	
	return self;
}

#if ! __has_feature(objc_arc)
- (void)dealloc
{
	[super dealloc];
}
#endif

@end