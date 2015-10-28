//
//  FlexCloudSettingsController.h
//  FlexCloudSettings
//
//  Created by Zheng on 10/28/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>

@interface FlexCloudSettingsController : PSListController
{
}

- (id)getValueForSpecifier:(PSSpecifier*)specifier;
- (void)setValue:(id)value forSpecifier:(PSSpecifier*)specifier;
- (void)copyUDID:(PSSpecifier*)specifier;

@end