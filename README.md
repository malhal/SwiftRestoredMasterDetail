# SwiftRestoredMasterDetail

A sample project showing the UI state restoration code for the master detail template. It works for restoration to either portrait on landscape regardless of orientation it was preserved in. Except not in iOS 13b1 because of a bug in the new panel implementation of the split controller (FB6126906). 

## What was added:

Restoration identifiers in the storyboard view controllers and table view.

AppDelegate changed to use willFinishLaunching and window.makeKeyAnd Visible.

shouldSaveApplicationState and shouldRestoreApplicationState in AppDelegate.

viewControllerWithRestorationIdentifierPath added to AppDelegate to assist with finding the view controller that was created by the storyboard in the case were it was preserved in a different orientation and thus the path is different because the split view controller was in a different layout.

UIDataSourceModelAssociation implemented on the Master.

encodeRestorableState and decodeRestorableState implemented in the Master and Detail.

UIApplication.registerObject for the context in the AppDelegate so it can be used in the Detail.

Capturing initalDetailNavigationController in the willFinishLaunching so it can be used by viewControllerWithRestorationIdentifierPath for use in the case of when the app is launched in portrait and the secondary is immediately disgarded (but it is retained by the split in its private preservedDetailController property) so it can be restored and then is used on the next seperate to landscape.

detailViewController = controller added to the Master's prepareForSegue (why do Apple not have this? given they set it to the intial one in viewDidLoad)
