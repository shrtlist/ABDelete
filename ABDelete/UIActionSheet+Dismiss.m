/*
 * Copyright 2012 shrtlist.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <objc/runtime.h>

NSString *kAddressBookContactDeleted = @"kAddressBookContactDeleted";

typedef void (*ActionSheetDismissFuncPtr)(UIActionSheet *, SEL, NSUInteger, BOOL);

static ActionSheetDismissFuncPtr originalUIActionSheetDismiss;

static void MyUIActionSheetDismiss(UIActionSheet *self, SEL _cmd, NSUInteger buttonIndex, BOOL animated);

@implementation UIActionSheet (Dismiss)

+ (void)load
{
	// Make pool the active autorelease pool for code that follows.
	@autoreleasepool
    {
        // Replace the implementation of dismissWithClickedButtonIndex:animated:
        // with MyUIActionSheetDismiss
        originalUIActionSheetDismiss = (ActionSheetDismissFuncPtr)class_replaceMethod(
		[UIActionSheet class],
		NSSelectorFromString(@"dismissWithClickedButtonIndex:animated:"),
		(IMP)MyUIActionSheetDismiss,
		[[NSString stringWithFormat:@"v@:%s%s", @encode(NSUInteger), @encode(BOOL)] UTF8String]);
	}
}

@end

static void MyUIActionSheetDismiss(UIActionSheet *self, SEL _cmd, NSUInteger buttonIndex, BOOL animated)
{
    // Check if this is the "Delete Contact" button on the action sheet.
    if (buttonIndex == self.destructiveButtonIndex)
    {
        // Post kAddressBookContactDeleted notification here
        [[NSNotificationCenter defaultCenter] postNotificationName:kAddressBookContactDeleted 
                                                            object:self 
                                                          userInfo:nil];
    }

    // Call the original implementation.
    (*originalUIActionSheetDismiss)(self, _cmd, buttonIndex, animated);
}