unit uPassWord;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, JvComponentBase, JvValidators, uMetodosUteis,Data.DB,
  Vcl.Dialogs, Vcl.ComCtrls, Vcl.TabNotBk, Vcl.Mask, JvExMask, JvToolEdit,
  System.ImageList, Vcl.ImgList;

type
  TSituacao = (tsNone, tsLogin, tsNewPass);
  TfrmPasswordDlg = class(TForm)
    nb1: TTabbedNotebook;
    Label1: TLabel;
    edPassword: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    edfBancoDados: TJvFilenameEdit;
    il1: TImageList;
    btnConecta: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure edPasswordExit(Sender: TObject);
    procedure edfBancoDadosChange(Sender: TObject);
    procedure btnConectaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function fNovoUsuario: TSituacao;
    function fLogando: boolean;
    function fNovaSenha: Boolean;
    function fBancoConectado: Boolean;
    function fConectaBanco: Boolean;
  end;

var
  frmPasswordDlg: TfrmPasswordDlg;
  wSituacao : TSituacao;
const
 cBase = 'BaseDados';
implementation

uses
  uDaoLogin, uLogin, uMapDataModule, uMaplm_Config, uDaoMaplm_Config;


{$R *.dfm}

procedure TfrmPasswordDlg.FormCreate(Sender: TObject);
var wStr: string;
    wArqIni : SessoesINI;
begin
  fIniDaoLogin;
  fIniTabLogin;
  wSituacao := fNovoUsuario;
  wStr := SetNameFileOnAppName('INI');
  if not FileExists(wStr) then
    if not setINI(wStr, fNomePC, cBase, '') then
    begin
      SetLength(wArqIni,1);
      wArqIni[0].NomeSessao := fNomePC;
//      SetLength(wArqIni[1].SubSessao,1);
      wArqIni[0].SubSessao := [cBase];
      fCriaArquivoINI(wStr, wArqIni);
    end;
end;

procedure TfrmPasswordDlg.FormShow(Sender: TObject);
begin
  if not fBancoConectado then
  begin
    nb1.PageIndex := 0;
    if edfBancoDados.CanFocus then
      edfBancoDados.SetFocus;
  end
  else
  begin
    nb1.PageIndex := 1;
  end;

  Label1.Caption := 'Enter password: '+ fNomePC;
end;

procedure TfrmPasswordDlg.OKBtnClick(Sender: TObject);
begin
  wSituacao := fNovoUsuario;
  case wSituacao of
    tsLogin: fLogando;
    tsNewPass: fNovaSenha;
  else

  end;
end;

procedure TfrmPasswordDlg.btnConectaClick(Sender: TObject);
begin
  if FileExists(Trim(edfBancoDados.Text)) then
    setINI(SetNameFileOnAppName('INI'),fNomePC, cBase, Trim(edfBancoDados.Text));

  if fConectaBanco then
  begin
    nb1.PageIndex := 1;
    if edPassword.CanFocus then
    begin
      edPassword.SelStart := edPassword.SelLength;
    end;
  end
  else
   nb1.PageIndex := 0;
end;

procedure TfrmPasswordDlg.edfBancoDadosChange(Sender: TObject);
begin
  if DirectoryExists(Trim(edfBancoDados.Text))  then
    edfBancoDados.InitialDir := Trim(edfBancoDados.Text)
  else
    edfBancoDados.InitialDir := GetCurrentDir;

end;

procedure TfrmPasswordDlg.edPasswordExit(Sender: TObject);
var wPassRep: string;
    wOK: Boolean;
begin
  if (Trim(edPassword.Text) <> '') then
  begin
    if (wSituacao = tsNewPass)  then
    repeat
      wPassRep := Trim(InputBox('Repita a senha para: '+fNomePC, 'Redigite a senha: ',''));
      wOK := (CompareStr(wPassRep, Trim(edPassword.Text)) = 0);
      if wOK then
      begin
        wSituacao := tsLogin;
      end
      else
        edPassword.SelStart := Length(edPassword.Text);
    until (wOK);
  end;
end;

function TfrmPasswordDlg.fBancoConectado: Boolean;
begin
  if not dmMapLM.conMapLm.Connected then
  begin
    dmMapLM.conMapLm.Connected := false;
    btnConecta.Caption := 'Desconectado';
  end
  else
  Result := fConectaBanco;
end;

function TfrmPasswordDlg.fConectaBanco: Boolean;
var wBaseDir : string;
begin
  dmMapLM.conMapLm.Close;
  wBaseDir := getINI(SetNameFileOnAppName('ini'),fNomePC,cBase,'');
  edfBancoDados.Clear;
  edfBancoDados.Text := wBaseDir;

  if (Trim(edfBancoDados.Text) <> '') and (FileExists(Trim(edfBancoDados.Text))) then
  begin
    dmMapLM.conMapLm.Params.Database := Trim(edfBancoDados.Text);
    dmMapLM.conMapLm.Open;
    Result := dmMapLM.conMapLm.Connected;
    if Result then
    begin
      btnConecta.Caption := 'Conectado';
    end
    else
    begin
      btnConecta.Caption := 'Desconectado';
    end;
  end
  else
  begin
    Result := false;
   exit;
  end;


end;

function TfrmPasswordDlg.fLogando: boolean;
begin
  Login.Senha := Trim(edPassword.Text);
  Login.Usuario := Trim(fNomePC);
  if DaoLogin.fLogar(Login) then
  ModalResult := mrOk;
end;

function TfrmPasswordDlg.fNovaSenha: Boolean;
begin
  Login.Id := DaoLogin.fNextId(Login);
  Login.Usuario := fNomePC;
  Login.Senha := Trim(edPassword.Text);

  if dmMapLM.Dao.Inserir(Login,[] ) = 1 then
    ShowMessage('Nova Senha cadastrada!')
  else
  ShowMessage('Senha não cadastrada!');
end;

function TfrmPasswordDlg.fNovoUsuario: TSituacao;
var wDataSet : TDataSet;
begin
  wDataSet := TDataSet.Create(Application);
  Result := tsNone;
  try
    Login.Usuario := fNomePC;
    wDataSet := dmMapLM.Dao.ConsultaTab(Login, ['USUARIO']);
    if wDataSet.RecordCount = 0 then
    begin
      if edPassword.CanFocus then
      begin
        edPassword.SelStart;
        Result := tsNewPass;
      end;
    end
    else
    Result := tsLogin;
  finally
  end;
end;

end.
 
