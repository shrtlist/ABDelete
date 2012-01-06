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

#import "AppDelegate.h"
#import "UIActionSheet+Dismiss.h"

@implementation AppDelegate

@synthesize window;
@synthesize picker;
@synthesize personViewController;

#pragma mark - UIApplicationDelegate conformance

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Register for notifications when the an address book contact is deleted
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(dismissPersonViewController) 
                                                 name:kAddressBookContactDeleted object:nil];

    // Instantiate the picker and set its delegate
    self.picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    // Instantiate the person view controller and set its properties
    self.personViewController = [[ABPersonViewController alloc] init];
    personViewController.personViewDelegate = self;
    personViewController.allowsEditing = YES;
    
    @try
    {
        [personViewController setValue:[NSNumber numberWithBool:YES] forKey:@"allowsActions"];
        
        // Display the "Delete" and "Cancel" buttons
        [personViewController setValue:[NSNumber numberWithBool:YES] forKey:@"allowsDeletion"];
    }
    @catch (NSException * e)
    {
        // Ignore any exception
    }

    [window setRootViewController:picker];
    [window makeKeyAndVisible];
    
    return YES;
}


#pragma mark - Show and dismiss the ABPersonViewController

- (void)showPersonViewController:(ABRecordRef)person
{	
    personViewController.displayedPerson = person;
	[self.picker pushViewController:personViewController animated:YES];
}

- (void)dismissPersonViewController
{
    [picker dismissModalViewControllerAnimated:YES];

#if TARGET_IPHONE_SIMULATOR
    NSLog(@"Simulator: table view not refreshed.");
#endif
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate conformance

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)picker shouldContinueAfterSelectingPerson:(ABRecordRef)person
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
}

#pragma mark - ABPersonViewControllerDelegate conformance

- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue
{
    // Allow the default action to occur.
	return YES;
}

@end
