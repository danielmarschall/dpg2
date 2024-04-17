object MenuForm: TMenuForm
  Left = 440
  Top = 233
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Der Panzergeneral 2'
  ClientHeight = 199
  ClientWidth = 199
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnMouseMove = HintergrundMouseMove
  OnShow = FormShow
  TextHeight = 13
  object Hintergrund: TImage
    Left = 0
    Top = 0
    Width = 201
    Height = 169
    Stretch = True
    OnMouseMove = HintergrundMouseMove
  end
  object VersionLabel: TLabel
    Left = 3
    Top = 0
    Width = 62
    Height = 20
    Caption = 'Version'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Name1: TLabel
    Left = 32
    Top = 80
    Width = 97
    Height = 13
    Caption = 'Name des Dinos:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object Name2: TLabel
    Left = 32
    Top = 32
    Width = 110
    Height = 13
    Caption = 'Name des Panzers:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object Start: TBitBtn
    Left = 32
    Top = 24
    Width = 137
    Height = 25
    Caption = '&Starten'
    Default = True
    TabOrder = 0
    OnClick = StartClick
    OnMouseMove = StartMouseMove
  end
  object Optionen: TBitBtn
    Left = 32
    Top = 56
    Width = 137
    Height = 25
    Caption = '&Einstellungen'
    TabOrder = 1
    OnClick = OptionenClick
    OnMouseMove = OptionenMouseMove
  end
  object Ende: TBitBtn
    Left = 32
    Top = 120
    Width = 137
    Height = 25
    Cancel = True
    Caption = '&Beenden'
    TabOrder = 2
    OnClick = EndeClick
    OnMouseMove = EndeMouseMove
  end
  object Los: TBitBtn
    Left = 0
    Top = 144
    Width = 97
    Height = 25
    Caption = '&Los geht'#180's'
    Default = True
    TabOrder = 3
    Visible = False
    OnClick = LosClick
    OnMouseMove = LosMouseMove
  end
  object Abb: TBitBtn
    Left = 104
    Top = 144
    Width = 97
    Height = 25
    Caption = '&Abbrechen'
    TabOrder = 4
    Visible = False
    OnClick = AbbClick
    OnMouseMove = AbbMouseMove
  end
  object Edit1: TEdit
    Left = 32
    Top = 48
    Width = 137
    Height = 21
    MaxLength = 7
    TabOrder = 5
    Visible = False
    OnKeyPress = EditKeyPress
  end
  object Edit2: TEdit
    Left = 32
    Top = 96
    Width = 137
    Height = 21
    MaxLength = 7
    TabOrder = 6
    Visible = False
    OnKeyPress = EditKeyPress
  end
  object CopyPanel: TPanel
    Left = 0
    Top = 168
    Width = 201
    Height = 33
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 7
    object CopyLabel1: TLabel
      Left = 3
      Top = 3
      Width = 62
      Height = 13
      Caption = '[Copyright]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object CopyLabel2: TLabel
      Left = 3
      Top = 18
      Width = 142
      Height = 13
      Caption = 'Alle Rechte vorbehalten!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
  end
end
