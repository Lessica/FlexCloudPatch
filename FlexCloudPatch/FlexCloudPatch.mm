#line 1 "/Users/Zheng/Desktop/FlexCloudPatch/FlexCloudPatch/FlexCloudPatch.xm"
#import "FLADevice.h"
#import "FLAClient.h"
#import <UIKit/UIKit.h>

#include <logos/logos.h>
#include <substrate.h>
@class FLInfoDashboardViewController; @class FLAResource; @class GAI; @class FLInfoDashboardNewsView; @class FLANotice; @class FLXTLSManager; 

static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$FLANotice(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("FLANotice"); } return _klass; }
#line 5 "/Users/Zheng/Desktop/FlexCloudPatch/FlexCloudPatch/FlexCloudPatch.xm"
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
                                    NSString *remote_tips = [resp_obj objectForKeyedSubscript:@"result"];
                                    if (remote_tips != nil && [remote_tips isKindOfClass:[NSString class]]) {
                                        [label setText:remote_tips];
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



static __attribute__((constructor)) void _logosLocalCtor_14742edd() {
    {Class _logos_class$FlexCloudDevice$FLAResource = objc_getClass("FLAResource"); MSHookMessageEx(_logos_class$FlexCloudDevice$FLAResource, @selector(uniqueDeviceID), (IMP)&_logos_method$FlexCloudDevice$FLAResource$uniqueDeviceID, (IMP*)&_logos_orig$FlexCloudDevice$FLAResource$uniqueDeviceID);}
    {Class _logos_class$FlexCloudApi$FLAResource = objc_getClass("FLAResource"); MSHookMessageEx(_logos_class$FlexCloudApi$FLAResource, @selector(apiURL), (IMP)&_logos_method$FlexCloudApi$FLAResource$apiURL, (IMP*)&_logos_orig$FlexCloudApi$FLAResource$apiURL);Class _logos_class$FlexCloudApi$FLXTLSManager = objc_getClass("FLXTLSManager"); Class _logos_metaclass$FlexCloudApi$FLXTLSManager = object_getClass(_logos_class$FlexCloudApi$FLXTLSManager); MSHookMessageEx(_logos_metaclass$FlexCloudApi$FLXTLSManager, @selector(clientData), (IMP)&_logos_meta_method$FlexCloudApi$FLXTLSManager$clientData, (IMP*)&_logos_meta_orig$FlexCloudApi$FLXTLSManager$clientData);MSHookMessageEx(_logos_metaclass$FlexCloudApi$FLXTLSManager, @selector(authData), (IMP)&_logos_meta_method$FlexCloudApi$FLXTLSManager$authData, (IMP*)&_logos_meta_orig$FlexCloudApi$FLXTLSManager$authData);}
    {Class _logos_class$FlexCloudCommunity$FLAResource = objc_getClass("FLAResource"); { Class _logos_class$FlexCloudCommunity$FLANotice = objc_allocateClassPair(_logos_class$FlexCloudCommunity$FLAResource, "FLANotice", 0); objc_registerClassPair(_logos_class$FlexCloudCommunity$FLANotice); MSHookMessageEx(_logos_class$FlexCloudCommunity$FLANotice, @selector(resourceAction), (IMP)&_logos_method$FlexCloudCommunity$FLANotice$resourceAction, (IMP*)&_logos_orig$FlexCloudCommunity$FLANotice$resourceAction); }Class _logos_class$FlexCloudCommunity$FLInfoDashboardViewController = objc_getClass("FLInfoDashboardViewController"); MSHookMessageEx(_logos_class$FlexCloudCommunity$FLInfoDashboardViewController, @selector(titleForView:), (IMP)&_logos_method$FlexCloudCommunity$FLInfoDashboardViewController$titleForView$, (IMP*)&_logos_orig$FlexCloudCommunity$FLInfoDashboardViewController$titleForView$);Class _logos_class$FlexCloudCommunity$FLInfoDashboardNewsView = objc_getClass("FLInfoDashboardNewsView"); MSHookMessageEx(_logos_class$FlexCloudCommunity$FLInfoDashboardNewsView, @selector(willMoveToSuperview:), (IMP)&_logos_method$FlexCloudCommunity$FLInfoDashboardNewsView$willMoveToSuperview$, (IMP*)&_logos_orig$FlexCloudCommunity$FLInfoDashboardNewsView$willMoveToSuperview$);}
    {Class _logos_class$RemoveGoogle$GAI = objc_getClass("GAI"); MSHookMessageEx(_logos_class$RemoveGoogle$GAI, @selector(init), (IMP)&_logos_method$RemoveGoogle$GAI$init, (IMP*)&_logos_orig$RemoveGoogle$GAI$init);}
}
