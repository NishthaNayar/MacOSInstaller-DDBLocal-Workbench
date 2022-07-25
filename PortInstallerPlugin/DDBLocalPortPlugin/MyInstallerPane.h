//
//  MyInstallerPane.h
//  DDBLocalPortPlugin
//
//  Created by Nayar, Nishtha on 7/20/22.
//


#import <Cocoa/Cocoa.h>
#import <InstallerPlugins/InstallerPlugins.h>

@interface MyInstallerPane : InstallerPane
{
    IBOutlet NSTextField *        uiPortNum;
}

@end
