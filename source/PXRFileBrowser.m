#import "PXRFileBrowser.h"
#import "PXRFileBrowserTableData.h"
#import "UIView+Additions.h"

@implementation PXRFileBrowser
@synthesize delegate;
@synthesize fileNameField;
@synthesize currentPath;
@synthesize fileTableView;
@synthesize backButton;
@synthesize folderContents;
@synthesize folderTitle;
@synthesize folderNameField;
@synthesize saveOptions;
@synthesize folderDialog;

- (void)setup{
	paths = [[NSMutableArray alloc] init];
	tableData = [[PXRFileBrowserTableData alloc] init];
	tableData.delegate = self;
	[tableData addSection];
	[self initSizings];
	isEditingText = NO;
}

- (void)initSizings{
	ipadPortraitNormal = CGRectMake(0, 0, 544, 624);
	ipadPortraitEditing = CGRectMake(0, 0, 544, 550);
	ipadLandscapeNormal = CGRectMake(0, 0, 544, 624);
	ipadLandscapeEditing = CGRectMake(0, 0, 544, 396);
	
	if([UIApplication sharedApplication].statusBarHidden){
		iphonePortraitNormal = CGRectMake(0, 0, 320, 480);
		iphonePortraitEditing = CGRectMake(0, 108, 320, 266);
		iphoneLandscapeNormal = CGRectMake(0, 0, 480, 320);
		iphoneLandscapeEditing = CGRectMake(0, 82, 480, 160);
	}else{
		iphonePortraitNormal = CGRectMake(0, 0, 320, 460);
		iphonePortraitEditing = CGRectMake(0, 108, 320, 246);
		iphoneLandscapeNormal = CGRectMake(0, 0, 480, 300);
		iphoneLandscapeEditing = CGRectMake(0, 82, 480, 140);
	}
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	self.modalPresentationStyle = UIModalPresentationFormSheet;
	self.modalInPopover = YES;
	[self setup];
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	self.modalPresentationStyle = UIModalPresentationFormSheet;
	self.modalInPopover = YES;
	[self setup];
	return self;
}


- (void)viewDidLoad{
	fileTableView.delegate = self;
	[fileTableView setDataSource:tableData];
	[self resetPath];
	
	folderDialog.hidden = true;
	
	folderNameField.delegate = self;
	fileNameField.delegate = self;
	
	saveOptions.hidden = (browserMode == kPXRFileBrowserModeLoad);
	
 	[super viewDidLoad];
}

- (void)resetPath{
	[paths removeAllObjects];
	NSString *dirPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
	[paths addObject:dirPath];
	[self refreshView];
}

- (void)refreshView{
	int fileCount = 0;
	[tableData removeAllItemsInSection:0];
	self.currentPath = @"";
	for (NSString *path in paths) {
		self.currentPath = [currentPath stringByAppendingString:path];
	}
	// populate data 
	NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:currentPath error:NULL];
	NSString *currFile;
	BOOL isDir;
	for(NSString *file in files){
		currFile = [currentPath stringByAppendingString:file];
		// send to the table view
		[[NSFileManager defaultManager] fileExistsAtPath:currFile isDirectory:&isDir];
		if(![self fileShouldBeHidden:file] && browserMode == kPXRFileBrowserModeSave){
			// it's not a hidden file so show it
			[tableData addItem:[PXRFileBrowserItem itemWithTitle:file andPath:currFile isDirectory:isDir] toSection:0];
			fileCount ++;
		}else if(![self fileShouldBeHidden:file] && browserMode == kPXRFileBrowserModeLoad){
			NSString *ext = [currFile pathExtension];
			BOOL isFileType = false;
			for(NSString *ft in fileTypes){
				if([ft isEqualToString:ext] || [ft isEqualToString:@"*"]){
					isFileType = true;
				}
			}
			// check the file extention
			PXRFileBrowserItem *item = [PXRFileBrowserItem itemWithTitle:file andPath:currFile isDirectory:isDir];
			if(!isDir){
				item.isSelectable = isFileType;
			}
			[tableData addItem:item toSection:0];
			fileCount ++;
		}
	}
	// check back button
	if(paths.count <= 1){
		backButton.userInteractionEnabled = false;
		backButton.alpha = .2;
	}else {
		backButton.userInteractionEnabled = true;
		backButton.alpha = 1;
	}
	
	if(fileCount == 1) {
		folderContents.text = [NSString stringWithFormat:@"%d item", fileCount]; 
	}else{
		folderContents.text = [NSString stringWithFormat:@"%d items", fileCount]; 
	}
	
	if(paths.count <= 1){
		folderTitle.text = @"Documents";
	}else{
		folderTitle.text = [[paths lastObject] stringByDeletingPathExtension];
	}
	
	[fileTableView reloadData];
}

