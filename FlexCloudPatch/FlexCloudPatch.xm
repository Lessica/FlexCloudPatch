#import "FLADevice.h"
#import "FLAClient.h"
#import <UIKit/UIKit.h>

#define currentPatchVersion @"1.990-3"
#define prefsPath @"/private/var/mobile/Library/Preferences/com.darwindev.FlexCloudSettings.plist"

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
%subclass FLANotice : FLAResource // 公告子类
- (NSString *)resourceAction {
    return @"notice";
}
%end
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
        __block id label = [self newsLabel];
        if (label != nil && [label respondsToSelector:@selector(setText:)]) {
            [label setText:tips];
            // 请求远程公告
            id req = [[%c(FLANotice) alloc] init];
            [req loadWithParams:nil
                        success:^(id resp) {
                            if (resp != nil && [resp respondsToSelector:@selector(responseObject)]) {
                                id resp_obj = [resp responseObject];
                                if (resp_obj != nil && [resp_obj respondsToSelector:@selector(objectForKeyedSubscript:)]) {
                                    id result_obj = [resp_obj objectForKeyedSubscript:@"result"];
                                    if (result_obj != nil && [result_obj respondsToSelector:@selector(objectForKeyedSubscript:)]) {
                                        NSString *remote_tips = [resp_obj objectForKeyedSubscript:@"message"];
                                        if (remote_tips != nil && [remote_tips isKindOfClass:[NSString class]]) {
                                            [label setText:remote_tips];
                                        }
                                        /*
                                        NSString *latest_version =[resp_obj objectForKeyedSubscript:@"latestVersion"];
                                        if (latest_version != nil && [latest_version isKindOfClass:[NSString class]]) {
                                            if (![latest_version isEqualToString:currentPatchVersion]) {
                                                [%c(FYUIAlertView) showAlertWithTitle:@"版本更新"
                                                                              message:[NSString stringWithFormat:@"当前版本: %@\n最新版本: %@\n是否前往 Cydia 更新? ", currentPatchVersion, latest_version]
                                                                              buttons:[NSArray arrayWithObjects:@"取消", @"更新", nil]
                                                                           completion:nil];
                                            }
                                        }
                                         */
                                    }
                                }
                            }
                        }
                        failure:nil];
        }
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


%group FlexToCN
//flex2汉化 by jk
%hook FLInfoDiagnosticsTableViewController
- (void *)viewDidLoad
{
    %orig;
    [self setTitle:@"开发者页面"];
    UITableView *tableView = [self tableView];
    NSInteger width = [[UIScreen mainScreen] bounds].size.width;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, 423.0f)];
    NSString *urlString = @"https://cydia.so/";
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    //[tableView setHidden:YES];
    [tableView addSubview:webView];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
%end


%hook FLCloudAppsViewController
- (void *)setType:(id)arg1 {
    %orig;
    if (arg1){
        [self setTitle:@"全部"];
    }else{
        [self setTitle:@"已安装"];
    }
}
%end


%hook FLCloudPatchesViewController
-(id) initWithTitle:(id)arg1 resource:(id)arg2{
    NSString *recent = @"Recent";
    bool zuijin = [arg1 isEqualToString:recent];
    NSString *Popular = @"Popular";
    bool paihang = [arg1 isEqualToString:Popular];
    if (zuijin){
        %orig(@"最近",arg2);
    }else if(paihang){
        %orig(@"排行榜",arg2);
    }else{
        %orig(arg1,arg2);
    }
}
%end


%hook FYAccountLoginViewController
-(id) buttonWithLabel:(id)arg1 andSelector:(id)arg2{
    NSString *Login = @"Login";
    bool islogin = [arg1 isEqualToString:Login];
    NSString *Register = @"Register";
    bool isregister = [arg1 isEqualToString:Register];
    
    if (islogin){
        %orig(@"登陆",arg2);
    }else if(isregister){
        %orig(@"注册",arg2);
    }else {
        %orig(arg1,arg2);
    }
}
%end

/*
 %hook FYSharePatchViewController
 -(id) tableView:(id)arg1 titleForHeaderInSection:(int)arg2{
  if (arg2 == 0){
 return @"补丁名称";
  }else if(arg2 == 1){
 return @"作者";
  }else {
 return @"描述";
  }
 }
 %end
 */



%hook FLInfoDashboardViewController
- (void *)viewDidLoad {
    %orig;
    [self setTitle:@"公告"];
}
%end

%hook FLPatchesViewController
- (void *)loadView {
    %orig;
    [self setTitle:@"补丁"];
}
%end

%hook FLPatchAddViewController
- (void *)loadView {
    %orig;
    [self setTitle:@"选择应用"];
}
%end

%hook FLPatchEditViewController
- (void *)loadView {
    %orig;
    [self setTitle:@"编辑补丁"];
}
%end

%hook FYSharePatchViewController
- (void *)loadView {
    %orig;
    [self setTitle:@"上传补丁"];
}
%end

%hook FYAccountLoginViewController
- (void *)viewDidLoad {
    %orig;
    [self setTitle:@"登陆"];
}

- (id)registerUISetup {
    %orig;
    [self setTitle:@"注册"];
}
%end



%hook FLCloudViewController
- (void *)viewDidLoad {
    %orig;
    [self setTitle:@"中文云端"];
}
%end

%hook FLInfoViewController
- (void *)viewDidLoad {
    %orig;
    [self setTitle:@"关于"];
}
%end


%hook FLCloudPatchDescriptionView
- (void *)sectionTitle {
    return @"描述";
}
%end

%hook FYTabBarItemView
- (id)label {
    %orig;
    UILabel *label = MSHookIvar<UILabel *>(self,"_label");
    if ([label.text isEqualToString:@"patches"]) {
        label.text = @"我的补丁";
    }
    else if ([label.text isEqualToString:@"cloud"])
    {
        label.text = @"云端";
    } else
        if ([label.text isEqualToString:@"info"])
        {
            label.text = @"关于";
        }
    return label;
}
%end
%end




%ctor {
    loadPrefs();
    if (enabled) {
        %init(FlexToCN);
        %init(FlexCloudDevice);
        %init(FlexCloudApi);
        if (checkUpdates) {
            %init(FlexCloudCommunity);
        }
        %init(RemoveGoogle);
    }
}
