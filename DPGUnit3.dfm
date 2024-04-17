object HilfeForm: THilfeForm
  Left = 464
  Top = 252
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Hilfe'
  ClientHeight = 319
  ClientWidth = 247
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 249
    Height = 321
    TabOrder = 0
    object CaptionLabel: TLabel
      Left = 8
      Top = 8
      Width = 60
      Height = 32
      Caption = 'Hilfe'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object weiter: TBitBtn
      Left = 40
      Top = 288
      Width = 169
      Height = 25
      Caption = '&Weiter'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = WeiterClick
      OnMouseMove = weiterMouseMove
    end
    object TextMemo: TMemo
      Left = 8
      Top = 48
      Width = 233
      Height = 233
      TabStop = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
      OnMouseMove = FormMouseMove
    end
  end
end
