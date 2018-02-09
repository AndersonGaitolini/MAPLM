unit uPassWord;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, JvComponentBase, JvValidators, uMetodosUteis,Data.DB,
  Vcl.Dialogs;

type
  TSituacao = (tsNone, tsLogin, tsNewPass);
  TfrmPasswordDlg = class(TForm)
    Label1: TLabel;
    edPassword: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure edPasswordExit(Sender: TObject);
  private
    { Private declarations }
    wPassParam : string;
  public
    { Public declarations }
    function fNovoUsuario: TSituacao;
    function fLogando: boolean;
    function fNovaSenha: Boolean;
  end;

var
  frmPasswordDlg: TfrmPasswordDlg;
  wSituacao : TSituacao;
implementation

uses
  uDaoLogin, uLogin, uMapDataModule, uMaplm_Config, uDaoMaplm_Config;


{$R *.dfm}

procedure TfrmPasswordDlg.FormCreate(Sender: TObject);
begin
  fIniDaoLogin;
  fIniTabLogin;
  wSituacao := fNovoUsuario;
end;

procedure TfrmPasswordDlg.FormShow(Sender: TObject);
begin
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
 
