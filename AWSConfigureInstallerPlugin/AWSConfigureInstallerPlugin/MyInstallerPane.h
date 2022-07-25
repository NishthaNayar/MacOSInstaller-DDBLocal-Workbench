//
//  MyInstallerPane.h
//  AWSConfigureInstallerPlugin
//
//  Created by Nayar, Nishtha on 7/21/22.
//

#import <Cocoa/Cocoa.h>
#import <InstallerPlugins/InstallerPlugins.h>

@interface MyInstallerPane : InstallerPane
{
    IBOutlet NSTextField *        uiAccessKeyID;
    IBOutlet NSTextField *        uiSecretAccessKeyID;
    IBOutlet NSTextField *        uiRegion;
    IBOutlet NSTextField *        uiOutputFormat;
}

@end
