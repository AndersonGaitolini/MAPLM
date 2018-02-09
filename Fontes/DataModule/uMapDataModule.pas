unit uMapDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Comp.Client,
  Data.DB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  Data.SqlExpr, IBX.IBDatabase,DaoFD, DaoIBX, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Datasnap.DBClient,
  Datasnap.Provider;

type
  TdmMapLM = class(TDataModule)
    conMapLm: TFDConnection;
    fdtrMapLm: TFDTransaction;
    fddrfbMapLM: TFDPhysFBDriverLink;
    qryMapLm_Config: TFDQuery;
    dsMapLm_Config: TDataSource;
    cdsMapLm_Config: TClientDataSet;
    provMapLm_Config: TDataSetProvider;
    cdsMapLm_ConfigID: TIntegerField;
    cdsMapLm_ConfigSTATUS: TSmallintField;
    cdsMapLm_ConfigVERSAO: TSmallintField;
    cdsMapLm_ConfigNOME_CONFIG: TStringField;
    cdsMapLm_ConfigPATH_P_CONFIG: TStringField;
    cdsMapLm_ConfigPATH_H_CONFIG: TStringField;
    cdsMapLm_ConfigPATH_M_CONFIG: TStringField;
    cdsMapLm_ConfigPATH_U_CONFIG: TStringField;
    cdsMapLm_ConfigPATH_V_CONFIG: TStringField;
    cdsMapLm_ConfigNUM_REV_SVN: TIntegerField;
    cdsMapLm_ConfigNUM_REV_WORKCOPY: TIntegerField;
    cdsMapLm_ConfigLINK_REVISAO: TStringField;
    cdsMapLm_ConfigTIPO_REVISAO: TStringField;
    cdsMapLm_ConfigDATA_REVISAO: TDateField;
    cdsMapLm_ConfigDATA_BUILD: TDateField;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsMapLm_ConfigAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    Dao : TDaoFD;
    DaoIBX : TDaoIBX;
  end;

var
  dmMapLM: TdmMapLM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmMapLM.cdsMapLm_ConfigAfterPost(DataSet: TDataSet);
begin
//
  if DataSet.FieldByName('versao').AsInteger = 0 then
     

end;

procedure TdmMapLM.DataModuleCreate(Sender: TObject);
begin
  Dao := TDaoFD.Create(conMapLm, fdtrMapLm);
end;

end.
