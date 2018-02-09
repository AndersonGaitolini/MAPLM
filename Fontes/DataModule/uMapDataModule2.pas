unit uMapDataModule2;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Comp.Client, Data.DB,

  Lca.Orm.Comp.FireDac;

type
  TdmMapLM2 = class(TDataModule)
    conMapLM2: TFDConnection;
    fdtrMapLM2: TFDTransaction;
    fdDriverFBMapLM: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Dao : TDaoFireDac;
  end;

var
  dmMapLM2: TdmMapLM2;

implementation



{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmMapLM2.DataModuleCreate(Sender: TObject);
begin
   Dao := TDaoFireDac.Create(conMapLM2,fdtrMapLM2);
end;

end.
