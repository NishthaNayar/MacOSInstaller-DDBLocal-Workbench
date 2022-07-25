//
//  MyInstallerPane.m
//  DDBLocalPortPlugin
//
//  Created by Nayar, Nishtha on 7/20/22.
//

#import "MyInstallerPane.h"

/*
    Important:    (1)    Remember to always compile your plugins as a universal binary.
                (2)    Also be aware that informed end-users can remove your package's Plugins directory and/or
                    change your package's InstallerSections.plist file to remove custom plugins from its flow.
                    So plugins *cannot* serve as effective gatekeepers to prevent installation.
*/

@implementation MyInstallerPane

#pragma mark private methods
/* test all textfields to if they all have at least one character in them */
- (BOOL)_entriesAreValid
{
    if (    ([[uiPortNum stringValue] length] == 0))
    
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
    NSString *fileName = [NSString stringWithFormat:@"%@/PortNumTmp.txt",documentsDirectory];
        //create content - four lines of text
    NSString *content = [NSString stringWithFormat: @"%@", [uiPortNum stringValue]];
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
