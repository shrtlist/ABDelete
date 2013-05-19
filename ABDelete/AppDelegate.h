/*
 * Copyright 2013 shrtlist.com
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

#import "ABPersonViewController+Delete.h" // Use the ABPersonViewController+Delete category
#import <AddressBookUI/ABPeoplePickerNavigationController.h>

/*
 * UIApplication's delegate class, the central controller of this demo.
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate, ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ABPeoplePickerNavigationController *picker;

@end
