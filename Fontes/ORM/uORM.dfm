object frmGerenciadorORM: TfrmGerenciadorORM
  Left = 0
  Top = 0
  Caption = 'Gerenciador ORM'
  ClientHeight = 242
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 453
    Height = 242
    ActivePage = tsORMBasico
    Align = alClient
    TabOrder = 0
    TabWidth = 225
    object tsOrmAnderson: TTabSheet
      Caption = 'Orm Anderson'
      object btnGeraClasse: TButton
        Left = -4
        Top = 39
        Width = 449
        Height = 25
        Caption = 'Gera Classe'
        TabOrder = 0
        OnClick = btnGeraClasseClick
      end
    end
    object tsORMBasico: TTabSheet
      Caption = 'ORM B'#225'sico'
      ImageIndex = 1
      object btn1: TButton
        Left = -3
        Top = 47
        Width = 447
        Height = 25
        Caption = 'Gera Classe'
        TabOrder = 0
        OnClick = btn1Click
      end
    end
  end
end
