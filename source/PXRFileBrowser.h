
#import <UIKit/UIKit.h>

@class PXRFileBrowserTableData;
@class PXRFileBrowser;

typedef enum {
	kPXRFileBrowserModeSave,
	kPXRFileBrowserModeLoad
} kPXRFileBrowserMode;

@protocol PXRFileBrowserDelegate
- (void)fileBrowserFinishedPickingFile:(NSData*)file withName:(NSString*)fileName;
- (void)fileBrowserCanceledPickingFile;
- (void)fileBrowserFinishedSavingFileNamed:(NSString*)fileName;
- (void)fileBrowserCanceledSavingFile:(NSData*)file;
@end

@interface PXRFileBrowser : UIViewController <UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate>{
	NSString *currentPath;
	NSObject <PXRFileBrowserDelegate> *delegate;
	NSMutableArray *paths;
	NSData *fileToSave;
	NSString *fileTypeToUse;
	
	NSArray *fileTypes;
	
	UITextField *fileNameField;
	UIButton *saveButton;
	UITableView *fileTableView;
	UILabel *folderContents;
	UILabel *folderTitle;
	UIView *folderDialog;
	UIButton *backButton;
	UITextField *folderNameField;
	UIView *saveOptions;
	
	float frameWidth;
	float frameHeight;
	BOOL isEditingText;
	
	CGRect iphonePortraitNormal;
	CGRect iphonePortraitEditing;
	CGRect iphoneLandscapeNormal;
	CGRect iphoneLandscapeEditing;
	CGRect ipadPortraitNormal;
	CGRect ipadPortraitEditing;
	CGRect ipadLandscapeNormal;
	CGRect ipadLandscapeEditing;
	
	kPXRFileBrowserMode browserMode;
	PXRFileBrowserTableData *tableData;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) IBOutlet UITextField *fileNameField;
@property (nonatomic, retain) NSString *currentPath;
@property (nonatomic, retain) IBOutlet UITableView *fileTableView;
@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) IBOutlet UILabel *folderContents;
@property (nonatomic, retain) IBOutlet UILabel *folderTitle;
@property (nonatomic, retain) IBOutlet UITextField *folderNameField;
@property (nonatomic, retain) IBOutlet UIView *saveOptions;
@property (nonatomic, retain) IBOutlet UIView *folderDialog;

// these methods are public
- (void)saveFile:(NSData*)file withType:(NSString*)fileType andDefaultFileName:(NSString*)defaultName;
- (void)browseForFileWithType:(NSString*)fileType;
- (void)browseForFileWithTypes:(NSArray*)ft;
- (IBAction)cancel;

// these methods should be considered protected
- (void)setup;
- (void)resetPath;
- (void)refreshView;
- (void)openFolderNamed:(NSString*)folderName;
- (void)writeFolderToDisk;
- (IBAction)writeFileToDisk;
- (IBAction)loadFileFromDisk:(NSString*)path;
- (IBAction)newFolder;
- (IBAction)back;

- (void)confirmedFileOverWrite;
- (void)confirmedFolderOverWrite;

- (IBAction)fileNameBeganEditing;
- (IBAction)fileNameEndedEditing;

- (IBAction)folderNameBeganEditing;
- (IBAction)folderNameEndedEditing;

- (BOOL)fileShouldBeHidden:(NSString*)fileName;

- (void)initSizings;
- (void)updateSizeForCurrentOrientation;
- (void)delayedResize:(NSTimer*)timer;

@end
