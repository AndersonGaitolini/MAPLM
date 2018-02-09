unit uMaplm_config;

//*******************************************************************************
// Projeto: ORM - Anderson Gaitolini                                             
//                                                                               
// Este projeto busca agilizar o processo de manipulação de dados (DAO/CRUD),    
// ou seja,  gerar inserts, updates, deletes nas tabelas de forma automática,    
// sem a necessidade de criarmos classes DAOs para cada tabela. Também visa      
// facilitar a transição de uma suite de componentes de acesso a dados para      
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
  [attTabela('MAPLM_CONFIG')]
  TMaplm_config = class(TTabela)
  private
    FId: Integer;
    FStatus: Integer;
    FVersao: Integer;
    FNome_config: string;
    FPath_p_config: string;
    FPath_h_config: string;
    FPath_m_config: string;
    FPath_u_config: string;
    FPath_v_config: string;
    FNum_rev_svn: Integer;
    FNum_rev_workcopy: Integer;
    FLink_revisao: string;
    FTipo_revisao: string;
    FData_revisao: TDate;
    FData_build: TDate;
    FId_login: Integer;
  public
    [attPK]
    property Id: Integer read FId write FId;
    property Status: Integer read FStatus write FStatus;
    property Versao: Integer read FVersao write FVersao;
    property Nome_config: string read FNome_config write FNome_config;
    property Path_p_config: string read FPath_p_config write FPath_p_config;
    property Path_h_config: string read FPath_h_config write FPath_h_config;
    property Path_m_config: string read FPath_m_config write FPath_m_config;
    property Path_u_config: string read FPath_u_config write FPath_u_config;
    property Path_v_config: string read FPath_v_config write FPath_v_config;
    property Num_rev_svn: Integer read FNum_rev_svn write FNum_rev_svn;
    property Num_rev_workcopy: Integer read FNum_rev_workcopy write FNum_rev_workcopy;
    property Link_revisao: string read FLink_revisao write FLink_revisao;
    property Tipo_revisao: string read FTipo_revisao write FTipo_revisao;
    property Data_revisao: TDate read FData_revisao write FData_revisao;
    property Data_build: TDate read FData_build write FData_build;
    property Id_login: Integer read FId_login write FId_login;
  end;

implementation

end.

//Anderson Gaitolini
