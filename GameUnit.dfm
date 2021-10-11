object GameForm: TGameForm
  Left = 619
  Top = 243
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = '2048'
  ClientHeight = 517
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Comic Sans MS'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 23
  object Field: TImage
    Left = 0
    Top = 0
    Width = 449
    Height = 516
  end
  object Memo1: TMemo
    Left = 80
    Top = 48
    Width = 185
    Height = 89
    Lines.Strings = (
      '')
    TabOrder = 0
    Visible = False
  end
  object Edit1: TEdit
    Left = 156
    Top = 8
    Width = 153
    Height = 31
    MaxLength = 8
    TabOrder = 1
    Visible = False
    OnKeyPress = Edit1KeyPress
  end
  object MainMenu1: TMainMenu
    Top = 48
    object N7: TMenuItem
      Caption = #1053#1086#1074#1072#1103' '#1080#1075#1088#1072
      OnClick = N7Click
    end
    object N2: TMenuItem
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1080#1084#1103
      OnClick = N2Click
    end
    object N1: TMenuItem
      Caption = #1056#1077#1078#1080#1084
      object N5: TMenuItem
        Caption = #1057#1090#1072#1085#1076#1072#1088#1090#1085#1099#1081
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = #1053#1086#1074#1099#1081
        OnClick = N6Click
      end
    end
    object N3: TMenuItem
      Caption = #1057#1085#1080#1084#1086#1082' '#1101#1082#1088#1072#1085#1072
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = N4Click
    end
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Top = 72
  end
  object XPManifest1: TXPManifest
    Left = 288
    Top = 64
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Top = 104
  end
end
