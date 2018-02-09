program NovoMapeador;

uses
  Vcl.Forms,
  System.MaskUtils,
  Vcl.Controls,
  SysUtils,
  uMapPrincipal in '..\Fontes\Mapedor\uMapPrincipal.pas' {frmPricipalMapLM},
  uMapDataModule in '..\Fontes\DataModule\uMapDataModule.pas' {dmMapLM: TDataModule},
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
  uMaplm_Config in '..\Fontes\Entidades\uMaplm_Config.pas',
  uShellComandos in '..\Fontes\Comandos\uShellComandos.pas',
  uSVNComandos in '..\Fontes\Comandos\uSVNComandos.pas',
  uDaoLogin in '..\Fontes\DaoEntidades\uDaoLogin.pas',
  uLogin in '..\Fontes\Entidades\uLogin.pas',
  uDaoMaplm_Config in '..\Fontes\DaoEntidades\uDaoMaplm_Config.pas',
  uPassWord in '..\Fontes\Mapedor\uPassWord.pas' {frmPasswordDlg},
  uMetodosUteis in '..\Fontes\Comandos\uMetodosUteis.pas';

var
 ShowResult : Byte;
 wMsg, wSenhaAtual : string;
 wTipo : integer;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmMapLM, dmMapLM);

  if Trim(ParamStr(1)) <> '' then
  begin
    fIniTabLogin;
    fIniDaoLogin;
    Login.Senha := Trim(ParamStr(1));
    Login.Usuario := fNomePC;
    if uDaoLogin.DaoLogin.fLogar(Login) then
    begin
      Application.CreateForm(TfrmPricipalMapLM, frmPricipalMapLM);
      Application.Run;
    end;

  end;

  Application.CreateForm(TfrmPasswordDlg, frmPasswordDlg);
  ShowResult := frmPasswordDlg.ShowModal;
  if ShowResult = mrOK then
  begin
    FreeAndNil(frmPasswordDlg);
    Application.CreateForm(TfrmPricipalMapLM, frmPricipalMapLM);
    Application.Run;
  end
  else
  if ShowResult = mrCAncel then
    Application.Terminate;
end.
