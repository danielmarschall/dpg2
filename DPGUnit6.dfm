object SplashForm: TSplashForm
  Left = 283
  Top = 203
  Cursor = crHourGlass
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Der Panzergeneral 2'
  ClientHeight = 169
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Hintergrund: TImage
    Left = 0
    Top = 0
    Width = 329
    Height = 169
    Cursor = crHourGlass
    Align = alClient
  end
  object Bevel: TBevel
    Left = 8
    Top = 120
    Width = 313
    Height = 2
    Shape = bsBottomLine
    Style = bsRaised
  end
  object NameLabel: TLabel
    Left = 8
    Top = 8
    Width = 131
    Height = 51
    Caption = 'DPG II'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -44
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object WaitLabel: TLabel
    Left = 46
    Top = 54
    Width = 258
    Height = 44
    Caption = 'wird geladen...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -37
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
end
