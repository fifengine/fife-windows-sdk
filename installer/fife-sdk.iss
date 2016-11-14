;
;          _\|/_
;          (o o)
; +-----oOO-{_}-OOo------------------------------------------------------+
; |                                                                      |
; |  Flexible Isometric Free Engine - Inno Setup Script File             |
; |  -------------------------------------------------------             |
; |                                                                      |
; |  Author:   Jens A. Koch <jakoch@web.de>                              |
; |  License:  MIT                                                       |
; |                                                                      |
; |  For the full copyright and license information, please view         |
; |  the LICENSE file that was distributed with this source code.        |
; |                                                                      |
; |  Note for developers                                                 |
; |  -------------------                                                 |
; |  A good resource for developing and understanding                    |
; |  Inno Setup Script files is the official "Inno Setup Help".          |
; |  Website:  http://jrsoftware.org/ishelp/index.php                    |
; |                                                                      |
; +---------------------------------------------------------------------<3

; version is set here, when the version isn't passed to the compiler on invocation
#ifndef APP_VERSION
#define APP_VERSION          "0.0.1"
#endif

#define APP_NAME             "FifeSDK"
#define APP_COMPILER         "VC14"
#define APP_PUBLISHER        "FIFE Team"
#define APP_URL              "http://fifengine.net/"
#define APP_SUPPORT_URL      "https://github.com/fifengine/fifengine/issues"
#define COPYRIGHT_YEAR        GetDateTimeString('yyyy', '', '');

[Setup]
AppId={{8A27DF0C-689B-4B76-8BFC-AFCDD90C1A31}

; set application meta-data
AppName={#APP_NAME}
AppVerName={#APP_NAME} {#APP_VERSION}
AppVersion={#APP_VERSION}
AppCopyright=© {#APP_PUBLISHER}
AppPublisher={#APP_PUBLISHER}
AppPublisherURL={#APP_URL}
AppSupportURL={#APP_SUPPORT_URL}
AppUpdatesURL={#APP_URL}

; default installation folder is "c:\fife". users might change this via dialog.
DefaultDirName={pf}\FIFE\
DefaultGroupName={#APP_NAME}
DirExistsWarning=No
EnableDirDoesntExistWarning=Yes
AllowNoIcons=yes

; compression
Compression=lzma2/ultra
LZMAUseSeparateProcess=yes
LZMANumBlockThreads=2
InternalCompressLevel=max
SolidCompression=true

; this creates the installer executable in the build folder
; for example: "_build\FifeSDK-0.4.0-Setup-VC14-x86.exe"
OutputBaseFilename={#APP_NAME}-{#APP_VERSION}-Setup-{#APP_COMPILER}-x86
OutputDir=..\_build

; disable wizard pages: Ready
DisableReadyPage=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

; Define the types of installations
; The user gets a drop-down list to select one of these types.
; Selecting a type will selected a set of components.
[Types]
Name: "full";          Description: "Full installation (build-tools, engine, dependencies, demos, tools)"
Name: "build-tools";   Description: "Build-tools only (CMake, Python, Boost, Swig)"
Name: "fife-only";     Description: "Engine only"
Name: "fife-demos";    Description: "Engine and Demos"
Name: "fife-tools";    Description: "Engine and Tools"
Name: "custom";        Description: "Custom installation"; Flags: iscustom

; Define components to install
[Components]
Name: fifengine;       Description: "[fifengine] Fifengine - Isometric Game Engine";    Types: full fife-only fife-demos
Name: dependencies;    Description: "[fifengine] Dependencies";                         Types: full
Name: cmake;           Description: "[build tools] CMake - build system";               Types: full build-tools
Name: "Python";        Description: "[build tools] Python - programming language";    
Name: "Python\py27";   Description: "[build tools] Python v2.7";                        Types: full build-tools; Flags: exclusive
Name: "Python\py35";   Description: "[build tools] Python v3.5";                        Types: full build-tools; Flags: exclusive
Name: swig;            Description: "[build tools] SWIG - interface generator";         Types: full build-tools   
Name: demos;           Description: "[fifengine] Demos";                                Types: full fife-demos

[Files]


[Run]
; Automatically started...