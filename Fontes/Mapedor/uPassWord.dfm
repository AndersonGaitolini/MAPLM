object frmPasswordDlg: TfrmPasswordDlg
  Left = 245
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Password autenticcation'
  ClientHeight = 93
  ClientWidth = 233
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = True
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 9
    Width = 79
    Height = 13
    Caption = 'Enter password:'
  end
  object edPassword: TEdit
    Left = 8
    Top = 27
    Width = 217
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    OnExit = edPasswordExit
  end
  object OKBtn: TButton
    Left = 70
    Top = 59
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 150
    Top = 59
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
