unit uDaoLogin;

interface

uses
  Base, System.SysUtils, Atributos, System.Classes,Data.DB,
  FireDAC.Comp.Client,Vcl.DBGrids, Datasnap.DBClient, Datasnap.Provider,
  Vcl.Forms,Vcl.Dialogs,Vcl.Controls,uMapDataModule, uLogin;

  type
  TDaoLogin = class(TObject)
    private

    public
      function fNextId(pEntidade: TLogin): integer;
      function fConsutltaTab(pCamposWhere: array of string; var pEntidade: TLogin):TdataSet;
      function fLogar(pEntidade: TLogin): boolean;
  end;

 function fIniDaoLogin:boolean;
 function fIniTabLogin:boolean;

  var
  Login : TLogin;
  DaoLogin : TDaoLogin;

implementation

uses
  uMetodosUteis;
{ TObjectMaplm }

function TDaoLogin.fConsutltaTab(pCamposWhere: array of string; var pEntidade: TLogin): TdataSet;
var wDataSet: TDataset;
begin
  if not Assigned(pEntidade) then
    pEntidade := TLogin.Create;

  wDataSet := TDataSet.Create(Application);
  try
    try
      with wDataSet,pEntidade do
      begin
        wDataSet := dmMapLM.dao.ConsultaTab(pEntidade, pCamposWhere);
        ID       := FieldByName('ID').AsInteger;
        USUARIO  := FieldByName('USUARIO').AsString;
        SENHA    := FieldByName('SENHA').AsString;
        MAPATUAL := FieldByName('MAPATUAL').AsInteger;
      end;
    except on E: Exception do
             ShowMessage('Método: fConsutltaTab!'+#10#13 + 'Exception: '+e.Message);
    end;
  finally
    Result := wDataSet;
  end;
end;

function TDaoLogin.fLogar(pEntidade: TLogin): boolean;
var wDataSet : TDataSet;
begin
  Result := false;
  wDataSet := TDataSet.Create(Application);
  try
    wDataSet := dmMapLM.Dao.ConsultaTab(Login, ['USUARIO', 'SENHA']);
    if wDataSet.RecordCount = 1 then
    begin
      Result := true;
    end;
  finally
  end;
end;

function TDaoLogin.fNextId(pEntidade: TLogin): integer;
var wDataSet: TDataset;
begin
  if not Assigned(pEntidade) then
    pEntidade := TLogin.Create;

  Result := 0;
  pEntidade.Id := Result;
  wDataSet := TDataSet.Create(Application);
  try
    try
      wDataSet := dmMapLM.dao.ConsultaAll(pEntidade,'id' );
      wDataSet.Close;
      wDataSet.Open;
      wDataSet.last;
      Result := wDataSet.FieldByName('id').AsInteger+1;
    except on E: Exception do
             ShowMessage('Método: fNextId!'+#10#13 + 'Exception: '+e.Message);
    end;
  finally
    FreeAndNil(wDataSet);
  end;
end;

{ TMaplm_config }

function fIniTabLogin: boolean;
begin
  Result := Assigned(Login);
  if not Result then
    Login := TLogin.Create;
end;

function fIniDaoLogin: boolean;
begin
  Result := Assigned(DaoLogin);
  if not Result then
     DaoLogin := TDaoLogin.Create;
end;
end.
