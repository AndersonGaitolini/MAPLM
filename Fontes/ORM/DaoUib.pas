unit DaoUib;

interface

uses Base, Rtti, Atributos, system.SysUtils, System.Classes, UIB, Data.DB,
  FireDAC.Comp.Client, System.Contnrs;

type

TDaoUib = class(TInterfacedObject, IDaoBase)
 private
    FConexao: TFDConnection;
    FTransacao: TFDTransaction;

    FQuery: TFDQuery;
    FSql: IBaseSql;
    FDataSet: TDataSet;
    FParams: IQueryParams;

    Function DbToTabela<T: TTabela>(ATabela: TTabela; ADataSet: TDataSet): TObjectList<T>;

    procedure SetDataSet(const Value: TDataSet);
    procedure FechaQuery;
    procedure QryParamCurrency(ARecParams: TRecParams);
    procedure QryParamDate(ARecParams: TRecParams);
    procedure QryParamInteger(ARecParams: TRecParams);
    procedure QryParamString(ARecParams: TRecParams);
    procedure QryParamVariant(ARecParams: TRecParams);
    procedure SetaCamposCurrency(ARecParams: TRecParams);
    procedure SetaCamposDate(ARecParams: TRecParams);
    procedure SetaCamposInteger(ARecParams: TRecParams);
    procedure SetaCamposString(ARecParams: TRecParams);
  protected
    function ExecutaQuery: Integer;
  public
    constructor Create(Conexao: TFDConnection; Transacao: TFDTransaction);
    destructor Destroy; override;

    function GerarClasse(ATabela, ANomeUnit, ANomeClasse: string): string;

    // dataset para as consultas
    function ConsultaAll(ATabela: TTabela; AOrderBy: string = ''): TDataSet;
    function SelectAll(ATabela: TTabela; AOrderBy: string = ''): TDataSet;

    function ConsultaSql(ASql: string): TDataSet; overload;
    function ConsultaSql(ASql: string; pFetchAll: Boolean): TDataSet; overload;
    function ConsultaSql(ASql: string; const ParamList: Array of Variant): TDataSet; overload;
    function ConsultaSql(ATabela: string; AWhere: string): TDataSet; overload;
    function ConsultaSqlExecute(ASql: string): TDataSet;

    function ConsultaTab(ATabela: TTabela; ACamposWhere: array of string)
      : TDataSet; overload;

    function ConsultaTabela(ATabela: TTabela; ACamposWhere: array of string)
      : TFDQuery;

    function ConsultaTab(ATabela: TTabela; ACampos, ACamposWhere: array of string)
      : TDataSet; overload;

    function ConsultaTab(ATabela: TTabela; ACampos, ACamposWhere, AOrdem: array of string;
      TipoOrdem: Integer = 0): TDataSet; overload;

    function ConsultaGen<T: TTabela>(ATabela: TTabela; ACamposWhere: array of string)
      : TObjectList<T>;

    // limpar campos da tabela
    procedure Limpar(ATabela: TTabela);

    // pega campo autoincremento
    function GetID(ATabela: TTabela; ACampo: string): Integer;
    function GetMax(ATabela: TTabela; ACampo: string;
      ACamposChave: array of string): Integer;

    // recordcount
    function GetRecordCount(ATabela: TTabela; ACamposWhere: array of string)
      : Integer; overload;
    function GetRecordCount(ATabela: string; AWhere: string): Integer; overload;

    // crud
    function Inserir(ATabela: TTabela): Integer; overload;
    function Inserir(ATabela: TTabela; ACampos: array of string; AFlag: TFlagCampos = fcIgnore): Integer; overload;
    function Inserir(ATabela: TTabela; ACampos: array of string;
    ACamposRequiredFalse: array of string; AFlag: TFlagCampos = fcIgnore): Integer; overload;

    function Salvar(ATabela: TTabela): Integer; overload;
    function Salvar(ATabela: TTabela; ACampos: array of string;
      AFlag: TFlagCampos = fcAdd): Integer; overload;

    function Excluir(ATabela: TTabela): Integer; overload;
    function Excluir(ATabela: TTabela; AWhere: array of string): Integer; overload;
    function Excluir(ATabela: string; AWhereValue: string): Integer; overload;
    function ExcluirTodos(ATabela: TTabela): Integer; overload;

    function Buscar(ATabela: TTabela): Integer;
    function BuscarID(ATabela: TTabela): TDataSet;

    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;
    function  InTransaction: Boolean;

    property DataSet: TDataSet read FDataSet write SetDataSet;
  end;