- (BOOL)fileShouldBeHidden:(NSString*)fileName{
	int max = 1;
	NSRange range = NSMakeRange(0, max);
	if(max <= [fileName length]){
		if([[fileName substringWithRange:range] isEqualToString:@"."]){
			return YES;
		}
	}
	max = 2;
	if(max <= [fileName length]){
		range = NSMakeRange(0, max);
		if([[fileName substringWithRange:range] isEqualToString:@"__"]){
			return YES;
		}
	}
	max = 3;
	if(max <= [fileName length]){
		range = NSMakeRange(0, max);
		if([[fileName substringWithRange:range] isEqualToString:@"tmp"]){
			return YES;
		}
	}
	return NO;
}

- (void)tableView:(UITableView *) aTableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath {
	NSInteger section = [indexPath indexAtPosition:0];
	NSInteger index = [indexPath indexAtPosition:1];
	BOOL isSelectable = [[tableData itemInSection:section atIndex:index] isSelectable];
	if(!isSelectable) return;
	
	NSString *fileTitle = [[tableData itemInSection:section atIndex:index] fileTitle];
	NSString *filePath = [[tableData itemInSection:section atIndex:index] path];
	if([[tableData itemInSection:section atIndex:index] isDirectory]){
		[self openFolderNamed:fileTitle];
	}else if(browserMode == kPXRFileBrowserModeSave){
		NSString *strippedFileName = [[fileTitle lastPathComponent] stringByDeletingPathExtension];
		fileNameField.text = strippedFileName;
	}else if(browserMode == kPXRFileBrowserModeLoad){
		
		[self loadFileFromDisk:filePath];
	}
}

- (void)userWantsToRemoveFileAtPath:(NSString*)path{
	NSLog(@"destroy this file %@", path);
	if([[NSFileManager defaultManager] fileExistsAtPath:path]){
		[[NSFileManager defaultManager] removeItemAtPath:path error:nil];
	}
	[self refreshView];
}


- (IBAction)newFolder{
	folderDialog.hidden = false;
	[folderNameField becomeFirstResponder];
	folderNameField.text = @"";
}

