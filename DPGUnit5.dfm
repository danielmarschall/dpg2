object VideoForm: TVideoForm
  Left = 271
  Top = 141
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Der Panzergeneral 2'
  ClientHeight = 385
  ClientWidth = 585
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnHide = FormHide
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  TextHeight = 13
  object Weiter: TBitBtn
    Left = 480
    Top = 320
    Width = 97
    Height = 25
    Caption = '&Weiter'
    TabOrder = 0
    OnClick = WeiterClick
    OnMouseMove = WeiterMouseMove
  end
  object Beenden: TBitBtn
    Left = 480
    Top = 352
    Width = 97
    Height = 25
    Caption = '&Beenden'
    TabOrder = 1
    OnClick = BeendenClick
    OnMouseMove = BeendenMouseMove
  end
  object VideoPanel1: TPanel
    Left = 8
    Top = 8
    Width = 465
    Height = 369
    TabOrder = 2
    object VideoPanel2: TPanel
      Left = 8
      Top = 8
      Width = 449
      Height = 353
      BevelOuter = bvLowered
      TabOrder = 0
      object AviPlayer: TMediaPlayer
        Left = 4
        Top = 326
        Width = 29
        Height = 20
        ColoredButtons = []
        EnabledButtons = [btPlay]
        VisibleButtons = [btPlay]
        AutoRewind = False
        DoubleBuffered = True
        Display = VideoPanel2
        Visible = False
        ParentDoubleBuffered = False
        TabOrder = 0
      end
      object WavePlayer: TMediaPlayer
        Left = 36
        Top = 326
        Width = 29
        Height = 20
        ColoredButtons = []
        EnabledButtons = [btPlay]
        VisibleButtons = [btPlay]
        AutoRewind = False
        DoubleBuffered = True
        Display = WavePlayer
        Visible = False
        ParentDoubleBuffered = False
        TabOrder = 1
      end
    end
  end
  object VideoTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = VideoTimerTimer
    Left = 552
    Top = 8
  end
end
