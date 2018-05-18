;
;          _\|/_
;          (o o)
; +-----oOO-{_}-OOo-----------------------------------------------------------------+
; |                                                                                 |
; |  Flexible Isometric Free Engine - Inno Setup Script File                        |
; |  -------------------------------------------------------                        |
; |                                                                                 |
; |  Author:   Jens A. Koch <jakoch@web.de>                                         |
; |  Co-Maintainer: Thomas Kowaliczek-Schmmer <thomas.kowaliczek-schmer@posteo.de>  |
; |  License:  MIT                                                                  |
; |                                                                                 |
; |  For the full copyright and license information, please view                    |
; |  the LICENSE file that was distributed with this source code.                   |
; |                                                                                 |
; |  Note for developers                                                            |
; |  -------------------                                                            |
; |  A good resource for developing and understanding                               |
; |  Inno Setup Script files is the official "Inno Setup Help".                     |
; |  Website:  http://jrsoftware.org/ishelp/index.php                               |
; |                                                                                 |
; +--------------------------------------------------------------------------------<3

; version is set here, when the version isn't passed to the compiler on invocation
#ifndef APP_VERSION
#define APP_VERSION          "0.4.2"
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
DefaultDirName=C:\fife
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
; for example: "_build\FifeSDK-0.4.2-Setup-VC14-x86.exe"
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
Name: "german";  MessagesFile: "compiler:Languages\German.isl"

; Define the types of installations
; The user gets a drop-down list to select one of these types.
; Selecting a type will selected a set of components.
[Types]
Name: "full-python2";               Description: "Full installation Python 2(build-tools, engine, dependencies, demos)"
Name: "full-python3";               Description: "Full installation Python 3(build-tools, engine, dependencies, demos)"
Name: "build-tools-python2";        Description: "Build-tools only (CMake, Boost, Swig)"
Name: "build-tools-python3";        Description: "Build-tools only (CMake, Boost, Swig)"
Name: "fife-only-python2";          Description: "Engine only Python 2 Version"
Name: "fife-only-python3";          Description: "Engine only Python 3 Version"
Name: "fife-python-demos";          Description: "Engine and Demos (demos)"
Name: "mapeditor";                  Description: "Fife Mapeditor (tools)"
Name: "fifengine-python-tutorials"; Description: "Fife Engine Python Tutorials (tutorials)"
;Name: "fifengine-c++-tutorials";   Description: "Fife Engine C++ Tutorials (tutorials)"
;Name: "fifengine-atlas-creator";   Description: "Fife Engine Atlas Creator (tools)"
;Name: "docs";                      Description: "Fife User and Developer Manuals (doc)"
Name: "custom";                     Description: "Custom installation"; Flags: iscustom

; Define components to install
[Components]
Name: "Fifengine";                  Description: "[fifengine] Fifengine - Isometric Game Engine";
Name: fifengine\py27;               Description: "[fifengine] Fifengine - Isometric Game Engine Python 2.7";    Types: full-python2 fife-only-python2
Name: fifengine\py36;               Description: "[fifengine] Fifengine - Isometric Game Engine Python 3.6";    Types: full-python3 fife-only-python3
Name: dependencies;                 Description: "[fifengine] Dependencies";                                    Types: full-python2 full-python3
;Name: docs;                        Description: "[manuals] Fifengine - Documentations";                        Types: full-python2 full-python3 fife-only-python2 fife-only-python3
Name: mapeditor;                    Description: "[dev tools] Fifengine - Mapeditor";                           Types: full-python2 mapeditor
Name: demos;                        Description: "[fifengine] Demos";                                           Types: full-python2 fife-python-demos
Name: tutorials;                    Description: "[tutorials] Tutorials";                                       Types: full-python2 fifengine-python-tutorials
;Name: tutorials;                   Description: "[tutorials] Tutorials";                                       Types: full-python2 fifengine-python-tutorials fifengine-c++-tutorials
;Name: atlascreator                 Description: "[dev tools] Fifengine - Atlas Creator";                       Types: full-python2 fifengine-atlas-creator
Name: cmake;                        Description: "[build tools] CMake - build system";                          Types: full-python2 full-python3 build-tools-python2 build-tools-python3
;Name: "Python";                     Description: "[build tools] Python - programming language";
;Name: "Python\py27";                Description: "[build tools] Python v2.7";                                   Types: full-python2 build-tools-python2
;Name: "Python\py36";                Description: "[build tools] Python v3.6";                                   Types: full-python3 build-tools-python3
Name: swig;                         Description: "[build tools] SWIG - interface generator";                    Types: full-python2 full-python3 build-tools-python2 build-tools-python3
;Name: vcredist2015;                 Description: "[dep libs] VCRedist2015";                                     Types: full-python2 full-python3 build-tools-python2 build-tools-python3