//  TDaoUib = class(TDaoBase)
//  private
//    // conexao com o banco de dados
//    FDatabase: TUIBDataBase;
//    FTransaction: TUIBTransaction;
//
//  protected
//    // m�todos respons�veis por setar os par�metros
//    procedure QryParamInteger(ARecParams: TRecParams); override;
//    procedure QryParamString(ARecParams: TRecParams); override;
//    procedure QryParamDate(ARecParams: TRecParams); override;
//    procedure QryParamCurrency(ARecParams: TRecParams); override;
//    procedure QryParamVariant(ARecParams: TRecParams); override;
//
//    //m�todos para setar os variados tipos de campos
//    procedure SetaCamposInteger(ARecParams: TRecParams); override;
//    procedure SetaCamposString(ARecParams: TRecParams); override;
//    procedure SetaCamposDate(ARecParams: TRecParams); override;
//    procedure SetaCamposCurrency(ARecParams: TRecParams); override;
//
//    function ExecutaQuery: Integer; override;
//    procedure FechaQuery; override;
//  public
//    //query para execu��o dos comandos crud
//    Qry: TUIBQuery;
//
//    constructor Create(ADatabaseName: string);
//
//    function Inserir(ATabela: TTabela): Integer; override;
//    function Salvar(ATabela: TTabela): Integer;  override;
//    function Excluir(ATabela: TTabela): Integer; override;
//    function Buscar(ATabela:TTabela): Integer; override;
//
//    function InTransaction: Boolean; override;
//    procedure StartTransaction; override;
//    procedure Commit; override;
//    procedure RollBack; override;
//  end;

implementation

{ TDaoUib }

uses Vcl.forms, dialogs, System.TypInfo;

constructor TDaoUib.Create(ADatabaseName: string);
begin
  inherited Create;

  FDatabase := TUIBDataBase.Create(Application);
  //configura��es iniciais da conex�o
  with FDatabase do
  begin
    DatabaseName := ADatabaseName;
    Params.Add('sql_dialect=3');
    Params.Add('lc_ctype=ISO8859_1');
    Connected := True;
  end;

  FTransaction := TUIBTransaction.Create(Application);
  //configura��es iniciais da transacao
  with FTransaction do
  begin
    Database := FDatabase;
    DefaultAction := etmCommit;
  end;

  Qry := TUIBQuery.Create(Application);
  Qry.DataBase := FDatabase;
  Qry.Transaction := FTransaction;
end;

function TDaoUib.DbToTabela<T>(ATabela: TTabela;
  ADataSet: TDataSet): TObjectList<T>;
begin

end;

destructor TDaoUib.Destroy;
begin

  inherited;
end;

procedure TDaoUib.QryParamCurrency(ARecParams: TRecParams);
begin
  inherited;
  with ARecParams do
  begin
    TUIBQuery(Qry).Params.ByNameAsCurrency[Campo] := Prop.GetValue(Tabela).AsCurrency;
  end;
end;

procedure TDaoUib.QryParamDate(ARecParams: TRecParams);
begin
  inherited;
  with ARecParams do
  begin
    TUIBQuery(Qry).Params.ByNameAsDateTime[Campo] := Prop.GetValue(Tabela).AsType<TDateTime>;
  end;
end;

procedure TDaoUib.QryParamInteger(ARecParams: TRecParams);
begin
  inherited;
  with ARecParams do
  begin
   TUIBQuery(Qry).Params.ByNameAsInteger[Campo] := Prop.GetValue(Tabela).AsInteger;
  end;
end;

procedure TDaoUib.QryParamString(ARecParams: TRecParams);
begin
  inherited;
  with ARecParams do
  begin
    TUIBQuery(Qry).Params.ByNameAsString[Campo] := Prop.GetValue(Tabela).AsString;
  end;
end;

procedure TDaoUib.QryParamVariant(ARecParams: TRecParams);
begin
  inherited;
  with ARecParams do
  begin
    TUIBQuery(Qry).Params.ByNameAsVariant[Campo] := Prop.GetValue(Tabela).AsVariant;
  end;
end;

prfunction TDaoUib.Salvar(ATabela: TTabela; ACampos: array of string;
  AFlag: TFlagCampos): Integer;
begin

end;

ofunction TDaoUib.SelectAll(ATabela: TTabela; AOrderBy: string): TDataSet;
begin

end;

