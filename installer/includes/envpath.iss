{
  InnoSetup - envpath.iss

  Helper for working with the environment variable PATH.

  -----------------------------------------------------------------------------

  Provides the functions:
   - NeedsAddPath()   - is a check, to avoid duplicate OrigPaths on the env variable PATH 
   - RemovePathFromEnvironmentPath(Path) - remove a path from the env variable PATH

  It's a combination of solutions found on StackOverflow 
    - http://stackoverflow.com/questions/3304463
    - http://stackoverflow.com/questions/35410421

  -----------------------------------------------------------------------------

  Usage: 

  1. Example for NeedsAddPath()

    //[Registry]
    //; A registry change needs the following directive: [SETUP] ChangesEnvironment=yes
    //; The registry is not modified, when in portable mode.
    //Root: HKCU; Subkey: "Environment"; 
    //      ValueType:string; ValueName:"PATH"; ValueData:"{olddata};{app}\bin\php"; Flags: preservestringtype;
    //      Check: NeedsAddPath(ExpandConstant('{app}\bin\php')); Tasks: not portablemode;

  2. Example for RemovePath() during Uninstallation

    //procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
    //begin
    //  if CurUninstallStep = usPostUninstall then
    //  begin
    //    RemovePath(ExpandConstant('{app}'));
    //  end;
    //end;

  -----------------------------------------------------------------------------
}

const
  EnvironmentKey = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';

procedure RemovePathFromEnvironmentPath(PathToRemove: string);
var
  Path: String;
begin
  // fetch env var PATH
  RegQueryStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'PATH', Path);

  Log(Format('Preparing to remove from env PATH [%s]', [Path]));

  // check, if the PathToRemove is inside PATH
  if Pos(LowerCase(PathToRemove) + ';', LowerCase(Path)) <> 0 then
  begin
  
     // replace the PathToRemove string segment with empty
     StringChange(Path, PathToRemove + ';', '');

     // and write the new path to registry
     RegWriteStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'PATH', Path);

     Log(Format('Path [%s] removed from PATH => [%s]', [Path, Paths]));
  end
  else
  begin
     Log(Format('Path [%s] not found in PATH', [Path]));
  end;
end;

{
  This check avoids duplicate Paths on env var path.
  Used in the Registry Section for testing, if path was already set.
}
function NeedsAddPath(PathToAdd: string): boolean;
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
