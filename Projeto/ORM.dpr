program ORM;

uses
  Vcl.Forms,
  uORM in '..\Fontes\ORM\uORM.pas' {frmGerenciadorORM},
  Atributos in '..\Fontes\ORM\Atributos.pas',
  Base in '..\Fontes\ORM\Base.pas',
  DaoFD in '..\Fontes\ORM\DaoFD.pas',
  DaoIBX in '..\Fontes\ORM\DaoIBX.pas',
  GerarClasse.BancoFirebird in '..\Fontes\ORM\GerarClasse.BancoFirebird.pas',
  GerarClasse.BancoMySQL in '..\Fontes\ORM\GerarClasse.BancoMySQL.pas',
  GerarClasse in '..\Fontes\ORM\GerarClasse.pas',
  GerarClasseFireDac in '..\Fontes\ORM\GerarClasseFireDac.pas',
  GerarClasseIBX in '..\Fontes\ORM\GerarClasseIBX.pas',
  ufoGerarClasse in '..\Fontes\ORM\ufoGerarClasse.pas' {foGeraClasse},
  uMapDataModule in '..\Fontes\DataModule\uMapDataModule.pas' {dmMapLM: TDataModule},
  Lca.Orm.Atributos in '..\Fontes\OrmBasico\Classes\Lca.Orm.Atributos.pas',
  Lca.Orm.Base in '..\Fontes\OrmBasico\Classes\Lca.Orm.Base.pas',
  Lca.Orm.Comp.FireDac in '..\Fontes\OrmBasico\Classes\Lca.Orm.Comp.FireDac.pas',
  Lca.Orm.Comp.IBX in '..\Fontes\OrmBasico\Classes\Lca.Orm.Comp.IBX.pas',
  Lca.Orm.GerarClasse.BancoFirebird in '..\Fontes\OrmBasico\Classes\Lca.Orm.GerarClasse.BancoFirebird.pas',
  Lca.Orm.GerarClasse in '..\Fontes\OrmBasico\Classes\Lca.Orm.GerarClasse.pas',
  Lca.Orm.GerarClasseFireDac in '..\Fontes\OrmBasico\Classes\Lca.Orm.GerarClasseFireDac.pas',
  Lca.Orm.GerarClasseIBX in '..\Fontes\OrmBasico\Classes\Lca.Orm.GerarClasseIBX.pas',
  uMapDataModule2 in '..\Fontes\DataModule\uMapDataModule2.pas' {dmMapLM2: TDataModule},
  ufrmGerarClasse in '..\Fontes\OrmBasico\GerarClasse\ufrmGerarClasse.pas' {frmGeraClasse},
  uLogin in '..\Fontes\Entidades\uLogin.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmMapLM, dmMapLM);
  Application.CreateForm(TdmMapLM2, dmMapLM2);
  Application.CreateForm(TfrmGerenciadorORM, frmGerenciadorORM);
  Application.Run;
end.
