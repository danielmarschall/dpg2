object EinstellungForm: TEinstellungForm
  Left = 269
  Top = 188
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Der Panzergeneral 2 Einstellungen'
  ClientHeight = 353
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  TextHeight = 13
  object DinoLbl: TLabel
    Left = 8
    Top = 56
    Width = 83
    Height = 13
    Caption = 'Leben des Dinos:'
    Transparent = True
  end
  object PanzerLbl: TLabel
    Left = 8
    Top = 8
    Width = 96
    Height = 13
    Caption = 'Benzin des Panzers:'
    Transparent = True
  end
  object CheckBoxDino: TCheckBox
    Left = 192
    Top = 176
    Width = 187
    Height = 17
    Caption = 'Dino wird vom Computer gesteuert!'
    TabOrder = 15
    OnClick = PruefungClick
    OnMouseMove = FormMouseMove
  end
  object PanzerEnergy: TEdit
    Left = 8
    Top = 24
    Width = 145
    Height = 21
    Hint = 'Benzin des Panzers...'
    MaxLength = 3
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = '130'
    OnChange = OptionChange
    OnMouseMove = FormMouseMove
  end
  object DinoEnergy: TEdit
    Left = 8
    Top = 72
    Width = 145
    Height = 21
    Hint = 'Lebensenergie des Dinos...'
    MaxLength = 3
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = '10'
    OnChange = OptionChange
    OnMouseMove = FormMouseMove
  end
  object OK: TBitBtn
    Left = 8
    Top = 320
    Width = 129
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 0
    OnClick = OKClick
    OnMouseMove = OKMouseMove
  end
  object Abb: TBitBtn
    Left = 144
    Top = 320
    Width = 129
    Height = 25
    Cancel = True
    Caption = '&Abbrechen'
    TabOrder = 18
    OnClick = AbbClick
    OnMouseMove = AbbMouseMove
  end
  object STD: TBitBtn
    Left = 280
    Top = 320
    Width = 121
    Height = 25
    Caption = '&Standard'
    TabOrder = 19
    OnClick = STDClick
    OnMouseMove = STDMouseMove
  end
  object DGrp: TGroupBox
    Left = 208
    Top = 192
    Width = 193
    Height = 121
    Caption = 'Dino-KI'
    TabOrder = 16
    object IntD: TLabel
      Left = 8
      Top = 16
      Width = 92
      Height = 13
      Caption = 'Schwierigkeitsgrad:'
      Transparent = True
      Visible = False
    end
    object NonD: TLabel
      Left = 16
      Top = 24
      Width = 155
      Height = 13
      Caption = 'Die Dino-KI wurde nicht aktiviert!'
      Transparent = True
    end
    object DBvl: TBevel
      Left = 8
      Top = 64
      Width = 177
      Height = 2
      Shape = bsBottomLine
      Visible = False
    end
    object DSc: TRadioButton
      Left = 128
      Top = 40
      Width = 58
      Height = 17
      Hint = 'Intervall: 3'
      Caption = 'Schwer'
      TabOrder = 2
      Visible = False
      OnClick = DIntervalClick
    end
    object DMi: TRadioButton
      Left = 64
      Top = 40
      Width = 47
      Height = 17
      Hint = 'Intervall: 8'
      Caption = 'Mittel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Visible = False
      OnClick = DIntervalClick
    end
    object Dle: TRadioButton
      Left = 8
      Top = 40
      Width = 51
      Height = 17
      Hint = 'Intervall: 13'
      Caption = 'Leicht'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = True
      Visible = False
      OnClick = DIntervalClick
    end
    object DinoHoheKI: TCheckBox
      Left = 8
      Top = 72
      Width = 102
      Height = 17
      Caption = 'Dino hat hohe KI'
      TabOrder = 3
      Visible = False
      OnClick = OptionChange
    end
    object IVD: TCheckBox
      Left = 8
      Top = 96
      Width = 106
      Height = 17
      Caption = 'Dino-KI in Milisek.'
      TabOrder = 4
      Visible = False
      OnClick = PruefungClick
    end
    object DInterval: TEdit
      Left = 128
      Top = 92
      Width = 57
      Height = 21
      Enabled = False
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 5
      Text = '13'
      Visible = False
      OnChange = OptionChange
    end
  end
  object CheckBoxSound: TCheckBox
    Left = 8
    Top = 104
    Width = 96
    Height = 17
    Caption = 'Soundeffekte'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = OptionChange
  end
  object CheckBoxMusic: TCheckBox
    Left = 8
    Top = 120
    Width = 104
    Height = 17
    Caption = 'Hintergrundmusik'
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = PruefungClick
  end
  object Musik1: TRadioButton
    Left = 24
    Top = 136
    Width = 105
    Height = 17
    Caption = 'Track 1'
    Checked = True
    TabOrder = 17
    TabStop = True
    OnClick = OptionChange
  end
  object Musik2: TRadioButton
    Left = 24
    Top = 152
    Width = 105
    Height = 17
    Caption = 'Track 2'
    TabOrder = 5
    OnClick = OptionChange
  end
  object Musik3: TRadioButton
    Left = 24
    Top = 168
    Width = 105
    Height = 17
    Caption = 'Track 3'
    TabOrder = 6
    OnClick = OptionChange
  end
  object Musik4: TRadioButton
    Left = 24
    Top = 184
    Width = 105
    Height = 17
    Caption = 'Track 4'
    TabOrder = 7
    OnClick = OptionChange
  end
  object Musik5: TRadioButton
    Left = 24
    Top = 200
    Width = 113
    Height = 17
    Caption = 'Track 5'
    TabOrder = 8
    OnClick = OptionChange
  end
  object CheckBoxBenzin: TCheckBox
    Left = 8
    Top = 248
    Width = 128
    Height = 17
    Caption = 'Benzin auch in Zahlen'
    Checked = True
    State = cbChecked
    TabOrder = 9
    OnClick = OptionChange
  end
  object CheckBoxLebensenergie: TCheckBox
    Left = 8
    Top = 264
    Width = 166
    Height = 17
    Caption = 'Lebensenergie auch in Zahlen'
    Checked = True
    State = cbChecked
    TabOrder = 10
    OnClick = OptionChange
  end
  object Spielernamen: TCheckBox
    Left = 8
    Top = 280
    Width = 135
    Height = 17
    Caption = 'Spielernamen speichern'
    Checked = True
    State = cbChecked
    TabOrder = 11
    OnClick = OptionChange
  end
  object Blut: TCheckBox
    Left = 8
    Top = 296
    Width = 133
    Height = 17
    Caption = 'Blut des Dinos sichtbar!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    OnClick = OptionChange
  end
  object CheckBoxPanzer: TCheckBox
    Left = 192
    Top = 16
    Width = 198
    Height = 17
    Caption = 'Panzer wird vom Computer gesteuert!'
    TabOrder = 13
    OnClick = PruefungClick
    OnMouseMove = FormMouseMove
  end
  object PGrp: TGroupBox
    Left = 208
    Top = 32
    Width = 193
    Height = 137
    Caption = 'Panzer-KI'
    TabOrder = 14
    object IntP: TLabel
      Left = 8
      Top = 16
      Width = 92
      Height = 13
      Caption = 'Schwierigkeitsgrad:'
      Transparent = True
      Visible = False
    end
    object NonP: TLabel
      Left = 16
      Top = 24
      Width = 166
      Height = 13
      Caption = 'Die Panzer-KI wurde nicht aktiviert!'
      Transparent = True
    end
    object VerwirrungLbl: TLabel
      Left = 24
      Top = 88
      Width = 53
      Height = 13
      Caption = 'Verwirrung:'
      Visible = False
    end
    object PBvl: TBevel
      Left = 8
      Top = 64
      Width = 177
      Height = 2
      Shape = bsBottomLine
      Visible = False
    end
    object PSc: TRadioButton
      Left = 128
      Top = 40
      Width = 58
      Height = 17
      Hint = 'Intervall: 3'#13'Verwirrung: 5'
      Caption = 'Schwer'
      TabOrder = 2
      Visible = False
      OnClick = PIntervalClick
    end
    object PMi: TRadioButton
      Left = 64
      Top = 40
      Width = 47
      Height = 17
      Hint = 'Intervall: 8'#13'Verwirrung: 4'#13
      Caption = 'Mittel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Visible = False
      OnClick = PIntervalClick
    end
    object PLe: TRadioButton
      Left = 8
      Top = 40
      Width = 51
      Height = 17
      Hint = 'Intervall: 13'#13'Verwirrung: 3'
      Caption = 'Leicht'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = True
      Visible = False
      OnClick = PIntervalClick
    end
    object PanzerHoheKI: TCheckBox
      Left = 8
      Top = 72
      Width = 113
      Height = 17
      Caption = 'Panzer hat hohe KI'
      TabOrder = 3
      Visible = False
      OnClick = PruefungClick
    end
    object IVP: TCheckBox
      Left = 8
      Top = 112
      Width = 117
      Height = 17
      Caption = 'Panzer-KI in Milisek.'
      TabOrder = 4
      Visible = False
      OnClick = PruefungClick
    end
    object PInterval: TEdit
      Left = 128
      Top = 108
      Width = 57
      Height = 21
      Enabled = False
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 5
      Text = '13'
      Visible = False
      OnChange = OptionChange
    end
    object VerwirrungEdt: TEdit
      Left = 128
      Top = 84
      Width = 57
      Height = 21
      MaxLength = 2
      NumbersOnly = True
      TabOrder = 6
      Text = '3'
      Visible = False
      OnChange = OptionChange
    end
  end
end
