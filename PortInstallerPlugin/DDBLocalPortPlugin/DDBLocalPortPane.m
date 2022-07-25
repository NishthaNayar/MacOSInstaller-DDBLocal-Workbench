/*
	Copyright: 	© Copyright 2006 Apple Computer, Inc. All rights reserved.

	Disclaimer:	IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
				("Apple") in consideration of your agreement to the following terms, and your
				use, installation, modification or redistribution of this Apple software
				constitutes acceptance of these terms.  If you do not agree with these terms,
				please do not use, install, modify or redistribute this Apple software.

				In consideration of your agreement to abide by the following terms, and subject
				to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
				copyrights in this original Apple software (the "Apple Software"), to use,
				reproduce, modify and redistribute the Apple Software, with or without
				modifications, in source and/or binary forms; provided that if you redistribute
				the Apple Software in its entirety and without modifications, you must retain
				this notice and the following text and disclaimers in all such redistributions of
				the Apple Software.  Neither the name, trademarks, service marks or logos of
				Apple Computer, Inc. may be used to endorse or promote products derived from the
				Apple Software without specific prior written permission from Apple.  Except as
				expressly stated in this notice, no other rights or licenses, express or implied,
				are granted by Apple herein, including but not limited to any patent rights that
				may be infringed by your derivative works or by other works in which the Apple
				Software may be incorporated.

				The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
				WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
				WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
				PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
				COMBINATION WITH YOUR PRODUCTS.

				IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
				CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
				GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
				ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
				OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
				(INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
				ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "DDBLocalPortPane.h"

/*
	Important:	(1)	Remember to always compile your plugins as a universal binary.
				(2)	Also be aware that informed end-users can remove your package's Plugins directory and/or
					change your package's InstallerSections.plist file to remove custom plugins from its flow.
					So plugins *cannot* serve as effective gatekeepers to prevent installation.
*/

@implementation DDBLocalPortPane

#pragma mark private methods
/* test all textfields to if they all have at least one character in them */
- (BOOL)_entriesAreValid
{
	if (	([[uiAccessKeyID stringValue] length] == 0) ||
			([[uiSecretAccessKeyID stringValue] length] == 0) ||
			([[uiRegion stringValue] length] == 0) ||
			([[uiOutputFormat stringValue] length] == 0) )
	{
		return NO;
	}
	
	return YES;
}
- (BOOL)_serialNumberIsValid
{
    return YES;
}

/* enable the "Continue" button if "_entriesAreValid" returns 'YES' */
- (void)_updateNextButtonState
{
	[self setNextEnabled:[self _entriesAreValid]];
}

/* localization helper method:  This pulls localized strings from the plugin's bundle */
- (NSString *)_localizedStringForKey:(NSString *)key
{
	return [[NSBundle bundleForClass:[self class]] localizedStringForKey:key value:@"" table:nil];
}

/////////////////////////////////////////////////
#pragma mark InstallerPane overrides
/* return the title of this pane */
- (NSString *)title
{
	return [self _localizedStringForKey:@"Title"];
}

/* pane's entry point: code called when user enters this pane */
- (void)didEnterPane:(InstallerSectionDirection)dir
{
	[self _updateNextButtonState];
}

/* called when user clicks "Continue" -- return value indicates if application should exit pane */
- (BOOL)shouldExitPane:(InstallerSectionDirection)dir
{

    NSArray *paths = NSSearchPathForDirectoriesInDomains
            (NSDesktopDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];

        //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/AWSConfigTmp.txt",documentsDirectory];
        //create content - four lines of text
    NSString *content = [NSString stringWithFormat: @"%@\n%@\n%@\n%@\n", [uiAccessKeyID stringValue], [uiSecretAccessKeyID stringValue],[uiRegion stringValue],[uiOutputFormat stringValue]];
        //save content to the documents directory
        [content writeToFile:fileName
                         atomically:NO
                               encoding:NSStringEncodingConversionAllowLossy
                                      error:nil];
    
	return YES;
}

/////////////////////////////////////////////////
#pragma mark NSControl delegate methods
/* updates the state of the next button when the contents of the delegate textfields change */
- (void)controlTextDidChange:(NSNotification *)notification
{
	[self _updateNextButtonState];
}

@end