cedure TDaoUib.SetaCamposCurrency(ARecParams: TRecParams);
begin
  inherited;
  with ARecParams do
  begin
    Prop.SetValue(Tabela, TUIBQuery(Qry).Fields.ByNameAsCurrency[Campo]);
  end;
end;

procedure TDaoUib.SetaCamposDate(ARecParams: TRecParams);
begin
  inherited;
  with ARecParams do
  begin
    Prop.SetValue(Tabela, TUIBQuery(Qry).Fields.ByNameAsDateTime[Campo]);
  end;
end;

procedure TDaoUib.SetaCamposInteger(ARecParams: TRecParams);
begin
  inherited;
  with ARecParams do
  begin
    Prop.SetValue(Tabela, TUIBQuery(Qry).Fields.ByNameAsInteger[Campo]);
  end;
end;

procedure TDaoUib.SetaCamposString(ARecParams: TRecParams);
begin
  inherited;
  with ARecParams do
  begin
    Prop.SetValue(Tabela, TUIBQuery(Qry).Fields.ByNameAsString[Campo]);
  end;
end;

function TDaoUib.Inserir(ATabela: TTabela; ACampos: array of string;
  AFlag: TFlagCampos): Integer;
begin

end;

function TDaoUib.Inserir(ATabela: TTabela; ACampos,
  ACamposRequiredFalse: array of string; AFlag: TFlagCampos): Integer;
begin

end;

procedure TDaoUib.SetDataSet(const Value: TDataSet);
begin

end;

function TDaoUib.InTransaction: Boolean;
begin
  Result := FTransaction.InTransaction;
end;

procedure TDaoUib.Limpar(ATabela: TTabela);
begin

end;

procedure TDaoUib.StartTransaction;
begin
  FTransaction.StartTransaction;
end;

procedure TDaoUib.RollBack;
begin
  FTransaction.RollBack;
end;

function TDaoUib.BuscarID(ATabela: TTabela): TDataSet;
begin

end;

procedure TDaoUib.Commit;
begin
  FTransaction.Commit;
end;

function TDaoUib.ConsultaAll(ATabela: TTabela; AOrderBy: string): TDataSet;
begin

end;

function TDaoUib.ConsultaGen<T>(ATabela: TTabela;
  ACamposWhere: array of string): TObjectList<T>;
begin

end;

function TDaoUib.ConsultaSql(ASql: string;
  const ParamList: array of Variant): TDataSet;
begin

end;

function TDaoUib.ConsultaSql(ATabela, AWhere: string): TDataSet;
begin

end;

function TDaoUib.ConsultaSql(ASql: string): TDataSet;
begin

end;

function TDaoUib.ConsultaSql(ASql: string; pFetchAll: Boolean): TDataSet;
begin

end;

function TDaoUib.ConsultaSqlExecute(ASql: string): TDataSet;
begin

end;

function TDaoUib.ConsultaTab(ATabela: TTabela; ACampos, ACamposWhere,
  AOrdem: array of string; TipoOrdem: Integer): TDataSet;
begin

end;

function TDaoUib.ConsultaTab(ATabela: TTabela; ACampos,
  ACamposWhere: array of string): TDataSet;
begin

end;

function TDaoUib.ConsultaTab(ATabela: TTabela;
  ACamposWhere: array of string): TDataSet;
begin

end;

function TDaoUib.ConsultaTabela(ATabela: TTabela;
  ACamposWhere: array of string): TFDQuery;
begin

end;

procedure FechaQuery;
begin
  Qry.Close;
  Qry.SQL.Clear;
end;

function TDaoUib.Exefunction TDaoUib.Excluir(ATabela: TTabela; AWhere: array of string): Integer;
begin

end;

function TDaoUib.Excluir(ATabela, AWhereValue: string): Integer;
begin

end;

function TDaoUib.GerarClasse(ATabela, ANomeUnit, ANomeClasse: string): string;
begin

end;

function TDaoUib.GetID(ATabela: TTabela; ACampo: string): Integer;
begin

end;

function TDaoUib.GetMax(ATabela: TTabela; ACampo: string;
  ACamposChave: array of string): Integer;
begin

end;

function TDaoUib.GetRecordCount(ATabela, AWhere: string): Integer;
begin

end;

function TDaoUib.GetRecordCount(ATabela: TTabela;
  ACamposWhere: array of string): Integer;
begin

end;

function TDaoUib.ExecutaQuery: Integer;
begin
  with Qry do
  begin
    Prepare();
    ExecSQL;
    Result := RowsAffected;
  end;
