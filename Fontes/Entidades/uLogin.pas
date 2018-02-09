unit uLogin;

//*******************************************************************************
// Projeto: ORM - Anderson Gaitolini                                             
//                                                                               
// Este projeto busca agilizar o processo de manipula��o de dados (DAO/CRUD),    
// ou seja,  gerar inserts, updates, deletes nas tabelas de forma autom�tica,    
// sem a necessidade de criarmos classes DAOs para cada tabela. Tamb�m visa      
// facilitar a transi��o de uma suite de componentes de acesso a dados para      
// outra.                                                                        
//                                                                               
//                                                                               
//                                                                               
// Anderson Gaitolini - gaitolini@gmail.com                                      
//                                                                               
//*******************************************************************************

interface

uses
  Base, System.SysUtils, Atributos, System.Classes,Data.DB,
  FireDAC.Comp.Client,Vcl.DBGrids,
  Datasnap.DBClient, Datasnap.Provider,Vcl.Forms,Vcl.Dialogs,Vcl.Controls;

type
  [attTabela('LOGIN')]
  TLogin = class(TTabela)
  private
    FId: Integer;
    FUsuario: string;
    FSenha: string;
    FMapatual: Integer;
  public
    [attPK]
    property Id: Integer read FId write FId;
    property Usuario: string read FUsuario write FUsuario;
    property Senha: string read FSenha write FSenha;
    property Mapatual: Integer read FMapatual write FMapatual;
  end;

implementation

end.

//Anderson Gaitolini