- (void)writeFolderToDisk{
	NSString *newPath = [currentPath stringByAppendingString:folderNameField.text];
	
	NSString *checkEmpty = [folderNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if(checkEmpty.length == 0){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Folder has no name" message:[NSString stringWithFormat:@"A folder name cannot be empty.", fileNameField.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	if([[NSFileManager defaultManager] fileExistsAtPath:newPath]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Folder exists" message:[NSString stringWithFormat:@"A folder with the name \"%@\" already exists.", folderNameField.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	[[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:YES attributes:nil error:NULL];
	[self refreshView];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField{
	if(textField == folderNameField){
		NSLog(@"resign folder name field");
		[folderNameField resignFirstResponder];
	}
	if(textField == fileNameField){
		NSLog(@"resign file name field");
		[fileNameField resignFirstResponder];
	}
	return NO;
}

- (BOOL)textField:( UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    BOOL shouldAllowChange = YES;
	NSMutableString *newReplacement =[[NSMutableString alloc] initWithString:string];
    
	NSCharacterSet *desiredCharacters = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz 1234567890_-*#"];
    for (int i=0; i<[newReplacement length]; i++){
        unichar currentCharacter = [newReplacement characterAtIndex:i];
        if (![desiredCharacters characterIsMember:currentCharacter]) {
            shouldAllowChange = NO;
            [newReplacement deleteCharactersInRange:NSMakeRange(i, 1)];
            i--;
        }
    }
	if(shouldAllowChange){
        [newReplacement release];
        return YES;
    }else{
        [textField setText:[[textField text] stringByReplacingCharactersInRange:range withString:newReplacement ]];
        [newReplacement release];
        return NO;
    }
	return YES;
}

- (void)openFolderNamed:(NSString*)folderName{
	NSString *newDir = [folderName stringByAppendingString:@"/"];
	[paths addObject:newDir];
	self.currentPath = @"";
	for (NSString *path in paths) {
		self.currentPath = [currentPath stringByAppendingString:path];
	}
	[self refreshView];
}

- (IBAction)back{
	if(paths.count <= 1) return;
	[paths removeLastObject];
	for (NSString *path in paths) {
		self.currentPath = [currentPath stringByAppendingString:path];
	}
	[self refreshView];
}

- (IBAction)loadFileFromDisk:(NSString*)path{
	NSData *file = [NSData dataWithContentsOfFile:path];
	if(delegate){
		if([delegate respondsToSelector:@selector(fileBrowserFinishedPickingFile:withName:)]){
			[delegate fileBrowserFinishedPickingFile:file withName:path];
		}
	}
	[self dismissModalViewControllerAnimated:YES];
}

- (void)saveFile:(NSData*)file withType:(NSString*)fileType andDefaultFileName:(NSString*)defaultName{
	saveOptions.hidden = false;
	fileNameField.text = defaultName;
	fileToSave = [file retain];
	fileTypeToUse = [fileType retain];
	browserMode = kPXRFileBrowserModeSave;
}

- (void)browseForFileWithType:(NSString*)fileType{
	saveOptions.hidden = true;
	fileTypeToUse = [fileType retain];
	fileTypes = [NSArray arrayWithObject:fileType];
	[fileTypes retain];
	browserMode = kPXRFileBrowserModeLoad;
	[self resetPath];
}

- (void)browseForFileWithTypes:(NSArray*)ft{
	saveOptions.hidden = true;
	fileTypes = [ft retain];
	browserMode = kPXRFileBrowserModeLoad;
	[self resetPath];
}

- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
	if(buttonIndex == 1 && [alertView.title isEqualToString:@"File exists"]){
		[self confirmedFileOverWrite];
	}
}

- (void)delayedResize:(NSTimer*)timer{
	[self updateSizeForCurrentOrientation];
}

- (void)confirmedFileOverWrite{
	NSString *fileLoc = [currentPath stringByAppendingFormat:@"%@.%@", fileNameField.text, fileTypeToUse];
	[fileToSave writeToFile:fileLoc atomically:YES];
	[fileToSave release];
	[fileTypeToUse release];
	if(delegate){
		if([delegate respondsToSelector:@selector(fileBrowserFinishedSavingFileNamed:)]){
			[delegate fileBrowserFinishedSavingFileNamed:fileLoc];
		}
	}
	[self refreshView];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)confirmedFolderOverWrite{
	NSString *newPath = [currentPath stringByAppendingString:folderNameField.text];
	[[NSFileManager defaultManager] createDirectoryAtPath:newPath withIntermediateDirectories:YES attributes:nil error:NULL];
	[self refreshView];
}

- (IBAction)writeFileToDisk{
	// check for overwrite
	NSString *fileLoc = [currentPath stringByAppendingFormat:@"%@.%@", fileNameField.text, fileTypeToUse];
	
	
	if([[NSFileManager defaultManager] fileExistsAtPath:fileLoc]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"File exists" message:[NSString stringWithFormat:@"A file with the name \"%@\" already exists, are you sure you want to overwrite it?", fileNameField.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert addButtonWithTitle:@"Ok"];
		[alert show];
		[alert release];
		return;
	}
	[fileToSave writeToFile:fileLoc atomically:YES];
	[fileToSave release];
	[fileTypeToUse release];
	if(delegate){
		if([delegate respondsToSelector:@selector(fileBrowserFinishedSavingFileNamed:)]){
			[delegate fileBrowserFinishedSavingFileNamed:fileLoc];
		}
	}
	[self refreshView];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancel{
	if(browserMode == kPXRFileBrowserModeSave){
		if(delegate){
			if([delegate respondsToSelector:@selector(fileBrowserCanceledSavingFile:)]){
				[delegate fileBrowserCanceledSavingFile:fileToSave]; 
			}
		}
		[fileToSave release];
	}else if(browserMode == kPXRFileBrowserModeLoad){
		if(delegate){
			if([delegate respondsToSelector:@selector(fileBrowserCanceledPickingFile:)]){
				[delegate fileBrowserCanceledPickingFile];
			}
		}
	}
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)fileNameBeganEditing{
	if(!isEditingText){
		frameWidth = self.view.frame.size.width;
		frameHeight = self.view.frame.size.height;
	}
	isEditingText = YES;
	[self updateSizeForCurrentOrientation];
}
- (IBAction)fileNameEndedEditing{
	isEditingText = NO;
	[self updateSizeForCurrentOrientation];
}

- (IBAction)folderNameBeganEditing{
	if(!isEditingText){
		frameWidth = self.view.frame.size.width;
		frameHeight = self.view.frame.size.height;
	}
	isEditingText = YES;
	[self updateSizeForCurrentOrientation];
	folderNameField.hidden = false;
}

- (IBAction)folderNameEndedEditing{
	isEditingText = NO;
	[self updateSizeForCurrentOrientation];
	folderDialog.hidden = true;
	[folderNameField resignFirstResponder];
	[self writeFolderToDisk];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
	return YES;
}
/*
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
}
*/

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
	if(isEditingText){
		[self updateSizeForCurrentOrientation];
	}
}

- (void)updateSizeForCurrentOrientation{
	
	NSString *device = [[UIDevice currentDevice] model];
	UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
	if(isEditingText){
		if([device isEqualToString:@"iPhone"] || [device isEqualToString:@"iPhone Simulator"] || [device isEqualToString:@"iPod touch"]){
			if(orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown){
				self.view.bounds = iphonePortraitEditing;
			}else{
				self.view.bounds = iphoneLandscapeEditing;
			}
		}else if([device isEqualToString:@"iPad"] || [device isEqualToString:@"iPad Simulator"]){
			if(orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown){
				self.view.frame = ipadPortraitEditing;
			}else{
				self.view.frame = ipadLandscapeEditing;
			}
		}
	}else{
		if([device isEqualToString:@"iPhone"] || [device isEqualToString:@"iPhone Simulator"] || [device isEqualToString:@"iPod touch"]){
			if(orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown){
				self.view.bounds = iphonePortraitNormal;
			}else{
				self.view.bounds = iphoneLandscapeNormal;
			}
		}else if([device isEqualToString:@"iPad"] || [device isEqualToString:@"iPad Simulator"]){
			if(orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown){
				self.view.frame = ipadPortraitNormal;
			}else{
				self.view.frame = ipadLandscapeNormal;
			}
		}
	}
}

- (void)dealloc {
	if(fileTypes){
		[fileTypes release];
	}
	folderNameField.delegate = nil;
	fileNameField.delegate = nil;
	fileTableView.delegate = nil;
	[paths removeAllObjects];
	[paths release];
	self.fileTableView = nil;
	self.fileNameField = nil;
	self.currentPath = nil;
	self.backButton = nil;
	self.folderContents = nil;
	self.folderTitle = nil;
	self.folderNameField = nil;
	self.folderDialog = nil;
	self.delegate = nil;
    [super dealloc];
}


@end
