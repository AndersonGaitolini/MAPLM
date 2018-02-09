object dmMapLM2: TdmMapLM2
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 227
  Width = 333
  object conMapLM2: TFDConnection
    Params.Strings = (
      'Database=E:\Arquivos\2_Dev\Projetos\MapNovo\MAPLM.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=localhost'
      'DriverID=FB')
    LoginPrompt = False
    Left = 25
    Top = 119
  end
  object fdtrMapLM2: TFDTransaction
    Connection = conMapLM2
    Left = 107
    Top = 123
  end
  object fdDriverFBMapLM: TFDPhysFBDriverLink
    Left = 187
    Top = 124
  end
end
