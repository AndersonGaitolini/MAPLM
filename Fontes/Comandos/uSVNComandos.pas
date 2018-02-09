unit uSVNComandos;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, StdCtrls, Menus, ExtCtrls, AppEvnts, ComCtrls, ImgList,
  Buttons, IniFiles, uShellComandos;

type
  TInfoSVN = class
  private
    FINI : TIniFile;
    FSourceINI: string;
    FSourceBAT: string;
    FSourceTEMPL : string;
    FDirSVN: string;
    FExecute : string;
  public
    property INI: TIniFile read FINI write FINI;
    property SourceINI: string read FSourceINI write FSourceINI;
    property SourceBAT: string read FSourceBAT write FSourceBAT;
    property SourceTEMPL: string read FSourceTEMPL write FSourceTEMPL;
    property DirSVN: string read FDirSVN write FDirSVN;

    function GetWindowsDrive: Char;

//    function fGeraINI(prHandle : HWND): Boolean;
    constructor Create(prSource, prName: string);
  end;

  TSVNInfo = record
    SVNRev      : string;
    BuildDate   : string;
    SVNRevDate  : string;
    SVNRevRange : string;
    SVNRelease  : string;
    SVNURL      : string;
  end;

  const
 cSVN = 'svnversion';
 cSVN_Revision = 'pSVN_Revision';
 cBuild_Date = 'pBuild_Date';
 cSVN_Revision_Date = 'pSVN_Revision_Date';
 cSVN_RevRange = 'pSVN_RevRange';
 cSVN_Release = 'pSVN_Release';
 cSVN_URL = 'pSVN_URL';

 rSVN_Revision =       '$WCREV$';
 rBuild_Date =         '$WCNOW$';
 rSVN_Revision_Date =  '$WCDATE$';
 rSVN_RevRange =       '$WCRANGE$';
 rSVN_Release =        '$WCMODS?Teste:Oficial$';
 rSVN_URL =            '$WCURL$';

 CmdSubWCRev = 'SubWCRev';


 function fCloseFile(pSource: string): boolean;
 procedure fSetINI(pIniFilePath, prSessao, prSubSessao: string; prValor: string ='');
 function fGetINI(pIniFilePath, prSessao, prSubSessao: string; prValorDefault: string = ''): string;
 function fGetInfoSVN(pWnd: HWND; pDir: string): TSVNInfo;
implementation

{ TInfoSVN }

constructor TInfoSVN.Create(prSource, prName: string);
begin
  DirSVN       := prSource;
  SourceINI    := prName+ '.INI';
  SourceBAT    := prName+ '.BAT';
  SourceTempl  := prName+ '.template';
  INI := TIniFile.Create(DirSVN+SourceINI);
end;

function TInfoSVN.GetWindowsDrive: Char;
var
  S: string;
begin
  SetLength(S, MAX_PATH);
  if GetWindowsDirectory(PChar(S), MAX_PATH) > 0 then
    Result := string(S)[1]
  else
    Result := #0;
end;

procedure fSetINI(pIniFilePath, prSessao, prSubSessao: string; prValor: string ='');
var
  wINI : TIniFile;
begin
  wINI := TIniFile.Create(pIniFilePath);
  try
    if FileExists(pIniFilePath) then
      fCloseFile(pIniFilePath);

    wINI.WriteString(prSessao, prSubSessao, prValor);
  finally
    wINI.Free;
  end;
end;

function fGetINI(pIniFilePath, prSessao, prSubSessao: string; prValorDefault: string = ''): string;
var
  wINI : TIniFile;
begin
  wINI := TIniFile.Create(pIniFilePath);
  try
    Result := wINI.ReadString(prSessao, prSubSessao, prValorDefault);
  finally
    wINI.Free;
  end;
end;

function fCloseFile(pSource: string): boolean;
var wHandle : THandle;
    wFileSize: Cardinal;
begin
  Result := false;
  try
    wHandle := FindWindow(0,pWideChar(pSource));
    wFileSize := GetFileSize(wHandle,nil);
    Result := UnlockFile(wHandle,0,0,wFileSize,0);
    FileClose(wHandle);
  except //on E: Exception do
  end;
end;

function fGetInfoSVN(pWnd: HWND; pDir: string): TSVNInfo;
var wComando: pWideChar;
    wStr: string;
begin
//  wStr := 'E:  & cd '+pDir+ ' & ';
//  wComando := PWideChar(wideString(wStr+ 'SubWCRev '+pDir + ' VersionINI.TEMPLATE VersionINI.INI & pause'));
  pDir := IncludeTrailingPathDelimiter(pDir);
//    if ShellExecuteMsg(pWnd,'Open','POWERSHELL',wComando,nil,1) then
  if ShellExecuteMsg(pWnd,'Open',pWideChar(pDir+'Vtemplates.bat'),nil,nil,0) then
  begin
    pDir := pDir+'VersionINI.INI';

    Result.SVNRev      := fGetINI(pDir, cSVN,cSVN_Revision,'');
    Result.BuildDate   := fGetINI(pDir, cSVN,cBuild_Date,'');
    Result.SVNRevDate  := fGetINI(pDir, cSVN,cSVN_Revision_Date,'');
    Result.SVNRevRange := fGetINI(pDir, cSVN,cSVN_RevRange,'');
    Result.SVNRelease  := fGetINI(pDir, cSVN,cSVN_Release,'');
    Result.SVNURL      := fGetINI(pDir, cSVN,cSVN_URL,'');
  end;
end;
end.
