## ABPersonViewController+Delete
A category on `ABPersonViewController` that supports address book contact deletion (default `ABPersonViewController` only supports editing). This category does not use any private methods.

## Usage
    #import "ABPersonViewController+Delete.h"
    #import <AddressBookUI/ABPeoplePickerNavigationController.h>
    
    // Instantiate the peoplePicker and set its delegate
    self.peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    self.peoplePicker.peoplePickerDelegate = self;
    // Instantiate the ABPersonViewController+Delete category and set its properties
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.personViewDelegate = self;
    personViewController.allowsEditing = YES;
    personViewController.displayedPerson = person;

    // Show the ABPersonViewController instance
    [self.peoplePicker pushViewController:personViewController animated:YES];

Note that in Simulator, `ABPeoplePickerNavigationController` does not appear to get refreshed after a deletion. This may be due to differences between the device framework and the Simulator framework.

## Build requirements
Xcode 4.2, iOS 5.0 SDK, LLVM Compiler 3.0, Automated Reference Counting (ARC).

## Deployment target
iOS 4.3

## License
The source code is available under the Apache License, Version 2.0

## Contributing
Forks, patches and other feedback are always welcome.