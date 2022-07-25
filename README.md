# MacOSInstaller-DDBLocal-Workbench
This repo contains the files required to create a MacOS installer to setup NoSQL Workbench and DDB Local

How to use it?
Get the latest macOS binary for NoSQL Workbench using the electron-builder on the DataModeler project and install it in the Applications directory. Run the following commands to create the installer:

pkgbuild --identifier com.pkg.APPNAME 
--scripts MacOSInstaller-DDBLocal-Workbench-master/Scripts 
--install-location /Applications/ 
--component /Applications/NoSQL\ Workbench.app 
Desktop/WorkbenchDDBLocal.pkg

productbuild --distribution MacOSInstaller-DDBLocal-Workbench-master/dist.xml 
--package-path Desktop --plugins MacOSInstaller-DDBLocal-Workbench-master/Plugins 
--resources MacOSInstaller-DDBLocal-Workbench-master/resourcesInstaller 
Desktop/NoSQLWorkbench_DDBLocal.pkg

For more detailed steps, view this documentation: https://quip-amazon.com/gPlMAYKu4vMH/Single-Installable-Suite-NoSQL-Workbench-DDB-Local

