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

#import "AppDelegate.h"

@interface AppDelegate () // Class extension
@property (nonatomic, strong) ABPeoplePickerNavigationController *peoplePicker;
@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate protocol conformance

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Instantiate the peoplePicker and set its delegate
    self.peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    self.peoplePicker.peoplePickerDelegate = self;

    [self.window setRootViewController:self.peoplePicker];
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Memory management

- (void)dealloc
{
    self.peoplePicker.peoplePickerDelegate = nil;
}

#pragma mark - Show and dismiss the ABPersonViewController+Delete

- (void)showPersonViewController:(ABRecordRef)person
{
    // Instantiate the ABPersonViewController+Delete category and set its properties
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.personViewDelegate = self;
    personViewController.allowsEditing = YES;
    personViewController.displayedPerson = person;

    // Show the ABPersonViewController instance
	[self.peoplePicker pushViewController:personViewController animated:YES];
}

- (void)dismissPersonViewController
{
    [self.peoplePicker dismissModalViewControllerAnimated:YES];

#if TARGET_IPHONE_SIMULATOR
    NSLog(@"Simulator: table view not refreshed.");
#endif
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate protocol conformance

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{    
    // Displays the information of a selected person
    [self showPersonViewController:person];

	return NO;
}

// Should never be called in this demo, since we return NO above
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
}

// peoplePicker is our root view controller in this demo, so Cancel should do nothing. 
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    NSLog(@"peoplePicker is our root view controller in this demo, so Cancel does nothing.");
}

#pragma mark - ABPersonViewControllerDelegate protocol conformance

- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue
{
    // Allow the default action to occur.
	return YES;
}

@end
