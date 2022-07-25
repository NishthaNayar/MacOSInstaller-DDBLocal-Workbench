//
//  MyInstallerPane.m
//  AWSConfigureInstallerPlugin
//
//  Created by Nayar, Nishtha on 7/21/22.
//

#import "MyInstallerPane.h"

@implementation MyInstallerPane

#pragma mark private methods
/* test all textfields to if they all have at least one character in them */
- (BOOL)_entriesAreValid
{
    if (    ([[uiAccessKeyID stringValue] length] == 0) ||
            ([[uiSecretAccessKeyID stringValue] length] == 0) ||
            ([[uiRegion stringValue] length] == 0) ||
            ([[uiOutputFormat stringValue] length] == 0) )
    {
        return NO;
    }
    
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
