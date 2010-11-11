#import "IphoneExampleViewController.h"

@implementation IphoneExampleViewController

- (void)viewDidLoad{
	defaultText = [NSString stringWithString:savedText.text];
	[defaultText retain];
	savedText.delegate = self;
}

- (IBAction)saveText{
	[loadedText resignFirstResponder];
	[savedText resignFirstResponder];
	PXRFileBrowser *fb = [[PXRFileBrowser alloc] initWithNibName:@"PXRFileBrowser" bundle:nil];
	fb.delegate = self;
	[self presentModalViewController:fb animated:true];
	NSData *fileData = [savedText.text dataUsingEncoding:NSASCIIStringEncoding];
	[fb saveFile:fileData withType:@"txt" andDefaultFileName:@"Default File Name"];
	[fb release];
}

- (IBAction)loadText{
	[loadedText resignFirstResponder];
	[savedText resignFirstResponder];
	PXRFileBrowser *fb = [[PXRFileBrowser alloc] initWithNibName:@"PXRFileBrowser" bundle:nil];
	fb.delegate = self;
	[self presentModalViewController:fb animated:true];
	[fb browseForFileWithType:@"txt"];
	[fb release];
}

- (void)fileBrowserFinishedPickingFile:(NSData*)file withName:(NSString*)fileName{
	NSString *output = [[NSString alloc] initWithData:file encoding:NSASCIIStringEncoding];
	loadedText.text = output;
	[output release];
}

- (void)fileBrowserCanceledPickingFile{
	NSLog(@"Cancelled picking file.");
}

- (void)fileBrowserFinishedSavingFileNamed:(NSString*)fileName{
	NSLog(@"Saved file with name: %@", fileName);
}

- (void)fileBrowserCanceledSavingFile:(NSData*)file{
	NSLog(@"Cancelled saving file.");
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
	if([savedText.text isEqualToString:defaultText]){
		savedText.text = @"";
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
	return YES;
}

- (void)dealloc {
	[defaultText release];
    [super dealloc];
}

@end
