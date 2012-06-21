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

Static Library Note:
If you're using the static library libios_file_browser.a in your project, you'll
need to add the linker flag "-all_load" to the "other linker flags" option in
your application's build settings.

******************************************************************************
License - MIT
******************************************************************************

Copyright (c) 2011 pixelrvision

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
