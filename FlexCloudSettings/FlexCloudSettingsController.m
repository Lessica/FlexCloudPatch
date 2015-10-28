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

- (void)copyUDID:(PSSpecifier*)specifier
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [[FLADevice sharedInstance] uniqueDeviceID];
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