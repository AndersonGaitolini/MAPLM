unit GerarClasse;

interface

uses
  Base, Classes;

type
  TGerarClasse = class
  private
    function Capitalize(ATexto: String): string;
  protected
    Resultado: TStringList;
    GerarClasseBanco: IBaseGerarClasseBanco;

    FTabela,
    FUnit,
    FClasse: string;

    function GetCamposPK: string; virtual; abstract;

    procedure GerarCabecalho;
    procedure GerarFieldsProperties; virtual; abstract;
    procedure GerarRodape;
  public
    constructor Create(AClasseBanco: IBaseGerarClasseBanco);
    destructor Destroy; override;

    function Gerar(ATabela, ANomeUnit: string;
      ANomeClasse: string = ''): string;
  end;

implementation

{ TGerarClasse }

uses SysUtils;

function TGerarClasse.Capitalize(ATexto: String): string;
begin
  Result := UpperCase(ATexto[1]) + LowerCase(Copy(ATexto, 2, Length(ATexto)));
end;

constructor TGerarClasse.Create(AClasseBanco: IBaseGerarClasseBanco);
begin
  inherited Create;
  Resultado := TStringList.Create;
  GerarClasseBanco := AClasseBanco;
end;

destructor TGerarClasse.Destroy;
begin
  Resultado.Free;
  inherited;
end;

function TGerarClasse.Gerar(ATabela, ANomeUnit, ANomeClasse: string): string;
begin
  FTabela := ATabela;

  FUnit := Capitalize(ANomeUnit);

  if Trim(ANomeClasse) = '' then
    FClasse := Capitalize(FTabela)
  else
    FClasse := Capitalize(ANomeClasse);

  GerarCabecalho;

  GerarFieldsProperties;

  GerarRodape;

  Result := Resultado.Text;
end;

procedure TGerarClasse.GerarCabecalho;
begin
  Resultado.clear;
  with Resultado do
  begin
    add('unit u' + FUnit + ';');
    add('');
    add('//*******************************************************************************');
    add('// Projeto: ORM - Anderson Gaitolini                                             ');
    add('//                                                                               ');
    add('// Este projeto busca agilizar o processo de manipulação de dados (DAO/CRUD),    ');
    add('// ou seja,  gerar inserts, updates, deletes nas tabelas de forma automática,    ');
    add('// sem a necessidade de criarmos classes DAOs para cada tabela. Também visa      ');
    add('// facilitar a transição de uma suite de componentes de acesso a dados para      ');
    add('// outra.                                                                        ');
    add('//                                                                               ');
    add('//                                                                               ');
    add('//                                                                               ');
    add('// Anderson Gaitolini - gaitolini@gmail.com                                      ');
    add('//                                                                               ');
    add('//*******************************************************************************');
    add('');
    add('interface');
    add('');
    add('uses');
    add('  Base, System.SysUtils, Atributos, System.Classes,Data.DB,');
    add('  FireDAC.Comp.Client,Vcl.DBGrids,');
    add('  Datasnap.DBClient, Datasnap.Provider,Vcl.Forms,Vcl.Dialogs,Vcl.Controls;');
    add('');
    add('type');
    add('  [attTabela(' + QuotedStr(FTabela) + ')]');
    add('  T' + FClasse + ' = class(TTabela)');
  end;
end;

procedure TGerarClasse.GerarRodape;
begin
  with Resultado do
  begin
    Add('  end;');
    Add('');
    Add('implementation');
    Add('');
    Add('end.');
    Add('');
    Add('//Anderson Gaitolini');
  end;
end;

end.
