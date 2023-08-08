object FormVCL: TFormVCL
  Left = 0
  Top = 0
  Caption = 'FormVCL'
  ClientHeight = 661
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object ListView1: TListView
    Left = 40
    Top = 72
    Width = 337
    Height = 193
    Columns = <
      item
        Caption = #51452#49548
        Width = 200
      end
      item
        Caption = #51060#47492
        Width = 100
      end>
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Button1: TButton
    Left = 40
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 40
    Top = 352
    Width = 337
    Height = 265
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Button2: TButton
    Left = 40
    Top = 312
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
end
