object DataModule1: TDataModule1
  Height = 384
  Width = 464
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 216
    Top = 88
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'Database=D:\5sh_Delphi\Edu_2023\4-1_LocalDB\stest.db')
    LoginPrompt = False
    BeforeConnect = FDConnection1BeforeConnect
    Left = 104
    Top = 89
  end
end