end;

function TDaoUib.Excluir(ATabela: TTabela): Integer;
var
  Comando: TFuncReflexao;
begin
  //crio uma vari�vel do tipo TFuncReflexao - um m�todo an�nimo
  Comando := function(ACampos: TCamposAnoni): Integer
  var
    Campo: string;
    PropRtti: TRttiProperty;
  begin
    FechaQuery;
    with Qry do
    begin
      sql.Add('Delete from ' + ACampos.NomeTabela);
      sql.Add('Where');

      //percorrer todos os campos da chave prim�ria
      ACampos.Sep := '';
      for Campo in ACampos.PKs do
      begin
        sql.Add(ACampos.Sep+ Campo + '= :' + Campo);
        ACampos.Sep := ' and ';
        // setando os par�metros
        for PropRtti in ACampos.TipoRtti.GetProperties do
          if CompareText(PropRtti.Name, Campo) = 0 then
            begin
              ConfiguraParametro(PropRtti, Campo, ATabela, Qry);
            end;
      end;
    end;
    Result := ExecutaQuery;
  end;

  //reflection da tabela e execu��o da query preparada acima.
  Result := ReflexaoSQL(ATabela, Comando);
end;

function TDaoUib.Inserir(ATabela: TTabela): Integer;
begin
 Result := Self.Inserir(ATabela, []);
end;

function TDaoUib.Salvar(ATabela: TTabela): Integer;
var
  Comando: TFuncReflexao;
begin
  Comando := function(ACampos: TCamposAnoni): Integer
  var
    Campo: string;
    PropRtti: TRttiProperty;
  begin
    FechaQuery;
    with Qry do
    begin
      sql.Add('Update ' + ACampos.NomeTabela);
      sql.Add('set');

      //campos da tabela
      ACampos.Sep := '';
      for PropRtti in ACampos.TipoRtti.GetProperties do
      begin
        SQL.Add(ACampos.Sep + PropRtti.Name + '=:'+PropRtti.Name);
        ACampos.Sep := ',';
      end;
      sql.Add('where');

      //par�metros da cl�usula where
      ACampos.Sep := '';
      for Campo in ACampos.PKs do
      begin
        sql.Add(ACampos.Sep+ Campo + '= :' + Campo);
        ACampos.Sep := ' and ';
      end;

      //valor dos par�metros
      for PropRtti in ACampos.TipoRtti.GetProperties do
      begin
        Campo := PropRtti.Name;
        ConfiguraParametro(PropRtti, Campo, ATabela, Qry);
      end;
    end;
    Result := ExecutaQuery;
  end;

  //reflection da tabela e execu��o da query preparada acima.
  Result := ReflexaoSQL(ATabela, Comando);
end;

function TDaoUib.Buscar(ATabela: TTabela): Integer;
var
  Comando: TFuncReflexao;
  Dados: TUIBQuery;
begin
  Dados := TUIBQuery.Create(nil);
  try
    //crio uma vari�vel do tipo TFuncReflexao - um m�todo an�nimo
    Comando := function(ACampos: TCamposAnoni): Integer
    var
      Campo: string;
      PropRtti: TRttiProperty;
    begin
      with Dados do
      begin
        Database := FDatabase;
        Transaction := FTransaction;
        sql.Add('select * from ' + ACampos.NomeTabela);
        sql.Add('Where');

        //percorrer todos os campos da chave prim�ria
        ACampos.Sep := '';
        for Campo in ACampos.PKs do
        begin
          sql.Add(ACampos.Sep+ Campo + '= :' + Campo);
          ACampos.Sep := ' and ';
          // setando os par�metros
          for PropRtti in ACampos.TipoRtti.GetProperties do
            if CompareText(PropRtti.Name, Campo) = 0 then
              begin
                ConfiguraParametro(PropRtti, Campo, ATabela, Dados, True);
              end;
        end;
        Open;
        Result := Fields.RecordCount;
        if Result > 0 then
        begin
          for PropRtti in ACampos.TipoRtti.GetProperties do
          begin
            Campo := PropRtti.Name;
            SetaDadosTabela(PropRtti, Campo, ATabela, Dados);
            ACampos.Sep := ',';
          end;
        end;
      end;
    end;

    //reflection da tabela e abertura da query preparada acima.
    Result := ReflexaoSQL(ATabela, Comando);
  finally
    Dados.Free;
  end;
end;

end.
function TDaoUib.ExcluirTodos(ATabela: TTabela): Integer;
begin

end;


