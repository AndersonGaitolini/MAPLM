unit uORM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Data.DB;

type
  TfrmGerenciadorORM = class(TForm)
    pgc1: TPageControl;
    tsOrmAnderson: TTabSheet;
    tsORMBasico: TTabSheet;
    btnGeraClasse: TButton;
    btn1: TButton;
    procedure btnGeraClasseClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGerenciadorORM: TfrmGerenciadorORM;

implementation

uses
  ufoGerarClasse, Lca.Orm.GerarClasseFireDac, ufrmGerarClasse;

{$R *.dfm}

procedure TfrmGerenciadorORM.btn1Click(Sender: TObject);
begin
  frmGeraClasse := TfrmGeraClasse.Create(Self);
  try
    frmGeraClasse.showmodal;
  finally
    frmGeraClasse.Free;
  end;
end;

procedure TfrmGerenciadorORM.btnGeraClasseClick(Sender: TObject);
begin
  foGeraClasse := TfoGeraClasse.Create(Self);
  try
    foGeraClasse.showmodal;
  finally
    foGeraClasse.Free;
  end;
end;
end.
