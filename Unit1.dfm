object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Waveshare LCD Brightness'
  ClientHeight = 116
  ClientWidth = 477
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 425
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Device not found'
    Visible = False
  end
  object TrackBar1: TTrackBar
    Left = 24
    Top = 40
    Width = 433
    Height = 45
    Max = 100
    Frequency = 5
    Position = 50
    TabOrder = 0
    OnChange = TrackBar1Change
  end
  object XPManifest1: TXPManifest
    Left = 440
    Top = 80
  end
end