[Files]
Source: "..\repackage\fifengine-includes\*";    DestDir: "{app}\fifengine-dependencies";Flags: recursesubdirs ignoreversion; Components: dependencies
Source: "..\repackage\cmake\*";                 DestDir: "{app}\cmake";                 Flags: recursesubdirs ignoreversion; Components: cmake
Source: "..\repackage\swig\*";                  DestDir: "{app}\swig";                  Flags: recursesubdirs ignoreversion; Components: swig
;Source: "..\repackage\Python27\*";              DestDir: "{app}\python27";              Flags: recursesubdirs ignoreversion; Components: "Python\py27"
;Source: "..\repackage\Python36\*";              DestDir: "{app}\python36";              Flags: recursesubdirs ignoreversion; Components: "Python\py36"
; Fifengine below Python, because we are installing the python library into the Python installation folder
Source: "..\repackage\libfife.win32-py2.7.msi"; DestDir: "{app}\libfife27";             Flags: recursesubdirs;               Components: fifengine\py27
Source: "..\repackage\libfife.win32-py3.6.msi"; DestDir: "{app}\libfife36";             Flags: recursesubdirs;               Components: fifengine\py36
Source: "..\repackage\mapeditor\*";             DestDir: "{app}\mapeditor";             Flags: recursesubdirs ignoreversion; Components: mapeditor
Source: "..\repackage\python-demos\*";          DestDir: "{app}\python-demos";          Flags: recursesubdirs ignoreversion; Components: demos
Source: "..\repackage\python-tutorials\*";      DestDir: "{app}\python-tutorials";      Flags: recursesubdirs ignoreversion; Components: tutorials
;Source: "..\repackage\fife-c++-tutorials\*";   DestDir: "{app}\cpp-tutorials";         Flags: recursesubdirs ignoreversion; Components: tutorials
;Source: "..\repackage\atlas-creator\*";        DestDir: "{app}\image-atlas-creator";   Flags: recursesubdirs ignoreversion; Components: atlascreator
;Source: "..\repackage\docs\*";                 DestDir: "{app}\docs";                  Flags: recursesubdirs ignoreversion; Components: docs
;Source: "..\repackage\vc_redist.x86.exe";       DestDir: "{tmp}";                       Flags: deleteafterinstall;           Components: Python\py27 and Python\py36 and fifengine\py27 and fifengine\py36 and dependencies

; Define items to run automatically on installation...
[Run]
; install "libfife for python2.7" only when "py27 and fifengine" are selected + install silently into the target dir
Filename: "msiexec.exe"; Parameters: "/i ""{app}\libfife\libfife.win32-py2.7.msi"" TARGETDIR=""{app}\python"" /qn"; StatusMsg: "Installing libFife for Python2.7"; Components: fifengine\py27
; install "libfife for python3.6" only when "py36 and fifengine" are selected + install silently into the target dir
Filename: "msiexec.exe"; Parameters: "/i ""{app}\libfife\libfife.win32-py3.6.msi"" TARGETDIR=""{app}\python"" /qn"; StatusMsg: "Installing libFife for Python3.6"; Components: fifengine\py36
; add the Parameters, WorkingDir and StatusMsg as you wish, just keep here
; the conditional installation Check
;Filename: "{tmp}\vc_redist.x86.exe"; Parameters: "/q /norestart"; Check: VCRedistNeedsInstall; StatusMsg: "Installing VC++ redistributables..."

; Define items to run automatically on un-installation...
[UninstallRun]
; un-install "libfife"
Filename: "msiexec.exe"; Parameters: "/x ""{app}\libfife\libfife.win32-py2.7.msi"" /qn"; StatusMsg: "Uninstalling libFife for Python 2.7"; Flags: runascurrentuser runhidden
Filename: "msiexec.exe"; Parameters: "/x ""{app}\libfife\libfife.win32-py3.6.msi"" /qn"; StatusMsg: "Uninstalling libFife for Python 3.6"; Flags: runascurrentuser runhidden

