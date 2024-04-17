object SpielForm: TSpielForm
  Left = 218
  Top = 135
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Der Panzergeneral 2'
  ClientHeight = 381
  ClientWidth = 527
  Color = 4420988
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = Menu
  OldCreateOrder = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Menu: TMainMenu
    Images = ImageList
    Left = 8
    Top = 8
    object Spiel: TMenuItem
      Caption = '&Spiel'
      ImageIndex = 9
      object Neustart: TMenuItem
        Caption = '&Neustart'
        ImageIndex = 0
        ShortCut = 112
        OnClick = NeustartClick
      end
      object Pause: TMenuItem
        Caption = '&Pause'
        ImageIndex = 2
        ShortCut = 113
        OnClick = pauseClick
      end
      object Leer1: TMenuItem
        Caption = '-'
      end
      object Hauptmenue: TMenuItem
        Caption = '&Zur'#252'ck zum Hauptmen'#252
        ImageIndex = 2
        ShortCut = 114
        OnClick = HauptmenueClick
      end
      object Beenden: TMenuItem
        Caption = 'Be&enden'
        ImageIndex = 1
        ShortCut = 27
        OnClick = BeendenClick
      end
    end
    object Internet: TMenuItem
      Caption = '&Internet'
      ImageIndex = 3
      object Link1: TMenuItem
        Caption = 'Zur &MD-Technologie-Webseite'
        ImageIndex = 3
        OnClick = InternetClick
      end
      object Link2: TMenuItem
        Caption = 'Zu &Daniel Marschall'#39's Webportal'
        ImageIndex = 3
        OnClick = InternetClick
      end
      object Link3: TMenuItem
        Caption = 'Zur Via&ThinkSoft-Webseite'
        ImageIndex = 3
        OnClick = InternetClick
      end
      object Leer2: TMenuItem
        Caption = '-'
      end
      object NeuesteVersion: TMenuItem
        Caption = 'DPG2-&Projektseite auf ViaThinkSoft'
        ImageIndex = 5
        OnClick = InternetClick
      end
      object VerbesserungsEMail: TMenuItem
        Caption = '&Verbesserungs E-Mail abschicken'
        ImageIndex = 4
        OnClick = InternetClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Updates: TMenuItem
        Caption = 'Auf &Updates pr'#252'fen...'
        ImageIndex = 3
        OnClick = UpdatesClick
      end
    end
    object HighScore: TMenuItem
      Caption = 'High&Scores'
      ImageIndex = 8
      object Anzeigen: TMenuItem
        Caption = '&Anzeigen'
        ImageIndex = 5
        ShortCut = 16449
        OnClick = HilfeClick
      end
      object Leer3: TMenuItem
        Caption = '-'
      end
      object Leeren: TMenuItem
        Caption = 'Leeren'
        ImageIndex = 2
        ShortCut = 16460
        OnClick = LeerenClick
      end
    end
    object Hilfe: TMenuItem
      Caption = '&Hilfe'
      ImageIndex = 6
      object Geschichte: TMenuItem
        Caption = '&Geschichte'
        ImageIndex = 6
        ShortCut = 119
        OnClick = HilfeClick
      end
      object Ziel: TMenuItem
        Caption = '&Ziel'
        ImageIndex = 6
        ShortCut = 120
        OnClick = HilfeClick
      end
      object Steuerung: TMenuItem
        Caption = '&Steuerung'
        ImageIndex = 6
        ShortCut = 121
        OnClick = HilfeClick
      end
      object Leer4: TMenuItem
        Caption = '-'
      end
      object Info: TMenuItem
        Caption = '&Informationen'
        ImageIndex = 8
        ShortCut = 122
        OnClick = HilfeClick
      end
      object Leer5: TMenuItem
        Caption = '-'
      end
      object Mitarbeiter: TMenuItem
        Caption = '&Mitarbeiter'
        ImageIndex = 7
        ShortCut = 123
        OnClick = HilfeClick
      end
    end
  end
  object ImageList: TImageList
    Left = 40
    Top = 8
  end
end
