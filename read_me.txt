------------------------------------------------------------------------------
        __                __                      __         __               
.-----.|__|.--.--..-----.|  |.----..-----..--.--.|__|.-----.|__|.-----..-----.
|  _  ||  ||_   _||  -__||  ||   _||  -__||  |  ||  ||__ --||  ||  _  ||     |
|   __||__||__.__||_____||__||__|  |_____| \___/ |__||_____||__||_____||__|__|
|__|                                                                          
------------------------------------------------------------------------------


******************************************************************************
IOS File Browser
******************************************************************************

What is it?
A file browser for IOS to make saving and loading documents a little more like the desktop.

Setup:
1. Drag the contents of the "source" folder into your project and check "copy items into destination group's folder".
2. Import "PXRFileBrowser.h"

Usage:
The methods to use it are are:
- (void)saveFile:(NSData*)file withType:(NSString*)fileType andDefaultFileName:(NSString*)defaultName;
- (void)browseForFileWithType:(NSString*)fileType;
- (void)browseForFileWithTypes:(NSArray*)ft;

The delegate callbacks are:
- (void)fileBrowserFinishedPickingFile:(NSData*)file withName:(NSString*)fileName;
- (void)fileBrowserCanceledPickingFile;
- (void)fileBrowserFinishedSavingFileNamed:(NSString*)fileName;
- (void)fileBrowserCanceledSavingFile:(NSData*)file;

For saving files call save file with an NSData object, it's file extention and a default name to appear in the file name field.
For loading files pass either an NSArray or string of the file types you want to be able to load.
Set the delegate.  This will notify your class when file saving/loading has been completed.
Present the file browser as a modal view controller.
Release the file browser.

There are examples for iphone and ipad in the "examples" folder.