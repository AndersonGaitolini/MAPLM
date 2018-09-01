object dmMapLM: TdmMapLM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 217
  Width = 426
  object conMapLm: TFDConnection
    Params.Strings = (
      'Database=C:\Program Files (x86)\MapeadorLM\MAPLM.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=localhost'
      'CharacterSet=WIN1252'
      'Port=3050'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = fdtrMapLm
    Left = 19
    Top = 31
  end
  object fdtrMapLm: TFDTransaction
    Connection = conMapLm
    Left = 83
    Top = 32
  end
  object fddrfbMapLM: TFDPhysFBDriverLink
    Left = 152
    Top = 33
  end
  object qryMapLm_Config: TFDQuery
    Connection = conMapLm
    Transaction = fdtrMapLm
    SQL.Strings = (
      'select * from maplm_config')
    Left = 46
    Top = 124
  end
  object dsMapLm_Config: TDataSource
    DataSet = cdsMapLm_Config
    Left = 151
    Top = 123
  end
  object cdsMapLm_Config: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'provMapLm_Config'
    Left = 236
    Top = 119
    object cdsMapLm_ConfigID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsMapLm_ConfigSTATUS: TSmallintField
      FieldName = 'STATUS'
    end
    object cdsMapLm_ConfigVERSAO: TSmallintField
      FieldName = 'VERSAO'
    end
    object cdsMapLm_ConfigNOME_CONFIG: TStringField
      FieldName = 'NOME_CONFIG'
      Size = 100
    end
    object cdsMapLm_ConfigPATH_P_CONFIG: TStringField
      FieldName = 'PATH_P_CONFIG'
      Size = 255
    end
    object cdsMapLm_ConfigPATH_H_CONFIG: TStringField
      FieldName = 'PATH_H_CONFIG'
      Size = 255
    end
    object cdsMapLm_ConfigPATH_M_CONFIG: TStringField
      FieldName = 'PATH_M_CONFIG'
      Size = 255
    end
    object cdsMapLm_ConfigPATH_U_CONFIG: TStringField
      FieldName = 'PATH_U_CONFIG'
      Size = 255
    end
    object cdsMapLm_ConfigPATH_V_CONFIG: TStringField
      FieldName = 'PATH_V_CONFIG'
      Size = 255
    end
    object cdsMapLm_ConfigNUM_REV_SVN: TIntegerField
      FieldName = 'NUM_REV_SVN'
    end
    object cdsMapLm_ConfigNUM_REV_WORKCOPY: TIntegerField
      FieldName = 'NUM_REV_WORKCOPY'
    end
    object cdsMapLm_ConfigLINK_REVISAO: TStringField
      FieldName = 'LINK_REVISAO'
      Size = 100
    end
    object cdsMapLm_ConfigTIPO_REVISAO: TStringField
      FieldName = 'TIPO_REVISAO'
      Size = 50
    end
    object cdsMapLm_ConfigDATA_REVISAO: TDateField
      FieldName = 'DATA_REVISAO'
    end
    object cdsMapLm_ConfigDATA_BUILD: TDateField
      FieldName = 'DATA_BUILD'
    end
  end
  object provMapLm_Config: TDataSetProvider
    DataSet = qryMapLm_Config
    Left = 325
    Top = 116
  end
end
