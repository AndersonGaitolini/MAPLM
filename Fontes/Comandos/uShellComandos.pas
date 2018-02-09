unit uShellComandos;

interface

uses
 windows, classes,ShellAPI,StdCtrls, Dialogs, Controls, SysUtils;

 Type
 TSetdrive = set of 'A'..'Z';
 TDriveType = (dtUnknown, dtNoDrive, dtFloppy, dtFixed, dtNetwork, dtCDROM, dtRAM);

Const
  cMaxDrive = 25;

function ShellExecuteMsg(hWnd: HWND; Operation, FileName, Parameters,Directory: PChar; ShowCmd: Integer):Boolean;
function fAddUnidade(hWnd: HWND; pLetra, pDir: string; pLabel : string = ''):Boolean;
function fDelUnidade(hWnd: HWND; pLetra : string):Boolean;
function fListaUnidades: TStringList;

implementation

{ TMapeamento }

function ShellExecuteMsg(hWnd: HWND; Operation, FileName,
  Parameters, Directory: PChar; ShowCmd: Integer): Boolean;


var
  Erro : Cardinal;
  msg : string;

begin
  Erro:= ShellExecute(hWnd, Operation ,FileName,Parameters,Directory,ShowCmd);
  
  Result := False;
  case Erro of
    0 : msg := 'O sistema operacional está sem memória ou recursos.';
    2 : msg := 'O arquivo especificado não foi encontrado';
    3 : msg := 'O caminho especificado não foi encontrado.';
    5 : msg := 'Somente Windows 95: O sistema operacional negou acesso ao arquivo especificado';
    8 : msg := 'Somente Windows 95: Não havia memória suficiente para concluir a operação.';
    10 : msg := 'Versão errada do Windows';
    11 : msg := 'O arquivo .exe é inválido (não-Win32.exe ou erro na imagem .exe)';
    12 : msg := 'O aplicativo foi projetado para um sistema operacional diferente';
    13 : msg := 'Aplicativo foi projetado para MS-DOS 4.0';
    15 : msg := 'Tentativa de carregar um programa em modo real';
    16 : msg := 'Tentativa de carregar uma segunda instância de um aplicativo com segmentos de dados não-readonly.';
    19 : msg := 'Tentativa de carregar um arquivo de aplicativo compactado.';
    20 : msg := 'Falha do arquivo de biblioteca de vínculo dinâmico (DLL).';
    26 : msg := 'Ocorreu uma violação de compartilhamento.';
    27 : msg := 'A associação do nome do arquivo está incompleta ou é inválida.';
    28 : msg := 'A transação DDE não pôde ser concluída porque o pedido excedeu o tempo limite.';
    29 : msg := 'A transação DDE falhou.';
    30 : msg := 'A transação DDE não pôde ser concluída porque outras transações DDE estavam sendo processadas.';
    31 : msg := 'Não há nenhum aplicativo associado à extensão de nome de arquivo fornecida.';
    32 : msg := 'Somente Windows 95: A biblioteca de vínculo dinâmico especificada não foi encontrada.';
  else
    msg := '';//IntToStr(Erro);
    Result := True;
  end;

  if msg <> '' then
    ShowMessage(msg);
    
end;

function fAddUnidade(hWnd: HWND; pLetra, pDir: string; pLabel : string = ''):Boolean;
var Comando : array[1..4] of PWideChar;
begin
     Result := False;
     Comando[1] := PWideChar(wideString('/C @subst '+pLetra+DriveDelim+' /d > nul'));
     Comando[2] := PWideChar(wideString('/C @net use '+pLetra+DriveDelim+' /delete > nul'));
     Comando[3] := PWideChar(wideString('/C subst '+pLetra+DriveDelim+' '+pDir+ ' >nul'));
     if (pLabel <> '') then
     Comando[4] := PWideChar(wideString('LABEL '+pLetra+DriveDelim+' ' +pLabel));
     //LABEL (Unidade) (Nome Desejado)
     if ShellExecuteMsg(hWnd,'Open','cmd',Comando[1],nil,0)then
       if ShellExecuteMsg(hWnd,'Open','cmd',Comando[2],nil,0) then
         Result := ShellExecuteMsg(hWnd,'Open','cmd',Comando[3],nil,0);

//     if (pLabel <> '') then;
        ShellExecuteMsg(hWnd,'Open','cmd',Comando[4],nil,0)
end;

function fDelUnidade(hWnd: HWND; pLetra : string):Boolean;
var Comando : array[1..2] of PWideChar;
begin
  Result := False;
  Comando[1]:= PWideChar(AnsiString('/C @subst '+pLetra+': /d > nul'));
  Comando[2]:= PWideChar(AnsiString('/C @net use '+pLetra+': /delete > nul'));

  if ShellExecuteMsg(hWnd,'Open','cmd',Comando[1],nil,0)then
   Result := ShellExecuteMsg(hWnd,'Open','cmd',Comando[2],nil,0);


end;

function fListaUnidades: TStringList;
var
  i : Integer;
  LetraDrive : AnsiChar;
  DriveBits : set of 0..25;
  TipoDrive : TDriveType;
  ListaDrivers : TStringList;

begin
  ListaDrivers := TStringList.Create;
  try
   Integer (DriveBits) := GetLogicalDrives;
    for i := 0 to cMaxDrive do
    begin
      LetraDrive  := UpCase(ansiChar (i + ord ('a')));
      TipoDrive := TDriveType(GetDriveType(PWideChar(WideString(LetraDrive + ':'))));
      if (CompareStr(LetraDrive, 'C') = 0) or (CompareStr(LetraDrive, 'E') = 0) or
         (TipoDrive in [dtCDROM]) then
         Continue;

      if (TipoDrive in [dtFixed, dtNoDrive]) then
        if  not (i in DriveBits) then
           ListaDrivers.Add(LetraDrive)
        else
          ListaDrivers.Add ('Drive ' + LetraDrive + ': - HD Local');

      Result := ListaDrivers;
    end;
  finally
//    ListaDrivers.free;
  end;
end;

end.
