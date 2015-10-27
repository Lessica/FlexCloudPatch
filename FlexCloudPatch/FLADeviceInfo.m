//
//  FLADeviceInfo.m
//  FlexCloudPatch
//
//  Created by Zheng on 10/25/15.
//
//

#import "FLADeviceInfo.h"
#import <sys/types.h>
#import <sys/sysctl.h>
#import <mach/mach_host.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <ifaddrs.h>
#import <sys/socket.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <ifaddrs.h>
#import <IOKit/IOKitLib.h>

#if SUPPORTS_IOKIT_EXTENSIONS

#pragma mark IOKit miniheaders

#define kIODeviceTreePlane        "IODeviceTree"


CFTypeRef  IORegistryEntrySearchCFProperty(
                                           io_registry_entry_t    entry,
                                           const io_name_t        plane,
                                           CFStringRef            key,
                                           CFAllocatorRef         allocator,
                                           IOOptionBits           options );

kern_return_t  IOMasterPort( mach_port_t  bootstrapPort, mach_port_t* masterPort );

io_registry_entry_t  IORegistryGetRootEntry(mach_port_t    masterPort );

CFTypeRef IORegistryEntrySearchCFProperty(io_registry_entry_t entry,
                                          const io_name_t     plane,
                                          CFStringRef         key,
                                          CFAllocatorRef        allocator,
                                          IOOptionBits        options );



kern_return_t   mach_port_deallocate(ipc_space_t task, mach_port_name_t name);

@implementation FLADeviceInfo

#pragma mark IOKit Utils

NSArray *getValue(NSString *iosearch)
{
    mach_port_t          masterPort;
    
    CFTypeID             propID = (CFTypeID) NULL;
    
    unsigned long        bufSize;
    
    kern_return_t kr = IOMasterPort(MACH_PORT_NULL, &masterPort);
    
    if (kr != noErr) return nil;
    
    io_registry_entry_t entry = IORegistryGetRootEntry(masterPort);
    
    if (entry == MACH_PORT_NULL) return nil;
    
    CFTypeRef prop = IORegistryEntrySearchCFProperty(entry,kIODeviceTreePlane, (__bridge CFStringRef) iosearch, nil,kIORegistryIterateRecursively);
    
    if (!prop) return nil;
    
    propID = CFGetTypeID(prop);
    
    if (!(propID == CFDataGetTypeID()))
    {
        mach_port_deallocate(mach_task_self(), masterPort);
        CFRelease(prop);
        return nil;
    }
    
    CFDataRef propData = (CFDataRef) prop;
    
    if (!propData) return nil;
    
    bufSize = CFDataGetLength(propData);
    if (!bufSize){
        CFRelease(prop);
        return nil;
    }
    
    NSString *p1 = [[NSString alloc]initWithBytes:CFDataGetBytePtr(propData) length:bufSize encoding:NSUTF8StringEncoding];
    
    mach_port_deallocate(mach_task_self(), masterPort);
    CFRelease(prop);
    
    return [p1 componentsSeparatedByString:@"/0"];
}



+ (NSString *)imei
{
    NSArray *results = getValue(@"device-imei");
    
    NSString* ret = nil;
    if (results)
    {
        NSString *string_content = [results objectAtIndex:0];
        const char *char_content = [string_content UTF8String];
        ret = [[NSString alloc] initWithCString:(const char*)char_content  encoding:NSUTF8StringEncoding];
    }
    
    if(ret == nil) return @"000000000000000";
    
    return ret;
}

+ (NSString *)serialnumber
{
    NSArray *results = getValue(@"serial-number");
    
    NSString* ret = nil;
    if (results)
    {
        NSString *string_content = [results objectAtIndex:0];
        const char *char_content = [string_content UTF8String];
        ret = [[NSString alloc] initWithCString:(const char*)char_content  encoding:NSUTF8StringEncoding];
    }
    
    if(ret == nil) return @"00000000000";
    
    return ret;
}


+ (NSString *)batterysn
{
    CFMutableDictionaryRef matching , properties = NULL;
    io_registry_entry_t entry = 0;
    matching = IOServiceMatching( "IOPMPowerSource" );
    entry = IOServiceGetMatchingService( kIOMasterPortDefault , matching );
    IORegistryEntryCreateCFProperties( entry , &properties , NULL , 0 );
    NSString* ret = @"";
    NSString* value = (NSString*)CFDictionaryGetValue(properties, CFSTR("Serial"));
    if (value)
        ret = [NSString stringWithString:value];
    
    CFRelease( properties );
    IOObjectRelease( entry );
    
    return ret;
}


@end

#endif
