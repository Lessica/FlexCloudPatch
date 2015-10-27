/*
 * iolate <iolate@me.com>
 * 2013. Oct. 5
 *
 * New classes, methods and enums on iOS7
 *
 * I have extracted only what I need.
 * So there are more undocumented classes in IOKit.
 *
 */

#ifdef _IOKIT_HID_IOHIDEVENTTYPES_H

#include <IOKit/hid/IOHIDEventTypes.h>

//Not kIOHIDDigitizerTransducerTypeHand
#define kIOHIDTransducerTypeHand 3

#define kIOHIDEventFieldBuiltIn 4

//  enum {
//      kIOHIDEventFieldDigitizerX = IOHIDEventFieldBase(kIOHIDEventTypeDigitizer),
//      ...
//      kIOHIDEventFieldDigitizerChildEventMask,
//      kIOHIDEventFieldDigitizerDisplayIntegrated // + 25
//  };
#define kIOHIDEventFieldDigitizerDisplayIntegrated 720921

#endif