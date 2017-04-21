# ChangeLog

## [0.3.0]
- added Python 3 Version of fifengine
- added Fifechan Version ??

## [0.2.0]
- added new fifengine version 0.4.1
- added new fifechan version 0.1.4
- added `Visual C++ 2015 Redistributable` to installer
- fixed small bugs

## [0.1.0]

- added `fifengine python 2.7 installer` to installer and enabled auto-run after install
- added `fifengine-dependencies` to installer
- added `Python27` to installer
- added `Python35` to installer
- added `cmake` to installer
- added `swig` to installer
- created build-scripts: download, extract, copy
  - download: `aria2c` is used for downloading. downloads go into the folder `downloads`
  - extract: `7za` is used to extract the downloaded archives into the folder `extracted` 
  - the extracted folders are "name normalized" by moving them into the folder `repackage`
- added `download-list/fifengine.txt`, which contains the download URLs for fifengine and dependencies
- added `download-list/fifengine-build-tools.txt`, which contains the download URLs for build-tools
- added `appveyor.yml` and initalized Appveyor to get continous builds of the installer executable by using the InnoSetup Script compiler (`issc`)
- added basic installer ISS file (`installer/fife-sdk.iss`)
- added build-tools: InnoSetup, 7zip, aria2c
