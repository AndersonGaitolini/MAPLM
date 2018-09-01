unit ormbr.model.login;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 
  /// orm 
  ormbr.types.blob, 
  ormbr.types.lazy, 
  ormbr.types.mapping, 
  ormbr.types.nullable, 
  ormbr.mapping.classes, 
  ormbr.mapping.register, 
  ormbr.mapping.attributes; 

type
  [Entity]
  [Table('LOGIN', '')]
  TLOGIN = class
  private
    { Private declarations } 
    FID: Integer;
    FUSUARIO: Nullable<String>;
    FSENHA: String;
  public 
    { Public declarations } 
    [Restrictions([NotNull])]
    [Column('ID', ftInteger)]
    [Dictionary('ID', 'Mensagem de validação', '', '', '', taCenter)]
    property ID: Integer read FID write FID;

    [Column('USUARIO', ftString, 20)]
    [Dictionary('USUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USUARIO: Nullable<String> read FUSUARIO write FUSUARIO;

    [Restrictions([NotNull])]
    [Column('SENHA', ftString, 12)]
    [Dictionary('SENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SENHA: String read FSENHA write FSENHA;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TLOGIN)

end.
