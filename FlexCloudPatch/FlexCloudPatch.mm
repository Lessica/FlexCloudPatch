#line 1 "/Users/Zheng/Documents/FlexCloudPatch/FlexCloudPatch/FlexCloudPatch.xm"
#import "FLADevice.h"
#import "FLAClient.h"
#import <UIKit/UIKit.h>

#define currentPatchVersion @"1.990-7"
#define prefsPath @"/private/var/mobile/Library/Preferences/com.darwindev.FlexCloudSettings.plist"
#define updateUrl @"cydia://url/https://cydia.saurik.com/api/share#?source=http://apt.82flex.com/&package=com.darwindev.flexcloud"

static bool enabled = YES;
static bool checkUpdates = YES;

static void loadPrefs() {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsPath];
    if (prefs) {
        enabled = ([prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : enabled);
        checkUpdates = ([prefs objectForKey:@"checkUpdates"] ? [[prefs objectForKey:@"checkUpdates"] boolValue] : checkUpdates);
        [prefs release];
    }
}

#include <logos/logos.h>
#include <substrate.h>
@class GAI; @class FYTabBarItemView; @class FLInfoDashboardViewController; @class FLPatchAddViewController; @class FLInfoViewController; @class FYAccountLoginViewController; @class FLInfoDashboardNewsView; @class FLANotice; @class FYUISegmentedBar; @class FLXTLSManager; @class FLPatchEditViewController; @class FYUIAlertView; @class FLPatchesViewController; @class FYSharePatchViewController; @class FLAResource; @class FLInfoDiagnosticsTableViewController; @class FLCloudViewController; 

static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$FLANotice(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("FLANotice"); } return _klass; }static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$FYUIAlertView(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("FYUIAlertView"); } return _klass; }
#line 21 "/Users/Zheng/Documents/FlexCloudPatch/FlexCloudPatch/FlexCloudPatch.xm"
static NSString * (*_logos_orig$FlexCloudDevice$FLAResource$uniqueDeviceID)(FLAResource*, SEL); static NSString * _logos_method$FlexCloudDevice$FLAResource$uniqueDeviceID(FLAResource*, SEL); 

static NSString * _logos_method$FlexCloudDevice$FLAResource$uniqueDeviceID(FLAResource* self, SEL _cmd) {
    return [[FLADevice sharedInstance] uniqueDeviceID];
}



static NSURL * (*_logos_orig$FlexCloudApi$FLAResource$apiURL)(FLAResource*, SEL); static NSURL * _logos_method$FlexCloudApi$FLAResource$apiURL(FLAResource*, SEL); static NSData * (*_logos_meta_orig$FlexCloudApi$FLXTLSManager$clientData)(Class, SEL); static NSData * _logos_meta_method$FlexCloudApi$FLXTLSManager$clientData(Class, SEL); static NSData * (*_logos_meta_orig$FlexCloudApi$FLXTLSManager$authData)(Class, SEL); static NSData * _logos_meta_method$FlexCloudApi$FLXTLSManager$authData(Class, SEL); 

static NSURL * _logos_method$FlexCloudApi$FLAResource$apiURL(FLAResource* self, SEL _cmd) {
    return [[FLAClient sharedInstance] apiURL];
}


static NSData * _logos_meta_method$FlexCloudApi$FLXTLSManager$clientData(Class self, SEL _cmd) {
    return [[FLAClient sharedInstance] clientData];
}
static NSData * _logos_meta_method$FlexCloudApi$FLXTLSManager$authData(Class self, SEL _cmd) {
    return [[FLAClient sharedInstance] authData];
}



static NSString * (*_logos_orig$FlexCloudCommunity$FLANotice$resourceAction)(FLANotice*, SEL); static NSString * _logos_method$FlexCloudCommunity$FLANotice$resourceAction(FLANotice*, SEL); static NSString * (*_logos_orig$FlexCloudCommunity$FLInfoDashboardViewController$titleForView$)(FLInfoDashboardViewController*, SEL, UIView *); static NSString * _logos_method$FlexCloudCommunity$FLInfoDashboardViewController$titleForView$(FLInfoDashboardViewController*, SEL, UIView *); static void (*_logos_orig$FlexCloudCommunity$FLInfoDashboardNewsView$willMoveToSuperview$)(FLInfoDashboardNewsView*, SEL, id); static void _logos_method$FlexCloudCommunity$FLInfoDashboardNewsView$willMoveToSuperview$(FLInfoDashboardNewsView*, SEL, id); 

