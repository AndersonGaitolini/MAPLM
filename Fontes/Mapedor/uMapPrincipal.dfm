object frmPricipalMapLM: TfrmPricipalMapLM
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'uFrmMapeadorLM'
  ClientHeight = 399
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  PrintScale = poNone
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 23
    Width = 314
    Height = 357
    ActivePage = ts2
    Align = alClient
    TabOrder = 0
    TabWidth = 100
    object tsConfigurar: TTabSheet
      Caption = '&Configurar'
      object edDir: TJvDirectoryEdit
        Left = 16
        Top = 19
        Width = 278
        Height = 21
        DialogKind = dkWin32
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        Text = ''
        OnChange = edDirChange
        OnClick = edDirClick
        OnMouseEnter = edDirMouseEnter
      end
      object btn1: TBitBtn
        Left = 16
        Top = 118
        Width = 140
        Height = 25
        Caption = '+'
        TabOrder = 4
        OnClick = btn1Click
      end
      object btn2: TBitBtn
        Left = 154
        Top = 118
        Width = 140
        Height = 25
        Caption = '-'
        TabOrder = 5
        OnClick = btn2Click
      end
      object dbgListaMap: TDBGrid
        Left = 15
        Top = 149
        Width = 279
        Height = 168
        DataSource = dmMapLM.dsMapLm_Config
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 6
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = dbgListaMapCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME_CONFIG'
            Title.Caption = 'Mapeamento'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PATH_P_CONFIG'
            Title.Caption = 'Diret'#243'rio'
            Width = 125
            Visible = True
          end>
      end
      object edNomeMap: TEdit
        Left = 16
        Top = 91
        Width = 278
        Height = 21
        TabOrder = 3
      end
      object cbbVersao: TComboBox
        Left = 16
        Top = 56
        Width = 83
        Height = 21
        ItemIndex = 0
        TabOrder = 1
        Text = '70a'
        Items.Strings = (
          '70a'
          '63b')
      end
      object cbbStatus: TComboBox
        Left = 105
        Top = 56
        Width = 83
        Height = 21
        ItemIndex = 1
        TabOrder = 2
        Text = 'Inativo'
        Items.Strings = (
          'Ativo'
          'Inativo')
      end
    end
    object ts2: TTabSheet
      Caption = 'Mapear 70a'
      ImageIndex = 1
      OnShow = ts2Show
      object lbBuildDateTit: TLabel
        Left = 23
        Top = 111
        Width = 52
        Height = 13
        Alignment = taRightJustify
        Caption = 'Build Date:'
      end
      object lbBuildDate: TLabel
        Left = 113
        Top = 110
        Width = 72
        Height = 16
        Caption = '<runtime>'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbSVNRevDateTit: TLabel
        Left = 23
        Top = 130
        Width = 70
        Height = 13
        Alignment = taRightJustify
        Caption = 'Revision Date:'
      end
      object lbSVNRevDate: TLabel
        Left = 113
        Top = 129
        Width = 72
        Height = 16
        Caption = '<runtime>'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 23
        Top = 92
        Width = 84
        Height = 13
        Alignment = taRightJustify
        Caption = 'Revision Number:'
      end
      object lbSVNRev: TLabel
        Left = 113
        Top = 90
        Width = 72
        Height = 16
        Caption = '<runtime>'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbSVNRevRange: TLabel
        Left = 113
        Top = 148
        Width = 72
        Height = 16
        Caption = '<runtime>'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SVNRevRangeTit: TLabel
        Left = 23
        Top = 149
        Width = 48
        Height = 13
        Alignment = taRightJustify
        Caption = 'Workcopy'
      end
      object lbSVNURLTit: TLabel
        Left = 22
        Top = 198
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'SVN Url:'
      end
      object lbSVNURL: TLabel
        Left = 67
        Top = 198
        Width = 52
        Height = 13
        Caption = '<runtime>'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic, fsUnderline]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object lbSVNRelease: TLabel
        Left = 113
        Top = 167
        Width = 72
        Height = 16
        Caption = '<runtime>'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object lbSVNReleaseTit: TLabel
        Left = 23
        Top = 168
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Release'
      end
      object cbbSelectMap70: TComboBox
        Left = 23
        Top = 35
        Width = 145
        Height = 21
        TabOrder = 0
        Text = 'cbbSelectMap70'
        OnChange = cbbSelectMap70Change
      end
      object btnMapOK: TButton
        Left = 188
        Top = 33
        Width = 75
        Height = 25
        Caption = 'OK'
        TabOrder = 1
        OnClick = btnMapOKClick
      end
    end
    object ts3: TTabSheet
      Caption = 'Mapear 63b'
      ImageIndex = 2
    end
  end
  object stat1: TStatusBar
    Left = 0
    Top = 380
    Width = 314
    Height = 19
    Panels = <
      item
        Text = 'Status: '
        Width = 100
      end>
  end
  object tlb1: TToolBar
    Left = 0
    Top = 0
    Width = 314
    Height = 23
    ButtonWidth = 118
    Caption = 'tlb1'
    TabOrder = 2
  end
  object appEvent1: TApplicationEvents
    OnMinimize = appEvent1Minimize
    Left = 255
    Top = 156
  end
  object tmrHint: TTimer
    Interval = 3000
    OnTimer = tmrHintTimer
    Left = 246
    Top = 12
  end
end
