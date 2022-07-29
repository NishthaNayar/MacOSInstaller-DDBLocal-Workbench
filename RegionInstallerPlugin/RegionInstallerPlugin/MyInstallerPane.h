//
//  MyInstallerPane.h
//  RegionInstallerPlugin
//
//  Created by Nayar, Nishtha on 7/28/22.
//

#import <Cocoa/Cocoa.h>
#import <InstallerPlugins/InstallerPlugins.h>

@interface MyInstallerPane : InstallerPane
{
    IBOutlet NSPopUpButton *uiRegion;
    
}

@end
