unit uDaoMaplm_Config;

interface

uses
  Base, System.SysUtils, Atributos, System.Classes,Data.DB,
  FireDAC.Comp.Client,Vcl.DBGrids, Datasnap.DBClient, Datasnap.Provider,
  Vcl.Forms,Vcl.Dialogs,Vcl.Controls,uMapDataModule, uMaplm_Config;

  type
  TDaoMaplm = class(TObject)
    private

    public
      function fNextId(pEntidade: TMaplm_config): integer;
      function fConsutltaTab(pCamposWhere: array of string; var pEntidade: TMaplm_config):TdataSet;
  end;


 function fIniDao:boolean;
 function fIniTab:boolean;

  var
  Mapconfig : TMaplm_config;
  ObjMapLm : TDaoMaplm;

implementation
{ TDaoMaplm }

function TDaoMaplm.fConsutltaTab(pCamposWhere: array of string; var pEntidade: TMaplm_config): TdataSet;
var wDataSet: TDataset;
begin
  if not Assigned(pEntidade) then
    pEntidade := TMaplm_config.Create;

  wDataSet := TDataSet.Create(Application);
  try
    try
      with wDataSet,pEntidade do
      begin
        wDataSet       := dmMapLM.dao.ConsultaTab(pEntidade, pCamposWhere);
        ID            := FieldByName('ID').AsInteger;
        STATUS        := FieldByName('STATUS').AsInteger;
        VERSAO        := FieldByName('VERSAO').AsInteger;
        NOME_CONFIG   := FieldByName('NOME_CONFIG').AsString;
        PATH_P_CONFIG := FieldByName('PATH_P_CONFIG').AsString;
        PATH_H_CONFIG := FieldByName('PATH_H_CONFIG').AsString;
        PATH_M_CONFIG := FieldByName('PATH_M_CONFIG').AsString;
        PATH_U_CONFIG := FieldByName('PATH_U_CONFIG').AsString;
        NUM_REV_SVN   := FieldByName('NUM_REV_SVN').AsInteger;
        NUM_REV_WORKCOPY := FieldByName('Num_rev_workcopy').AsInteger;
        LINK_REVISAO := FieldByName('LINK_REVISAO').AsString;
        TIPO_REVISAO := FieldByName('TIPO_REVISAO').AsString;
        DATA_REVISAO := FieldByName('DATA_REVISAO').AsDateTime;
        DATA_BUILD   := FieldByName('DATA_BUILD').AsDateTime;
      end;
    except on E: Exception do
             ShowMessage('Método: fConsutltaTab!'+#10#13 + 'Exception: '+e.Message);
    end;
  finally
    Result := wDataSet;
  //    FreeAndNil(wDataSet);
  end;
end;

function TDaoMaplm.fNextId(pEntidade: TMaplm_config): integer;
var wDataSet: TDataset;
begin
  if not Assigned(pEntidade) then
    pEntidade := TMaplm_config.Create;

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

function fIniTab: boolean;
begin
  Result := Assigned(Mapconfig);
  if not Result then
    Mapconfig := TMaplm_config.Create;
end;

function fIniDao: boolean;
begin
  Result := Assigned(ObjMapLm);
  if not Result then
     ObjMapLm := TDaoMaplm.Create;
end;


end.