[UninstallDelete]
Type: filesandordirs; Name: "{app}\mapeditor"
Type: filesandordirs; Name: "{app}\python-demos"
Type: filesandordirs; Name: "{app}\python-tutorials"
Type: filesandordirs; Name: "{app}\python27"
Type: filesandordirs; Name: "{app}\python36"

[Registry]
; A registry change needs the following directive: [SETUP] ChangesEnvironment=yes
;
; add path to Python
;Root: HKCU; Subkey: "Environment"; ValueType:string; ValueName:"PATH"; ValueData:"{olddata};{app}\python27"; Flags: preservestringtype; Check: NeedsAddPathLocalUser(ExpandConstant('{app}\python27')); Components: Python\py27
;Root: HKCU; Subkey: "Environment"; ValueType:string; ValueName:"PATH"; ValueData:"{olddata};{app}\python36"; Flags: preservestringtype; Check: NeedsAddPathLocalUser(ExpandConstant('{app}\python36')); Components: Python\py36
;
; add path to libfife
;Root: HKCU; Subkey: "Environment"; ValueType:string; ValueName:"PATH"; ValueData:"{olddata};{app}\python27\Lib\site-packages\fife"; Flags: preservestringtype; Check: NeedsAddPathLocalUser(ExpandConstant('{app}\python27\Lib\site-packages\fife')); Components: fifengine\py27
;Root: HKCU; Subkey: "Environment"; ValueType:string; ValueName:"PATH"; ValueData:"{olddata};{app}\python36\Lib\site-packages\fife"; Flags: preservestringtype; Check: NeedsAddPathLocalUser(ExpandConstant('{app}\python36\Lib\site-packages\fife')); Components: fifengine\py36
;
; Create File Association
;Root: HKCR; Subkey: ".py";                            ValueType: string; ValueName: ""; ValueData: "Python.File"; Flags: uninsdeletevalue 
;Root: HKCR; Subkey: "Python.File";                    ValueType: string; ValueName: ""; ValueData: "Python File"; Flags: uninsdeletekey
;Root: HKCR; Subkey: "Python.File\DefaultIcon";        ValueType: string; ValueName: ""; ValueData: "{app}\python\DLLs\py.ico"
;Root: HKCR; Subkey: "Python.File\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\python27\python.exe"" ""%1"" %*" ; Components: fifengine\py27
;Root: HKCR; Subkey: "Python.File\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\python36\python.exe"" ""%1"" %*" ; Components: fifengine\py36
   
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
    RemovePathLocalUser(ExpandConstant('{app}') + '\python27\Lib\site-packages\fife');
    RemovePathLocalUser(ExpandConstant('{app}') + '\python27');
    RemovePathLocalUser(ExpandConstant('{app}') + '\python36\Lib\site-packages\fife');
    RemovePathLocalUser(ExpandConstant('{app}') + '\python36');
    // 3. refresh environment, so that the modified PATH var is activated
    RefreshEnvironment();
  end;
end;

#IFDEF UNICODE
  #DEFINE AW "W"
#ELSE
  #DEFINE AW "A"
#ENDIF
type
  INSTALLSTATE = Longint;
const
  INSTALLSTATE_INVALIDARG = -2;  { An invalid parameter was passed to the function. }
  INSTALLSTATE_UNKNOWN = -1;     { The product is neither advertised or installed. }
  INSTALLSTATE_ADVERTISED = 1;   { The product is advertised but not installed. }
  INSTALLSTATE_ABSENT = 2;       { The product is installed for a different user. }
  INSTALLSTATE_DEFAULT = 5;      { The product is installed for the current user. }

  // Visual C++ 2015 Redistributable 14.0.24215.1
  VC_2015_REDIST_X86 = '{e2803110-78b3-4664-a479-3611a381656a}';
//  VC_2015_REDIST_X64 = '{d992c12e-cab2-426f-bde3-fb8c53950b0d}';

function MsiQueryProductState(szProduct: string): INSTALLSTATE;
  external 'MsiQueryProductState{#AW}@msi.dll stdcall';

function VCVersionInstalled(const ProductID: string): Boolean;
begin
  Result := MsiQueryProductState(ProductID) = INSTALLSTATE_DEFAULT;
end;

function VCRedistNeedsInstall: Boolean;
begin
  Result := not (VCVersionInstalled(VC_2015_REDIST_X86));
end;
