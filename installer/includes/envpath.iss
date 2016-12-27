{
  InnoSetup - envpath.iss

  Helper for working with the environment variable PATH.

  -----------------------------------------------------------------------------

  Provides the functions:

   - NeedsAddPathLocalMachine()   - is a check, to avoid duplicate OrigPaths on the HKLM env variable PATH 
   - NeedsAddPathLocalUser()      - is a check, to avoid duplicate OrigPaths on the HKCU env variable PATH 

   - SaveOldPathLocalMachine()    - stores the HKLM env variable PATH as string oldPath 
   - SaveOldPathLocalUser()       - stores the HKCU env variable PATH as string oldPath

   - RemovePathLocalMachine(Path) - removes a path from the HKLM env variable PATH
   - RemovePathLocalUser(Path)    - removes a path from the HKCU env variable PATH

   - RefreshEnvironment()         - allows to refresh the environment instantly after a registry change

  It's a combination of solutions found on StackOverflow 
    - http://stackoverflow.com/questions/3304463
    - http://stackoverflow.com/questions/35410421

  -----------------------------------------------------------------------------

  Usage: 

  1. Example for NeedsAddPathLocalUser()

    //[Registry]
    //; A registry change needs the following directive: [SETUP] ChangesEnvironment=yes
    //; The registry is not modified, when in portable mode.
    //Root: HKCU; Subkey: "Environment"; 
    //      ValueType:string; ValueName:"PATH"; ValueData:"{olddata};{app}\bin\php"; Flags: preservestringtype;
    //      Check: NeedsAddPathLocalUser(ExpandConstant('{app}\bin\php')); Tasks: not portablemode;

  2. Example for RemovePathLocalUser() during uninstallation

    //// Removing a path from the PATH variable works in 3 steps:
    //// 1. get the old env var PATH and store it temporarily in oldPath
    //if (CurUninstallStep =  usUninstall) then
    //begin
    //  SaveOldPathLocalUser();
    //end;  
    //// 2. remove paths from the env var PATH 
    //if (CurUninstallStep = usPostUninstall) then
    //begin
    //  RemovePathLocalUser(ExpandConstant('{app}') + '\python\Lib\site-packages\fife');
    //  RemovePathLocalUser(ExpandConstant('{app}') + '\python');
    //  RemovePathLocalUser(ExpandConstant('{app}'));
    //  // 3. refresh environment, so that the modified PATH var is activated
    //  RefreshEnvironment();
    //end;

  -----------------------------------------------------------------------------
}

var
  OldPath: string;

const
  EnvironmentKey = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';

// fetch env var PATH and stores it into 
procedure SaveOldPathLocalMachine();
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', OldPath) then
  begin
    Log('PATH not found');
  end else begin
    Log(Format('Old Path saved as [%s]', [OldPath]));
  end;
end;

procedure SaveOldPathLocalUser();
begin
  if not RegQueryStringValue(HKEY_CURRENT_USER, 'Environment', 'Path', OldPath) then
  begin
    Log('PATH not found');
  end else begin
    Log(Format('Old Path saved as [%s]', [OldPath]));
  end;
end;

procedure RemovePathLocalMachine(Path: string);
var
  P: Integer;
begin
  Log(Format('Prepare to remove from Old PATH [%s]', [OldPath]));

  P := Pos(';' + Uppercase(Path) + ';', ';' + Uppercase(OldPath) + ';');
  if P = 0 then
  begin
    Log(Format('Path [%s] not found in PATH', [Path]));
  end
    else
  begin
    Delete(OldPath, P - 1, Length(Path) + 1);
    Log(Format('Path [%s] removed from PATH => [%s]', [Path, OldPath]));

    if RegWriteExpandStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', OldPath) then
    begin
      Log('PATH written');
    end
      else
    begin
      Log('Error writing PATH');
    end;
  end;
end;

procedure RemovePathLocalUser(Path: string);
var
  P: Integer;
begin
  Log(Format('Prepare to remove from Old PATH [%s]', [OldPath]));

  P := Pos(';' + Uppercase(Path) + ';', ';' + Uppercase(OldPath) + ';');
  if P = 0 then
  begin
    Log(Format('Path [%s] not found in PATH', [Path]));
  end
    else
  begin
    Delete(OldPath, P - 1, Length(Path) + 1);
    Log(Format('Path [%s] removed from PATH => [%s]', [Path, OldPath]));

    if RegWriteExpandStringValue(HKEY_CURRENT_USER, 'Environment', 'Path', OldPath) then
    begin
      Log('PATH written');
    end
      else
    begin
      Log('Error writing PATH');
    end;
  end;
end;

{
  This check avoids duplicate Paths on env var path.
  Used in the Registry Section for testing, if path was already set.
}
function NeedsAddPathLocalMachine(PathToAdd: string): boolean;
var
  Paths: string;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', Paths) then
  begin
    Result := True;
    exit;
  end;
  // look for the path with leading and trailing semicolon
  // Pos() returns 0 if not found
  Result := Pos(';' + UpperCase(PathToAdd) + ';', ';' + UpperCase(Paths) + ';') = 0;
  if Result = True then
     Result := Pos(';' + UpperCase(PathToAdd) + '\;', ';' + UpperCase(Paths) + ';') = 0;
end;

function NeedsAddPathLocalUser(PathToAdd: string): boolean;
var
  Paths: string;
begin
  if not RegQueryStringValue(HKEY_CURRENT_USER, 'Environment', 'Path', Paths) then
  begin
    Result := True;
    exit;
  end;
  // look for the path with leading and trailing semicolon
  // Pos() returns 0 if not found
  Result := Pos(';' + UpperCase(PathToAdd) + ';', ';' + UpperCase(Paths) + ';') = 0;
  if Result = True then
     Result := Pos(';' + UpperCase(PathToAdd) + '\;', ';' + UpperCase(Paths) + ';') = 0;
end;

{----------------------------------------------------------------------------
   RefreshEnvironment
 ---------------------------------------------------------------------------}

const
  SMTO_ABORTIFHUNG = 2;
  WM_WININICHANGE = $001A;
  WM_SETTINGCHANGE = WM_WININICHANGE;

type
  WPARAM = UINT_PTR;
  LPARAM = INT_PTR;
  LRESULT = INT_PTR;

{
   Wrapper function to call SendMessageTimeoutA function from user32.dll.
   Used by procedure RefreshEnvironment, see below.
}
function SendTextMessageTimeout(
  hWnd: HWND; 
  Msg: UINT;
  wParam: WPARAM; 
  lParam: PAnsiChar; 
  fuFlags: UINT;
  uTimeout: UINT; 
  out lpdwResult: DWORD): LRESULT;  
external 'SendMessageTimeoutA@user32.dll stdcall';  

{
  This procedure refreshes the environment.
  It is used to make registry changes sticky.
}
procedure RefreshEnvironment;
var
  S: AnsiString;
  MsgResult: DWORD;
begin
  S := 'Environment';
  SendTextMessageTimeout(
    HWND_BROADCAST, WM_SETTINGCHANGE, 0, PAnsiChar(S), SMTO_ABORTIFHUNG, 5000, MsgResult
  );
end;
