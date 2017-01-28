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
#define APP_VERSION          "0.1.0"
#endif

#define APP_NAME             "FifeSDK"
#define APP_COMPILER         "VC14"
#define APP_PUBLISHER        "FIFE Team"
#define APP_URL              "http://fifengine.net/"
#define APP_SUPPORT_URL      "https://github.com/fifengine/fifengine/issues"
#define COPYRIGHT_YEAR        GetDateTimeString('yyyy', '', '');

[Setup]
AppId={{62CC969E-1D07-44D4-97C8-5BA818F07815}

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
DefaultDirName=c:\fife
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

; style
WizardImageFile=images\WizardImage.bmp
WizardSmallImageFile=images\WizardSmallImage.bmp
SetupIconFile=images\fife.ico
 
; this creates the installer executable in the build folder
; for example: "_build\FifeSDK-0.4.0-Setup-VC14-x86.exe"
OutputBaseFilename={#APP_NAME}-{#APP_VERSION}-Setup-{#APP_COMPILER}-x86
OutputDir=..\_build

; disable wizard pages: Welcome (by default), Ready
DisableReadyPage=yes

; enable wizard pages: Select Destination Location
DisableDirPage=no

; Tell Windows to reload the environment, because Registry change (env PATH change)
ChangesEnvironment=yes

; Tell Windows to reload the environment, because Registry change (file association change: .py)
ChangesAssociations=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

; Define the types of installations
; The user gets a drop-down list to select one of these types.
; Selecting a type will selected a set of components.
[Types]
Name: "full";                       Description: "Full installation (build-tools, engine, dependencies, demos, tools)"
Name: "build-tools";                Description: "Build-tools only (CMake, Python, Boost, Swig)"
Name: "fife-only";                  Description: "Engine only"
Name: "fife-python-demos";          Description: "Engine and Demos (demos)"
Name: "mapeditor";                  Description: "Fife Mapeditor (tools)"
Name: "fifengine-python-tutorials"; Description: "Fife Engine Python Tutorials (tutorials)"
;Name: "fifengine-c++-tutorials";   Description: "Fife Engine C++ Tutorials (tutorials)"
;Name: "fifengine-atlas-creator";   Description: "Fife Engine Atlas Creator (tools)"
;Name: "docs";                      Description: "Fife User and Developer Manuals (doc)"
Name: "custom";                     Description: "Custom installation"; Flags: iscustom

; Define components to install
[Components]
Name: fifengine;       Description: "[fifengine] Fifengine - Isometric Game Engine";    Types: full fife-only
Name: dependencies;    Description: "[fifengine] Dependencies";                         Types: full;
;Name: docs;            Description: "[manuals] Fifengine - Documentations";             Types: full fife-only
Name: mapeditor;       Description: "[dev tools] Fifengine - Mapeditor";                Types: full mapeditor
Name: demos;           Description: "[fifengine] Demos";                                Types: full fife-python-demos
Name: tutorials;       Description: "[tutorials] Tutorials";                            Types: full fifengine-python-tutorials
;Name: tutorials;       Description: "[tutorials] Tutorials";                            Types: full fifengine-python-tutorials fifengine-c++-tutorials
;Name: atlascreator     Description: "[dev tools] Fifengine - Atlas Creator";            Types: full fifengine-atlas-creator
Name: cmake;           Description: "[build tools] CMake - build system";               Types: full build-tools
Name: "Python";        Description: "[build tools] Python - programming language";
Name: "Python\py27";   Description: "[build tools] Python v2.7";                        Types: full build-tools; Flags: exclusive
;Name: "Python\py35";   Description: "[build tools] Python v3.5";                        Types: full build-tools;
Name: swig;            Description: "[build tools] SWIG - interface generator";         Types: full build-tools;
Name: vcredist2015;    Description: "[dep libs] VCRedist2015";                           Types: full fife-only build-tools;

[Files]
Source: "..\repackage\fifengine-includes\*";    DestDir: "{app}\fifengine-dependencies";Flags: recursesubdirs ignoreversion; Components: dependencies
Source: "..\repackage\cmake\*";                 DestDir: "{app}\cmake";                 Flags: recursesubdirs ignoreversion; Components: cmake
Source: "..\repackage\swig\*";                  DestDir: "{app}\swig";                  Flags: recursesubdirs ignoreversion; Components: swig
Source: "..\repackage\Python27\*";              DestDir: "{app}\python";                Flags: recursesubdirs ignoreversion; Components: "Python\py27"
;Source: "..\repackage\Python35\*";              DestDir: "{app}\python";                Flags: recursesubdirs ignoreversion; Components: "Python\py35"
; Fifengine below Python, because we are installing the python library into the Python installation folder
Source: "..\repackage\libfife.win32-py2.7.msi"; DestDir: "{app}\libfife";               Flags: recursesubdirs;               Components: Python\py27 and fifengine
;Source: "..\repackage\libfife.win32-py3.4.msi"; DestDir: "{app}\libfife";               Flags: recursesubdirs;               Components: Python\py27 and fifengine
Source: "..\repackage\mapeditor\*";             DestDir: "{app}\mapeditor";             Flags: recursesubdirs ignoreversion; Components: mapeditor
Source: "..\repackage\python-demos\*";          DestDir: "{app}\python-demos";          Flags: recursesubdirs ignoreversion; Components: demos
Source: "..\repackage\python-tutorials\*";      DestDir: "{app}\python-tutorials";      Flags: recursesubdirs ignoreversion; Components: tutorials
;Source: "..\repackage\fife-c++-tutorials\*";   DestDir: "{app}\cpp-tutorials";          Flags: recursesubdirs ignoreversion; Components: tutorials
;Source: "..\repackage\atlas-creator\*";        DestDir: "{app}\image-atlas-creator";    Flags: recursesubdirs ignoreversion; Components: atlascreator
;Source: "..\repackage\docs\*";                 DestDir: "{app}\docs";                   Flags: recursesubdirs ignoreversion; Components: docs
Source: "..\repackage\vc_redist.x86.exe";       DestDir: "{app}\libfife";               Flags: recursesubdirs;               Components: Python\py27 and fifengine

; Define items to run automatically on installation...
[Run]
; install "libfife for python2.7" only when "py27 and fifengine" are selected + install silently into the target dir
Filename: "msiexec.exe"; Parameters: "/i ""{app}\libfife\libfife.win32-py2.7.msi"" TARGETDIR=""{app}\python"" /qn"; StatusMsg: "Installing libFife for Python2.7"; Components: Python\py27 and fifengine
; install "libfife for python3.4" only when "py34 and fifengine" are selected + install silently into the target dir
;Filename: "msiexec.exe"; Parameters: "/i ""{app}\libfife\libfife.win32-py3.4.msi"" TARGETDIR=""{app}\python"" /qn"; StatusMsg: "Installing libFife for Python3.4"; Components: Python\py27 and fifengine
Filename: "{app}\libfife\vc_redist.x86.exe"; StatusMsg: "VCRedist2015 package"

; Define items to run automatically on un-installation...
[UninstallRun]
; un-install "libfife"
Filename: "msiexec.exe"; Parameters: "/x ""{app}\libfife\libfife.win32-py2.7.msi"" /qn"; StatusMsg: "Uninstalling libFife for Python2.7"; Flags: runascurrentuser runhidden
;Filename: "msiexec.exe"; Parameters: "/x ""{app}\libfife\libfife.win32-py3.4.msi"" /qn"; StatusMsg: "Uninstalling libFife for Python2.7"; Flags: runascurrentuser runhidden

[UninstallDelete]
Type: filesandordirs; Name: "{app}\mapeditor"
Type: filesandordirs; Name: "{app}\python-demos"
Type: filesandordirs; Name: "{app}\python-tutorials"
Type: filesandordirs; Name: "{app}\python"

[Registry]
; A registry change needs the following directive: [SETUP] ChangesEnvironment=yes
;
; add path to Python
;Root: HKCU; Subkey: "Environment"; ValueType:string; ValueName:"PATH"; ValueData:"{olddata};{app}\python"; Flags: preservestringtype; Check: NeedsAddPathLocalUser(ExpandConstant('{app}\python')); Components: Python\py27 or Python\py35;
Root: HKCU; Subkey: "Environment"; ValueType:string; ValueName:"PATH"; ValueData:"{olddata};{app}\python"; Flags: preservestringtype; Check: NeedsAddPathLocalUser(ExpandConstant('{app}\python')); Components: Python\py27;
;
; add path to libfife
Root: HKCU; Subkey: "Environment"; ValueType:string; ValueName:"PATH"; ValueData:"{olddata};{app}\python\Lib\site-packages\fife"; Flags: preservestringtype; Check: NeedsAddPathLocalUser(ExpandConstant('{app}\python\Lib\site-packages\fife')); Components: fifengine;
;
; Create File Association
Root: HKCR; Subkey: ".py";                            ValueType: string; ValueName: ""; ValueData: "Python.File"; Flags: uninsdeletevalue
Root: HKCR; Subkey: "Python.File";                    ValueType: string; ValueName: ""; ValueData: "Python File"; Flags: uninsdeletekey
Root: HKCR; Subkey: "Python.File\DefaultIcon";        ValueType: string; ValueName: ""; ValueData: "{app}\python\DLLs\py.ico"
Root: HKCR; Subkey: "Python.File\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\python\python.exe"" ""%1"" %*"
   
[Code]
// modification and path lookup helper for env PATH 
#include "includes\envpath.iss"

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  // Removing a path from the PATH variable works in 3 steps:
  // 1. get the old env var PATH
  if (CurUninstallStep =  usUninstall) then
  begin
    SaveOldPathLocalUser();
  end;  
  // 2. remove paths from the env var PATH 
  if (CurUninstallStep = usPostUninstall) then
  begin
    RemovePathLocalUser(ExpandConstant('{app}') + '\python\Lib\site-packages\fife');
    RemovePathLocalUser(ExpandConstant('{app}') + '\python');    
    // 3. refresh environment, so that the modified PATH var is activated
    RefreshEnvironment();
  end;
end;