static NSString * _logos_method$FlexCloudCommunity$FLANotice$resourceAction(FLANotice* self, SEL _cmd) {
    return @"notice";
}


static NSString * _logos_method$FlexCloudCommunity$FLInfoDashboardViewController$titleForView$(FLInfoDashboardViewController* self, SEL _cmd, UIView * view) {
    if (view == MSHookIvar<UIView *>(self, "_newsView")) {
        return @"最新公告";
    }
    return nil;
}


static void _logos_method$FlexCloudCommunity$FLInfoDashboardNewsView$willMoveToSuperview$(FLInfoDashboardNewsView* self, SEL _cmd, id superview) {
    if (superview) {
        NSString *udid = [[FLADevice sharedInstance] uniqueDeviceID];
        NSString *tips = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",
                          @"云端设备号：", udid, @"\n\n",
                          @"欢迎使用 Flex 2 中文云端！\n",
                          @"这是一个由国人管理和打造的 iOS 补丁分享与交流技术社区。\n",
                          @"全新体验，社区交互，补丁商城等众多云端功能，敬请期待……\n",
                          @"Powered by 82Flex & J.C.T. \n\n",
                          @"I really appreciate your purchase of Flex 2.\n\n",
                          @"If you encounter a bug, or have any comments or feature suggestions, please contact me on Twitter at @punksomething.\n\n",
                          @"cheers,\nJohn Coates, creator of Flex"
                          ]; 
        __block id label = [self newsLabel];
        if (label != nil && [label respondsToSelector:@selector(setText:)]) {
            [label setText:tips];
            
            id req = [[_logos_static_class_lookup$FLANotice() alloc] init];
            [req loadWithParams:nil
                        success:^(id resp) {
                            if (resp != nil && [resp respondsToSelector:@selector(responseObject)]) {
                                id resp_obj = [resp responseObject];
                                if (resp_obj != nil && [resp_obj respondsToSelector:@selector(objectForKeyedSubscript:)]) {
                                    id result_obj = [resp_obj objectForKeyedSubscript:@"result"];
                                    if (result_obj != nil && [result_obj respondsToSelector:@selector(objectForKeyedSubscript:)]) {
                                        NSString *remote_tips = [result_obj objectForKeyedSubscript:@"message"];
                                        if (remote_tips != nil && [remote_tips isKindOfClass:[NSString class]]) {
                                            [label setText:remote_tips];
                                        }
                                        NSString *latest_version = [result_obj objectForKeyedSubscript:@"latestVersion"];
                                        if (latest_version != nil && [latest_version isKindOfClass:[NSString class]]) {
                                            if (![latest_version isEqualToString:currentPatchVersion]) {
                                                [_logos_static_class_lookup$FYUIAlertView() showAlertWithTitle:@"版本更新"
                                                                              message:[NSString stringWithFormat:@"当前版本: %@\n最新版本: %@\n是否前往 Cydia 更新? ", currentPatchVersion, latest_version]
                                                                              buttons:[NSArray arrayWithObjects:@"取消", @"更新", nil]
                                                                           completion:^(int choice){
                                                                               if (choice == 1) {
                                                                                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateUrl]];
                                                                               }
                                                                           }];
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        failure:nil];
        }
    }
}



static id (*_logos_orig$RemoveGoogle$GAI$init)(GAI*, SEL); static id _logos_method$RemoveGoogle$GAI$init(GAI*, SEL); 

static id _logos_method$RemoveGoogle$GAI$init(GAI* self, SEL _cmd) {
    return nil;
}



static void (*_logos_orig$FlexLocalization$FLInfoDiagnosticsTableViewController$viewDidLoad)(FLInfoDiagnosticsTableViewController*, SEL); static void _logos_method$FlexLocalization$FLInfoDiagnosticsTableViewController$viewDidLoad(FLInfoDiagnosticsTableViewController*, SEL); static id (*_logos_orig$FlexLocalization$FYAccountLoginViewController$buttonWithLabel$andSelector$)(FYAccountLoginViewController*, SEL, id, id); static id _logos_method$FlexLocalization$FYAccountLoginViewController$buttonWithLabel$andSelector$(FYAccountLoginViewController*, SEL, id, id); static void (*_logos_orig$FlexLocalization$FYAccountLoginViewController$viewDidLoad)(FYAccountLoginViewController*, SEL); static void _logos_method$FlexLocalization$FYAccountLoginViewController$viewDidLoad(FYAccountLoginViewController*, SEL); static id (*_logos_orig$FlexLocalization$FYAccountLoginViewController$registerUISetup)(FYAccountLoginViewController*, SEL); static id _logos_method$FlexLocalization$FYAccountLoginViewController$registerUISetup(FYAccountLoginViewController*, SEL); static id (*_logos_orig$FlexLocalization$FYTabBarItemView$label)(FYTabBarItemView*, SEL); static id _logos_method$FlexLocalization$FYTabBarItemView$label(FYTabBarItemView*, SEL); static id (*_logos_orig$FlexLocalization$FYUISegmentedBar$buttonWithTitle$)(FYUISegmentedBar*, SEL, id); static id _logos_method$FlexLocalization$FYUISegmentedBar$buttonWithTitle$(FYUISegmentedBar*, SEL, id); static void (*_logos_orig$FlexLocalization$FLPatchesViewController$loadView)(FLPatchesViewController*, SEL); static void _logos_method$FlexLocalization$FLPatchesViewController$loadView(FLPatchesViewController*, SEL); static void (*_logos_orig$FlexLocalization$FLPatchAddViewController$loadView)(FLPatchAddViewController*, SEL); static void _logos_method$FlexLocalization$FLPatchAddViewController$loadView(FLPatchAddViewController*, SEL); static void (*_logos_orig$FlexLocalization$FLPatchEditViewController$loadView)(FLPatchEditViewController*, SEL); static void _logos_method$FlexLocalization$FLPatchEditViewController$loadView(FLPatchEditViewController*, SEL); static void (*_logos_orig$FlexLocalization$FYSharePatchViewController$loadView)(FYSharePatchViewController*, SEL); static void _logos_method$FlexLocalization$FYSharePatchViewController$loadView(FYSharePatchViewController*, SEL); static void (*_logos_orig$FlexLocalization$FLCloudViewController$viewDidLoad)(FLCloudViewController*, SEL); static void _logos_method$FlexLocalization$FLCloudViewController$viewDidLoad(FLCloudViewController*, SEL); static void (*_logos_orig$FlexLocalization$FLInfoViewController$viewDidLoad)(FLInfoViewController*, SEL); static void _logos_method$FlexLocalization$FLInfoViewController$viewDidLoad(FLInfoViewController*, SEL); 

static void _logos_method$FlexLocalization$FLInfoDiagnosticsTableViewController$viewDidLoad(FLInfoDiagnosticsTableViewController* self, SEL _cmd) {
    _logos_orig$FlexLocalization$FLInfoDiagnosticsTableViewController$viewDidLoad(self, _cmd);
    [self setTitle:@"开发者"];
    UITableView *tableView = [self tableView];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, tableView.frame.size.height)];



    [tableView addSubview:webView];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}



static id _logos_method$FlexLocalization$FYAccountLoginViewController$buttonWithLabel$andSelector$(FYAccountLoginViewController* self, SEL _cmd, id arg1, id arg2) {
    if ([arg1 isEqualToString:@"Login"]) {
        return _logos_orig$FlexLocalization$FYAccountLoginViewController$buttonWithLabel$andSelector$(self, _cmd, @"登录", arg2);
    } else if([arg1 isEqualToString:@"Register"]) {
        return _logos_orig$FlexLocalization$FYAccountLoginViewController$buttonWithLabel$andSelector$(self, _cmd, @"注册", arg2);
    } else {
        return _logos_orig$FlexLocalization$FYAccountLoginViewController$buttonWithLabel$andSelector$(self, _cmd, arg1, arg2);
    }
}



static id _logos_method$FlexLocalization$FYTabBarItemView$label(FYTabBarItemView* self, SEL _cmd) {
    _logos_orig$FlexLocalization$FYTabBarItemView$label(self, _cmd);
    UILabel *label = MSHookIvar<UILabel *>(self, "_label");
    if ([label.text isEqualToString:@"patches"]) {
        label.text = @"补丁";
    } else if ([label.text isEqualToString:@"cloud"]) {
        label.text = @"云端";
    } else if ([label.text isEqualToString:@"info"]) {
        label.text = @"关于";
    }
    return label;
}



static id _logos_method$FlexLocalization$FYUISegmentedBar$buttonWithTitle$(FYUISegmentedBar* self, SEL _cmd, id arg1) {
    if ([arg1 isEqualToString:@"Dashboard"])
    {
        arg1 = @"公告板";
    }
    else if ([arg1 isEqualToString:@"Diagnostics"])
    {
        arg1 = @"开发者";
    }
    else if ([arg1 isEqualToString:@"Recent"]){
        arg1 = @"最近";
    }
    else if([arg1 isEqualToString:@"Popular"]){
        arg1 = @"排行";
    }
    else if ([arg1 isEqualToString:@"All"]){
        arg1 = @"全部";
    }
    else if ([arg1 isEqualToString:@"Installed"]) {
        arg1 = @"已安装";
    }
    return _logos_orig$FlexLocalization$FYUISegmentedBar$buttonWithTitle$(self, _cmd, arg1);
}



static void _logos_method$FlexLocalization$FLPatchesViewController$loadView(FLPatchesViewController* self, SEL _cmd) {
    _logos_orig$FlexLocalization$FLPatchesViewController$loadView(self, _cmd);
    [self setTitle:@"补丁"];
}



static void _logos_method$FlexLocalization$FLPatchAddViewController$loadView(FLPatchAddViewController* self, SEL _cmd) {
    _logos_orig$FlexLocalization$FLPatchAddViewController$loadView(self, _cmd);
    [self setTitle:@"选择应用"];
}



static void _logos_method$FlexLocalization$FLPatchEditViewController$loadView(FLPatchEditViewController* self, SEL _cmd) {
    _logos_orig$FlexLocalization$FLPatchEditViewController$loadView(self, _cmd);
    [self setTitle:@"编辑"];
}



static void _logos_method$FlexLocalization$FYSharePatchViewController$loadView(FYSharePatchViewController* self, SEL _cmd) {
    _logos_orig$FlexLocalization$FYSharePatchViewController$loadView(self, _cmd);
    [self setTitle:@"上传"];
}



static void _logos_method$FlexLocalization$FYAccountLoginViewController$viewDidLoad(FYAccountLoginViewController* self, SEL _cmd) {
    _logos_orig$FlexLocalization$FYAccountLoginViewController$viewDidLoad(self, _cmd);
    [self setTitle:@"登录"];
}

static id _logos_method$FlexLocalization$FYAccountLoginViewController$registerUISetup(FYAccountLoginViewController* self, SEL _cmd) {
    _logos_orig$FlexLocalization$FYAccountLoginViewController$registerUISetup(self, _cmd);
    [self setTitle:@"注册"];
    return _logos_orig$FlexLocalization$FYAccountLoginViewController$registerUISetup(self, _cmd);
}



static void _logos_method$FlexLocalization$FLCloudViewController$viewDidLoad(FLCloudViewController* self, SEL _cmd) {
    _logos_orig$FlexLocalization$FLCloudViewController$viewDidLoad(self, _cmd);
    [self setTitle:@"中文云端"];
}



static void _logos_method$FlexLocalization$FLInfoViewController$viewDidLoad(FLInfoViewController* self, SEL _cmd) {
    _logos_orig$FlexLocalization$FLInfoViewController$viewDidLoad(self, _cmd);
    [self setTitle:@"关于"];
}




static __attribute__((constructor)) void _logosLocalCtor_c4f12235() {
    loadPrefs();
    if (enabled) {
        {Class _logos_class$FlexCloudDevice$FLAResource = objc_getClass("FLAResource"); MSHookMessageEx(_logos_class$FlexCloudDevice$FLAResource, @selector(uniqueDeviceID), (IMP)&_logos_method$FlexCloudDevice$FLAResource$uniqueDeviceID, (IMP*)&_logos_orig$FlexCloudDevice$FLAResource$uniqueDeviceID);}
        {Class _logos_class$FlexCloudApi$FLAResource = objc_getClass("FLAResource"); MSHookMessageEx(_logos_class$FlexCloudApi$FLAResource, @selector(apiURL), (IMP)&_logos_method$FlexCloudApi$FLAResource$apiURL, (IMP*)&_logos_orig$FlexCloudApi$FLAResource$apiURL);Class _logos_class$FlexCloudApi$FLXTLSManager = objc_getClass("FLXTLSManager"); Class _logos_metaclass$FlexCloudApi$FLXTLSManager = object_getClass(_logos_class$FlexCloudApi$FLXTLSManager); MSHookMessageEx(_logos_metaclass$FlexCloudApi$FLXTLSManager, @selector(clientData), (IMP)&_logos_meta_method$FlexCloudApi$FLXTLSManager$clientData, (IMP*)&_logos_meta_orig$FlexCloudApi$FLXTLSManager$clientData);MSHookMessageEx(_logos_metaclass$FlexCloudApi$FLXTLSManager, @selector(authData), (IMP)&_logos_meta_method$FlexCloudApi$FLXTLSManager$authData, (IMP*)&_logos_meta_orig$FlexCloudApi$FLXTLSManager$authData);}
        if (checkUpdates) {
            {Class _logos_class$FlexCloudCommunity$FLAResource = objc_getClass("FLAResource"); { Class _logos_class$FlexCloudCommunity$FLANotice = objc_allocateClassPair(_logos_class$FlexCloudCommunity$FLAResource, "FLANotice", 0); objc_registerClassPair(_logos_class$FlexCloudCommunity$FLANotice); MSHookMessageEx(_logos_class$FlexCloudCommunity$FLANotice, @selector(resourceAction), (IMP)&_logos_method$FlexCloudCommunity$FLANotice$resourceAction, (IMP*)&_logos_orig$FlexCloudCommunity$FLANotice$resourceAction); }Class _logos_class$FlexCloudCommunity$FLInfoDashboardViewController = objc_getClass("FLInfoDashboardViewController"); MSHookMessageEx(_logos_class$FlexCloudCommunity$FLInfoDashboardViewController, @selector(titleForView:), (IMP)&_logos_method$FlexCloudCommunity$FLInfoDashboardViewController$titleForView$, (IMP*)&_logos_orig$FlexCloudCommunity$FLInfoDashboardViewController$titleForView$);Class _logos_class$FlexCloudCommunity$FLInfoDashboardNewsView = objc_getClass("FLInfoDashboardNewsView"); MSHookMessageEx(_logos_class$FlexCloudCommunity$FLInfoDashboardNewsView, @selector(willMoveToSuperview:), (IMP)&_logos_method$FlexCloudCommunity$FLInfoDashboardNewsView$willMoveToSuperview$, (IMP*)&_logos_orig$FlexCloudCommunity$FLInfoDashboardNewsView$willMoveToSuperview$);}
        }
        {Class _logos_class$RemoveGoogle$GAI = objc_getClass("GAI"); MSHookMessageEx(_logos_class$RemoveGoogle$GAI, @selector(init), (IMP)&_logos_method$RemoveGoogle$GAI$init, (IMP*)&_logos_orig$RemoveGoogle$GAI$init);}
        {Class _logos_class$FlexLocalization$FLInfoDiagnosticsTableViewController = objc_getClass("FLInfoDiagnosticsTableViewController"); MSHookMessageEx(_logos_class$FlexLocalization$FLInfoDiagnosticsTableViewController, @selector(viewDidLoad), (IMP)&_logos_method$FlexLocalization$FLInfoDiagnosticsTableViewController$viewDidLoad, (IMP*)&_logos_orig$FlexLocalization$FLInfoDiagnosticsTableViewController$viewDidLoad);Class _logos_class$FlexLocalization$FYAccountLoginViewController = objc_getClass("FYAccountLoginViewController"); MSHookMessageEx(_logos_class$FlexLocalization$FYAccountLoginViewController, @selector(buttonWithLabel:andSelector:), (IMP)&_logos_method$FlexLocalization$FYAccountLoginViewController$buttonWithLabel$andSelector$, (IMP*)&_logos_orig$FlexLocalization$FYAccountLoginViewController$buttonWithLabel$andSelector$);MSHookMessageEx(_logos_class$FlexLocalization$FYAccountLoginViewController, @selector(viewDidLoad), (IMP)&_logos_method$FlexLocalization$FYAccountLoginViewController$viewDidLoad, (IMP*)&_logos_orig$FlexLocalization$FYAccountLoginViewController$viewDidLoad);MSHookMessageEx(_logos_class$FlexLocalization$FYAccountLoginViewController, @selector(registerUISetup), (IMP)&_logos_method$FlexLocalization$FYAccountLoginViewController$registerUISetup, (IMP*)&_logos_orig$FlexLocalization$FYAccountLoginViewController$registerUISetup);Class _logos_class$FlexLocalization$FYTabBarItemView = objc_getClass("FYTabBarItemView"); MSHookMessageEx(_logos_class$FlexLocalization$FYTabBarItemView, @selector(label), (IMP)&_logos_method$FlexLocalization$FYTabBarItemView$label, (IMP*)&_logos_orig$FlexLocalization$FYTabBarItemView$label);Class _logos_class$FlexLocalization$FYUISegmentedBar = objc_getClass("FYUISegmentedBar"); MSHookMessageEx(_logos_class$FlexLocalization$FYUISegmentedBar, @selector(buttonWithTitle:), (IMP)&_logos_method$FlexLocalization$FYUISegmentedBar$buttonWithTitle$, (IMP*)&_logos_orig$FlexLocalization$FYUISegmentedBar$buttonWithTitle$);Class _logos_class$FlexLocalization$FLPatchesViewController = objc_getClass("FLPatchesViewController"); MSHookMessageEx(_logos_class$FlexLocalization$FLPatchesViewController, @selector(loadView), (IMP)&_logos_method$FlexLocalization$FLPatchesViewController$loadView, (IMP*)&_logos_orig$FlexLocalization$FLPatchesViewController$loadView);Class _logos_class$FlexLocalization$FLPatchAddViewController = objc_getClass("FLPatchAddViewController"); MSHookMessageEx(_logos_class$FlexLocalization$FLPatchAddViewController, @selector(loadView), (IMP)&_logos_method$FlexLocalization$FLPatchAddViewController$loadView, (IMP*)&_logos_orig$FlexLocalization$FLPatchAddViewController$loadView);Class _logos_class$FlexLocalization$FLPatchEditViewController = objc_getClass("FLPatchEditViewController"); MSHookMessageEx(_logos_class$FlexLocalization$FLPatchEditViewController, @selector(loadView), (IMP)&_logos_method$FlexLocalization$FLPatchEditViewController$loadView, (IMP*)&_logos_orig$FlexLocalization$FLPatchEditViewController$loadView);Class _logos_class$FlexLocalization$FYSharePatchViewController = objc_getClass("FYSharePatchViewController"); MSHookMessageEx(_logos_class$FlexLocalization$FYSharePatchViewController, @selector(loadView), (IMP)&_logos_method$FlexLocalization$FYSharePatchViewController$loadView, (IMP*)&_logos_orig$FlexLocalization$FYSharePatchViewController$loadView);Class _logos_class$FlexLocalization$FLCloudViewController = objc_getClass("FLCloudViewController"); MSHookMessageEx(_logos_class$FlexLocalization$FLCloudViewController, @selector(viewDidLoad), (IMP)&_logos_method$FlexLocalization$FLCloudViewController$viewDidLoad, (IMP*)&_logos_orig$FlexLocalization$FLCloudViewController$viewDidLoad);Class _logos_class$FlexLocalization$FLInfoViewController = objc_getClass("FLInfoViewController"); MSHookMessageEx(_logos_class$FlexLocalization$FLInfoViewController, @selector(viewDidLoad), (IMP)&_logos_method$FlexLocalization$FLInfoViewController$viewDidLoad, (IMP*)&_logos_orig$FlexLocalization$FLInfoViewController$viewDidLoad);}
    }
}
