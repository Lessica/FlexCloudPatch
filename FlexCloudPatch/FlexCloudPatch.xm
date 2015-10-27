#import "FLADevice.h"
#import "FLAClient.h"
#import <UIKit/UIKit.h>

%group FlexCloudDevice
%hook FLAResource
- (NSString *) uniqueDeviceID {
    return [[FLADevice sharedInstance] uniqueDeviceID];
}
%end
%end

%group FlexCloudApi
%hook FLAResource
- (NSURL *) apiURL {
    return [[FLAClient sharedInstance] apiURL];
}
%end
%hook FLXTLSManager
+ (NSData *)clientData {
    return [[FLAClient sharedInstance] clientData];
}
+ (NSData *)authData {
    return [[FLAClient sharedInstance] authData];
}
%end
%end

%group FlexCloudCommunity
%hook FLInfoDashboardViewController
- (NSString *)titleForView:(UIView *)view {
    if (view == MSHookIvar<UIView *>(self, "_newsView")) {
        return @"最新公告";
    }
    return nil;
}
%end
%hook FLInfoDashboardNewsView
- (void)willMoveToSuperview:(id)superview {
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
                          ]; // 内置公告
        [[self newsLabel] setText:tips];
    }
}
%end
%end

%group RemoveGoogle
%hook GAI
- (id)init {
    return nil;
}
%end
%end

%ctor {
    %init(FlexCloudDevice);
    %init(FlexCloudApi);
    %init(FlexCloudCommunity);
    %init(RemoveGoogle);
}
