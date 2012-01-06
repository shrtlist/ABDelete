## ABDelete
Demo of ABPersonViewController with address book contact deletion.

The default ABPersonViewController only allows editing, not deletion. Contact deletion is implemented via method swizzling. Using the dynamic runtime, we swap out an existing method implementation with our own and then call the original implementation.

Note that in the simulator, the ABPeoplePickerNavigationController's tableview does not appear to get refreshed after a deletion. This may be due to differences between the device framework and the Simulator framework.

## Build requirements
Xcode 4.2, iOS 5.0 SDK, LLVM Compiler 3.0, Automated Reference Counting (ARC).

## Runtime requirements
iOS 3.0 and later

## License
The source code is available under the Apache License, Version 2.0
