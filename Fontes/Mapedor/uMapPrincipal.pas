unit uMapPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Tabs, Vcl.ComCtrls,
  Vcl.ToolWin, System.Win.TaskbarCore, Vcl.Taskbar, Vcl.StdCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.Buttons, Vcl.Grids, Vcl.ValEdit, Data.DB,
  Vcl.DBGrids, Data.Bind.Components, Data.Bind.DBScope, Vcl.AppEvnts;

type
  TfrmPricipalMapLM = class(TForm)
    PageControl1: TPageControl;
    tsConfigurar: TTabSheet;
    ts2: TTabSheet;
    stat1: TStatusBar;
    tlb1: TToolBar;
    ts3: TTabSheet;
    edDir: TJvDirectoryEdit;
    btn1: TBitBtn;
    btn2: TBitBtn;
    dbgListaMap: TDBGrid;
    edNomeMap: TEdit;
    cbbVersao: TComboBox;
    cbbStatus: TComboBox;
    cbbSelectMap70: TComboBox;
    btnMapOK: TButton;
    lbBuildDateTit: TLabel;
    lbBuildDate: TLabel;
    lbSVNRevDateTit: TLabel;
    lbSVNRevDate: TLabel;
    Label8: TLabel;
    lbSVNRev: TLabel;
    lbSVNRevRange: TLabel;
    SVNRevRangeTit: TLabel;
    lbSVNURLTit: TLabel;
    lbSVNURL: TLabel;
    lbSVNRelease: TLabel;
    lbSVNReleaseTit: TLabel;
    appEvent1: TApplicationEvents;
    tmrHint: TTimer;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edDirChange(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure dbgListaMapCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure edDirClick(Sender: TObject);
    procedure ts2Show(Sender: TObject);
    procedure btnMapOKClick(Sender: TObject);
    procedure btnInfoSVNClick(Sender: TObject);
    procedure cbbSelectMap70Change(Sender: TObject);
    procedure appEvent1Minimize(Sender: TObject);
    procedure tmrHintTimer(Sender: TObject);
    procedure edDirMouseEnter(Sender: TObject);
  private
    { Private declarations }
    procedure pAtualizaGrid;
    procedure pAtualizaLista70;
    procedure pCarregaMapAtual;
    procedure pCarregaDrives;
  public
    { Public declarations }
  end;

var
  frmPricipalMapLM: TfrmPricipalMapLM;
  wListaDrivers : TStringList;

implementation

uses
  uMaplm_Config, uMapDataModule, uDaoMaplm_Config, uShellComandos, uSVNComandos, uLogin, uDaoLogin, uMetodosUteis;

{$R *.dfm}

procedure TfrmPricipalMapLM.appEvent1Minimize(Sender: TObject);
begin
//  ShowMessage('Width: '+ IntToStr(frmPricipalMapLM.Width)+#10#13+
//               'Height :'+ IntToStr(frmPricipalMapLM.Height));
end;

procedure TfrmPricipalMapLM.btn1Click(Sender: TObject);
var Situacao : Integer;
  procedure pInserir;
  begin
    Mapconfig.Id := ObjMapLm.fNextId(Mapconfig);
    if dmMapLM.Dao.Inserir(Mapconfig,[]) = 1 then
      dmMapLM.Dao.Commit
    else
      exit;
  end;

  procedure pSalvar;
  begin
    if dmMapLM.Dao.Salvar(Mapconfig) = 1 then
     dmMapLM.Dao.Commit
    else
      exit;
  end;

begin
  if not Assigned(ObjMapLm) then
     ObjMapLm := TDaoMaplm.Create;

  if not Assigned(Mapconfig) then
    Mapconfig := TMaplm_config.Create;

  with Mapconfig, ObjMapLm do
  begin

    if (Trim(edDir.Text) <> '') and DirectoryExists(Trim(edDir.Text)) then
    begin
      Mapconfig.PATH_P_CONFIG := Trim(edDir.Text);
      Situacao := fConsutltaTab(['PATH_P_CONFIG'],Mapconfig).RecordCount;

      Status := cbbStatus.ItemIndex;
      versao := cbbVersao.ItemIndex;
      Nome_config := Trim(edNomeMap.Text);
      Path_p_config := edDir.Text;
      Path_h_config := IncludeTrailingPathDelimiter(edDir.Text) + 'MXEMP';
      Path_m_config := IncludeTrailingPathDelimiter(edDir.Text) + 'MPDV';
      Path_u_config := IncludeTrailingPathDelimiter(edDir.Text) + 'DCU';
    end
    else
    begin
      if edDir.CanFocus then
      begin
        edDir.SetFocus;
        edDir.SelStart := edDir.SelLength;
        edDir.ShowHint := true;
        edDir.Hint := 'Informe o diretório a ser mapeado';
        exit;
      end;
    end;

    try
      dmMapLM.Dao.StartTransaction;

      case Situacao of
       0: pInserir;
       1: pSalvar;
      end;

      edDir.Clear;
      edDir.SetFocus;
      edDir.SelStart := 0;
      edNomeMap.Clear;
      cbbVersao.ItemIndex := 0;
      cbbStatus.ItemIndex := 0;
      pAtualizaGrid;
    except on E: Exception do
      dmMapLM.Dao.RollBack;
    end;

  end;
end;

procedure TfrmPricipalMapLM.btn2Click(Sender: TObject);
begin
  fIniTab;
  fIniDao;
  try
    dmMapLM.Dao.StartTransaction;
     Mapconfig.Id := dbgListaMap.Columns[0].Field.AsInteger;
   if dmMapLM.Dao.Excluir(Mapconfig,['id']) = 1 then
   begin
     pAtualizaGrid;
   end;
  except on E: Exception do
  end;
end;

procedure TfrmPricipalMapLM.btnInfoSVNClick(Sender: TObject);
var MapTab : TMaplm_config;
    wHandle : THandle;
begin
//Carrega e mapeia o diretório gravado no banco
   MapTab := TMaplm_config.Create;
   MapTab.ID := cbbSelectMap70.ItemIndex+1;
   if ObjMapLm.fConsutltaTab(['id'], MapTab).RecordCount = 1 then
   begin
//   wHandle := Application.
     try
       try

       except on E: Exception do
       end;

     finally

     end;
   end;
end;

procedure TfrmPricipalMapLM.btnMapOKClick(Sender: TObject);
var MapTab : TMaplm_config;
    wHandle : THandle;
    wInfSVN: TSVNInfo;
begin
//Carrega e mapeia o diretório gravado no banco
   MapTab := TMaplm_config.Create;
   MapTab.ID := cbbSelectMap70.ItemIndex+1;
   if ObjMapLm.fConsutltaTab(['id'], MapTab).RecordCount = 1 then
   begin
//   wHandle := Application.
     try
       try
         fAddUnidade(handle, 'P', MapTab.PATH_P_CONFIG);
         fAddUnidade(handle, 'H', MapTab.PATH_H_CONFIG);
         fAddUnidade(handle, 'M', MapTab.PATH_M_CONFIG);
         fAddUnidade(handle, 'U', MapTab.PATH_U_CONFIG);
         wInfSVN := fGetInfoSVN(handle,PWideChar(MapTab.PATH_P_CONFIG));

         with wInfSVN do
         begin
           lbSVNRev.Caption       :=  SVNRev;
           lbBuildDate.Caption    := BuildDate;
           lbSVNRevDate.Caption   := SVNRevDate;
           lbSVNRevRange.Caption  := SVNRevRange;
           lbSVNRelease.Caption   := SVNRelease;
           lbSVNURL.Caption       := SVNURL;
         end;

         if (DirectoryExists('P:')) and
            (DirectoryExists('H:')) and
            (DirectoryExists('M:')) and
            (DirectoryExists('U:')) then
         begin
//           MapTab. := cbbSelectMap70.ItemIndex;
           if dmMapLM.Dao.Salvar(MapTab) = 1 then
             stat1.Panels[0].Text:= 'Status: OK'
           else
            stat1.Panels[0].Text:= 'Status: Mapeamento não ativado!';

           setINI('P:\versionINI.ini','svnversion','pMapAtual',IntToStr(MapTab.Id));
         end;

       except on E: Exception do
       end;

     finally

     end;
   end;
end;

procedure TfrmPricipalMapLM.cbbSelectMap70Change(Sender: TObject);
begin
  lbBuildDate.Caption := '<runtime>';
  lbSVNRevDate.Caption := '<runtime>';
  lbSVNRev.Caption := '<runtime>';
  lbSVNRevRange.Caption := '<runtime>';
  lbSVNURL.Caption := '<runtime>';
  lbSVNRelease.Caption := '<runtime>';
end;

procedure TfrmPricipalMapLM.dbgListaMapCellClick(Column: TColumn);
var wDataSet: TDataset;
begin
  wDataSet := TDataset.Create(Application);
  try
    fIniTab;
    fIniDao;
    if dbgListaMap.DataSource.DataSet.RecordCount = 0 then
     exit;

    Mapconfig.Id := dbgListaMap.DataSource.DataSet.FieldByName('id').AsInteger;
    if ObjMapLm.fConsutltaTab(['id'],Mapconfig).RecordCount = 1 then
    begin
      edDir.Text := Mapconfig.PATH_P_CONFIG;
      edNomeMap.text  := Mapconfig.NOME_CONFIG;
      cbbVersao.ItemIndex := Mapconfig.VERSAO;
      cbbStatus.ItemIndex := Mapconfig.STATUS;
    end;
  finally
    wDataSet.Free;
  end;
end;

procedure TfrmPricipalMapLM.edDirChange(Sender: TObject);
begin
  edNomeMap.Text := Copy(Trim(edDir.Text), LastDelimiter('\',edDir.Text)+1,length(edDir.Text));
end;

procedure TfrmPricipalMapLM.edDirClick(Sender: TObject);
begin
   if (Trim(edDir.Text) <> '') and DirectoryExists(Trim(edDir.Text)) then
  begin
    edDir.InitialDir := Trim(edDir.Text);
  end;
end;

procedure TfrmPricipalMapLM.edDirMouseEnter(Sender: TObject);
begin
  if edDir.ShowHint then
    edDir.ShowHint := false;
end;

procedure TfrmPricipalMapLM.FormCreate(Sender: TObject);
begin
  fIniTab;
  fIniDao;
//  Mapconfig := TMaplm_config.Create;
//  ObjMapLm := TDaoMaplm.Create;
  wListaDrivers := fListaUnidades;


end;

procedure TfrmPricipalMapLM.FormShow(Sender: TObject);
begin
  pAtualizaGrid;
end;

procedure TfrmPricipalMapLM.pAtualizaGrid;
var SQL: string;
begin
  SQL := 'select * from maplm_config';
  dbgListaMap.DataSource.DataSet := dmMapLM.Dao.ConsultaSql(SQL);
  dbgListaMap.Refresh;
end;

procedure TfrmPricipalMapLM.pAtualizaLista70;
var wDataSet: TDataset;
begin
  wDataSet := TDataset.Create(Application);
  cbbSelectMap70.Clear;
  try
    wDataSet := dmMapLM.Dao.ConsultaSql('select * from maplm_config where versao = 0');
    if wDataSet.RecordCount > 0 then
    begin
      while not wDataSet.Eof do
      begin
        cbbSelectMap70.Items.Add(wDataSet.FieldByName('NOME_CONFIG').AsString);
        wDataSet.Next;
      end;
    end;

    cbbSelectMap70.ItemIndex := Login.MapAtual;
    if DirectoryExists('P:') then
     cbbSelectMap70.ItemIndex := StrToIntDef(getINI('P:\VersionINI.ini','svnversion','pMapAtual',''),0)-1;

     lbBuildDate.Caption      := getINI('P:\VersionINI.ini','svnversion','pBuild_Date','');
     lbSVNRevDate.Caption     := getINI('P:\VersionINI.ini','svnversion','pSVN_Revision_Date','');
     lbSVNRev.Caption         := getINI('P:\VersionINI.ini','svnversion','pSVN_Revision','');
     lbSVNRevRange.Caption    := getINI('P:\VersionINI.ini','svnversion','pSVN_RevRange','');
     lbSVNURL.Caption         := getINI('P:\VersionINI.ini','svnversion','pSVN_URL','');
     lbSVNRelease.Caption     := getINI('P:\VersionINI.ini','svnversion','pSVN_Release','');
  finally
  end;
  pAtualizaGrid;

end;

procedure TfrmPricipalMapLM.pCarregaDrives;
begin

end;

procedure TfrmPricipalMapLM.pCarregaMapAtual;
var wDataSet : TDataset;
begin
  wDataSet := TDataset.Create(Application);
  try
    fIniTab;
    fIniDao;

    Mapconfig.Id := dbgListaMap.DataSource.DataSet.FieldByName('MAP_ATUAL').AsInteger;
    if ObjMapLm.fConsutltaTab(['id'],Mapconfig).RecordCount = 1 then
    begin
      cbbSelectMap70.ItemIndex := wDataSet.FieldByName('MAP_ATUAL').AsInteger;
      lbBuildDate.Caption      := wDataSet.FieldByName('Data_build').AsString;
      lbSVNRevDate.Caption     := wDataSet.FieldByName('Data_revisao').AsString;
      lbSVNRev.Caption         := wDataSet.FieldByName('Num_rev_svn').AsString;
      lbSVNRevRange.Caption    := wDataSet.FieldByName('Num_rev_workcopy').AsString;
      lbSVNURL.Caption         := wDataSet.FieldByName('Link_revisao').AsString;
      lbSVNRelease.Caption     := wDataSet.FieldByName('MAP_ATUAL').AsString;
    end;
  finally
  end;
end;

procedure TfrmPricipalMapLM.tmrHintTimer(Sender: TObject);
begin
 //
//  if Sender = TJvDirectoryEdit then
//  begin
//    TJvDirectoryEdit(sender).ShowHint
//  end;

end;

procedure TfrmPricipalMapLM.ts2Show(Sender: TObject);
begin
  pAtualizaLista70;

end;

end.
