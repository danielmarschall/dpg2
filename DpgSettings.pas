/////////////////////////////////////////////////////////
//  * Der Panzergeneral 2 - Version 1.5 - Quellcode *  //
//  -------------------------------------------------  //
//  Entwicklung: Michael Düpjohann & Daniel Marschall. //
//  -------------------------------------------------  //
//  (C)Copyright 2000 - 2005 ViaThinkSoft.             //
//  Alle Rechte vorbehalten.                           //
/////////////////////////////////////////////////////////

unit DpgSettings;

interface                                                         

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, System.UITypes;

type
  TEinstellungForm = class(TForm)
    CheckBoxDino: TCheckBox;
    PanzerEnergy: TEdit;
    DinoEnergy: TEdit;
    OK: TBitBtn;
    Abb: TBitBtn;
    STD: TBitBtn;
    DGrp: TGroupBox;
    DSc: TRadioButton;
    CheckBoxSound: TCheckBox;
    CheckBoxMusic: TCheckBox;
    Musik1: TRadioButton;
    Musik2: TRadioButton;
    Musik3: TRadioButton;
    Musik4: TRadioButton;
    Musik5: TRadioButton;
    CheckBoxBenzin: TCheckBox;
    CheckBoxLebensenergie: TCheckBox;
    Spielernamen: TCheckBox;
    Blut: TCheckBox;
    CheckBoxPanzer: TCheckBox;
    DMi: TRadioButton;
    Dle: TRadioButton;
    DinoHoheKI: TCheckBox;
    IVD: TCheckBox;
    DInterval: TEdit;
    PGrp: TGroupBox;
    PSc: TRadioButton;
    PMi: TRadioButton;
    PLe: TRadioButton;
    PanzerHoheKI: TCheckBox;
    IVP: TCheckBox;
    PInterval: TEdit;
    DinoLbl: TLabel;
    PanzerLbl: TLabel;
    IntD: TLabel;
    NonD: TLabel;
    IntP: TLabel;
    NonP: TLabel;
    VerwirrungLbl: TLabel;
    VerwirrungEdt: TEdit;
    PBvl: TBevel;
    DBvl: TBevel;
    procedure STDClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure PruefungClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure OKMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure STDMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AbbMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure AbbClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PIntervalClick(Sender: TObject);
    procedure DIntervalClick(Sender: TObject);
    procedure OptionChange(Sender: TObject);
  private
    procedure Pruefung;
  public
    procedure LoadINI;
    procedure SaveINI;
    function PruefeINI: boolean;
  end;

var
  EinstellungForm: TEinstellungForm;

implementation

uses
  DPGGlobal, DpgMenu, DpgGame, DpgHilfe, DpgSplash, Registry, IniFiles;

{$R *.DFM}

function TEinstellungForm.PruefeINI: boolean;
var
  Fehler: boolean;
begin
  Fehler := false;
  if IVP.checked then
  begin
    if not IntegerValueOK(PInterval.text, 1, 9999) then
    begin
      MessageDLG('Der Interval der Panzer-KI muss eine Zahl von 1 bis 9999 sein!', mtInformation, [mbOK], 0);
      PInterval.text := '10';
      Fehler := true;
    end;
  end;
  if IVD.checked then
  begin
    if not IntegerValueOK(DInterval.text, 1, 9999) then
    begin
      MessageDLG('Der Interval der Dino-KI muss eine Zahl von 1 bis 9999 sein!', mtInformation, [mbOK], 0);
      DInterval.text := '10';
      Fehler := true;
    end;
  end;
  if not IntegerValueOK(DinoEnergy.text, 1, 999) then
  begin
    MessageDLG('Lebensenergie muss eine Zahl von 1 bis 999 sein!', mtInformation, [mbOK], 0);
    DinoEnergy.text := '10';
    Fehler := true;
  end;
  if not IntegerValueOK(PanzerEnergy.text, 1, 999) then
  begin
    MessageDLG('Benzin muss eine Zahl von 1 bis 999 sein!', mtInformation, [mbOK], 0);
    PanzerEnergy.text := '130';
    Fehler := true;
  end;
  if not IntegerValueOK(VerwirrungEdt.text, 0, 99) then
  begin
    MessageDLG('Verwirrung muss eine Zahl von 0 bis 99 sein!', mtInformation, [mbOK], 0);
    VerwirrungEdt.text := '3';
    Fehler:=true;
  end;
  result := not Fehler;
end;

procedure TEinstellungForm.pruefung;
begin
  PInterval.enabled := IVP.checked;
  PLe.enabled := not IVP.checked;
  PMi.enabled := not IVP.checked;
  PSc.enabled := not IVP.checked;
  IntP.Enabled := not IVP.checked;
  DInterval.enabled:= IVD.checked;
  DLe.enabled:= not IVD.checked;
  DMi.enabled:= not IVD.checked;
  DSc.enabled:= not IVD.checked;
  IntD.Enabled:= not IVD.checked;
  nonp.Visible := not checkboxpanzer.checked;
  intp.Visible := checkboxpanzer.checked;
  PInterval.Visible := checkboxpanzer.checked;
  IVP.Visible := checkboxpanzer.checked;
  PLe.Visible := checkboxpanzer.checked;
  PMi.Visible := checkboxpanzer.checked;
  PSc.Visible := checkboxpanzer.checked;
  PanzerHoheKI.Visible := checkboxpanzer.checked;
  PBvl.Visible := checkboxpanzer.checked;
  nond.Visible := not checkboxdino.checked;
  intd.Visible := checkboxdino.checked;
  DInterval.Visible := checkboxdino.checked;
  IVD.Visible := checkboxdino.checked;
  DLe.Visible := checkboxdino.checked;
  DMi.Visible := checkboxdino.checked;
  DSc.Visible := checkboxdino.checked;
  DinoHoheKI.Visible := checkboxdino.checked;
  DBvl.Visible := checkboxdino.checked;
  VerwirrungLbl.visible := checkboxpanzer.checked;
  VerwirrungEdt.visible := checkboxpanzer.checked;
  VerwirrungLbl.enabled := not panzerhoheki.checked;
  VerwirrungEdt.enabled := not panzerhoheki.checked;
  if not Soundkarte then
  begin
    CheckBoxSound.enabled := false;
    CheckBoxMusic.enabled := false;
    Musik1.enabled := false;
    Musik2.enabled := false;
    Musik3.enabled := false;
    Musik4.enabled := false;
    Musik5.enabled := false;
  end
  else
  begin
    Musik1.enabled := checkboxmusic.checked;
    Musik2.enabled := checkboxmusic.checked;
    Musik3.enabled := checkboxmusic.checked;
    Musik4.enabled := checkboxmusic.checked;
    Musik5.enabled := checkboxmusic.checked;
  end;
end;

procedure TEinstellungForm.STDClick(Sender: TObject);
begin
  std.Font.Color:=clwindowtext;
  PanzerHoheKI.checked:=false;
  dinoHoheKI.checked:=false;
  verwirrungedt.text:='3';
  Blut.checked:=false;
  Musik1.checked:=true;
  DinoEnergy.text:='10';
  PanzerEnergy.text:='130';
  checkboxDino.checked:=false;
  checkboxPanzer.checked:=false;
  DLe.Checked:=true;
  PLe.Checked:=true;
  IVP.checked:=false;
  IVD.checked:=false;
  PInterval.text:='13';
  DInterval.text:='13';
  PInterval.enabled:=false;
  DInterval.enabled:=false;
  checkboxSound.checked:=true;
  checkboxMusic.checked:=true;
  checkboxLebensenergie.checked:=true;
  checkboxBenzin.checked:=true;
  Spielernamen.checked:=true;
  MenuForm.Edit1.Text:='Name Spieler 1 (Panzer)';
  MenuForm.Edit2.Text:='Name Spieler 2 (Dino)';
  pruefung;
  optionchange(sender);
end;

procedure TEinstellungForm.OKClick(Sender: TObject);
begin
  ok.Font.Color:=clwindowtext;
  if PruefeINI then
  begin
    visible:=false;
    MenuForm.Visible:=true;
    MenuForm.setfocus;
    SaveINI;
  end;
end;

procedure TEinstellungForm.SaveINI;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(DpgRegistrySettings, true) then
    begin
      if Spielernamen.checked then
      begin
        reg.WriteString('NameSpieler1', MenuForm.Edit1.Text);
        reg.WriteString('NameSpieler2', MenuForm.Edit2.Text);
      end
      else
      begin
        reg.WriteString('NameSpieler1', 'Name Spieler 1 (Panzer)');
        reg.WriteString('NameSpieler2', 'Name Spieler 2 (Dino)');
        MenuForm.edit1.text:='Name Spieler 1 (Panzer)';
        MenuForm.edit2.text:='Name Spieler 2 (Dino)';
      end;
      reg.WriteInteger('BenzinPanzer', StrToInt(PanzerEnergy.text));
      reg.WriteInteger('LebenDino', StrToInt(DinoEnergy.text));
      reg.WriteBool('Soundeffekte', CheckBoxSound.checked);
      reg.WriteBool('Musik', CheckBoxMusic.checked);
      if Musik1.checked then
        reg.WriteInteger('SoundTrack', 1);
      if Musik2.checked then
        reg.WriteInteger('SoundTrack', 2);
      if Musik3.checked then
        reg.WriteInteger('SoundTrack', 3);
      if Musik4.checked then
        reg.WriteInteger('SoundTrack', 4);
      if Musik5.checked then
        reg.WriteInteger('SoundTrack', 5);
      reg.WriteBool('BenzinAnzeige', CheckBoxBenzin.checked);
      reg.WriteBool('LebenAnzeige', CheckBoxLebensenergie.checked);
      reg.WriteBool('SpielerNamenSpeichern', Spielernamen.checked);
      reg.WriteBool('Blut', Blut.checked);
      reg.WriteBool('PanzerKI', CheckBoxPanzer.checked);
      if PLe.Checked then
        reg.WriteInteger('PanzerSchwierigkeit', 1);
      if PMi.Checked then
        reg.WriteInteger('PanzerSchwierigkeit', 2);
      if PSc.Checked then
        reg.WriteInteger('PanzerSchwierigkeit', 3);
      reg.WriteBool('PanzerSpezial', PanzerHoheKI.checked);
      reg.WriteBool('PanzerInterval', IVP.checked);
      reg.WriteInteger('PanzerGeschwindigkeit', strtoint(PInterval.text));
      reg.WriteInteger('PanzerVerwirrung', strtoint(VerwirrungEdt.text));
      reg.WriteBool('DinoKI', CheckBoxDino.checked);
      if DLe.Checked then
        reg.WriteInteger('DinoSchwierigkeit', 1);
      if DMi.Checked then
        reg.WriteInteger('DinoSchwierigkeit', 2);
      if DSc.Checked then
        reg.WriteInteger('DinoSchwierigkeit', 3);
      reg.WriteBool('DinoSpezial', DinoHoheKI.checked);
      reg.WriteBool('DinoInterval', IVD.checked);
      reg.WriteInteger('DinoGeschwindigkeit',
        strtoint(DInterval.text));
      reg.CloseKey;
    end;
  finally
    FreeAndNil(reg);
  end;
end;

procedure TEinstellungForm.PruefungClick(Sender: TObject);
begin
  pruefung;
  optionchange(sender);
end;

procedure TEinstellungForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  OK.Font.color := clwindowtext;
  STD.Font.color := clwindowtext;
  ABB.Font.color := clwindowtext;
end;

procedure TEinstellungForm.OKMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  STD.Font.color := clwindowtext;
  ABB.Font.color := clwindowtext;
  OK.Font.color := clnavy;
end;

procedure TEinstellungForm.STDMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  OK.Font.color := clwindowtext;
  ABB.Font.color := clwindowtext;
  STD.Font.color := clnavy;
end;

procedure TEinstellungForm.FormShow(Sender: TObject);
var
  ini: TMemIniFile;
begin
  pruefung;

  ini := TMemIniFile.Create(Directory+'Musik\Tracks.ini');
  try
    Musik1.Caption := ini.ReadString('Tracks', 'Track1', Musik1.Caption);
    Musik2.Caption := ini.ReadString('Tracks', 'Track2', Musik2.Caption);
    Musik3.Caption := ini.ReadString('Tracks', 'Track3', Musik3.Caption);
    Musik4.Caption := ini.ReadString('Tracks', 'Track4', Musik4.Caption);
    Musik5.Caption := ini.ReadString('Tracks', 'Track5', Musik5.Caption);
  finally
    FreeAndNil(ini);
  end;

  ok.setfocus;
end;

procedure TEinstellungForm.FormCreate(Sender: TObject);
begin
  OK.Glyph.LoadFromFile(directory+'Bilder\OK.bmp');
  ABB.Glyph.LoadFromFile(directory+'Bilder\Abbrechen.bmp');
  STD.Glyph.LoadFromFile(directory+'Bilder\Standard.bmp');
end;

procedure TEinstellungForm.AbbMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  STD.Font.color := clwindowtext;
  OK.Font.color := clwindowtext;
  ABB.Font.color := clnavy;
end;

procedure TEinstellungForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Button: Integer;
begin
  { Soll das Fenster nicht geschlossen werden?! }
  if Aenderung then
  begin
    canclose := false;
    Button := MessageDlg('Einstellungen speichern?', mtConfirmation,
      [mbYes, mbNo, mbCancel], 0);
    if Button = mrYes then ok.click
      else if Button = mrNo then abb.click;
    Aenderung := false;
  end
  else
  begin
    // canclose := true;
    abb.click;
  end;
end;

type
  TRegistryHelper = class helper for TRegistry
  public
    function ReadIntegerWithDefault(key: string; defval: integer): integer;
    function ReadBoolWithDefault(key: string; defval: boolean): boolean;
    function ReadStringWithDefault(key: string; defval: string): string;
  end;

function TRegistryHelper.ReadIntegerWithDefault(key: string; defval: integer): integer;
begin
  if ValueExists(key) then
    result := ReadInteger(key)
  else
    result := defval;
end;

function TRegistryHelper.ReadBoolWithDefault(key: string; defval: boolean): boolean;
begin
  if ValueExists(key) then
    result := ReadBool(key)
  else
    result := defval;
end;

function TRegistryHelper.ReadStringWithDefault(key: string; defval: string): string;
begin
  if ValueExists(key) then
    result := ReadString(key)
  else
    result := defval;
end;

procedure TEinstellungForm.LoadINI;
var
  TempInt: integer;
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKeyReadOnly(DpgRegistrySettings) then
    begin
      TempInt := reg.ReadIntegerWithDefault('BenzinPanzer', 130);
      if (TempInt > -1) and (TempInt < 10000) then
        PanzerEnergy.Text := inttostr(TempInt);
      TempInt := reg.ReadIntegerWithDefault('LebenDino', 10);
      if (TempInt > -1) and (TempInt < 10000) then
        DinoEnergy.Text := inttostr(TempInt);
      CheckBoxSound.checked := reg.ReadBoolWithDefault('Soundeffekte', true);
      CheckBoxMusic.checked := reg.ReadBoolWithDefault('Musik', true);
      TempInt := reg.ReadIntegerWithDefault('SoundTrack', 1);
      Musik1.checked := TempInt = 1;
      Musik2.checked := TempInt = 2;
      Musik3.checked := TempInt = 3;
      Musik4.checked := TempInt = 4;
      Musik5.checked := TempInt = 5;
      CheckBoxBenzin.checked :=
        reg.ReadBoolWithDefault('BenzinAnzeige', true);
      CheckBoxLebensenergie.checked :=
        reg.ReadBoolWithDefault('LebenAnzeige', true);
      Blut.checked := reg.ReadBoolWithDefault('Blut', false);
      Spielernamen.checked := reg.ReadBoolWithDefault('SpielerNamenSpeichern', true);
      CheckBoxPanzer.checked := reg.ReadBoolWithDefault('PanzerKI', false);
      TempInt := reg.ReadIntegerWithDefault('PanzerSchwierigkeit', 1);
      PLe.checked := TempInt = 1;
      PMi.checked := TempInt = 2;
      PSc.checked := TempInt = 3;
      PanzerHoheKI.checked :=
        reg.ReadBoolWithDefault('PanzerSpezial', false);
      IVP.checked := reg.ReadBoolWithDefault('PanzerInterval', false);
      TempInt := reg.ReadIntegerWithDefault('PanzerGeschwindigkeit', 13);
      if (TempInt > -1) and (TempInt < 1000) then
        PInterval.Text := inttostr(TempInt);
      TempInt := reg.ReadIntegerWithDefault('PanzerVerwirrung', 3);
      if (TempInt > -1) and (TempInt < 100) then
        VerwirrungEdt.Text := inttostr(TempInt);
      CheckBoxDino.checked := reg.ReadBoolWithDefault('DinoKI', false);
      TempInt := reg.ReadIntegerWithDefault('DinoSchwierigkeit', 1);
      DLe.checked := TempInt = 1;
      DMi.checked := TempInt = 2;
      DSc.checked := TempInt = 3;
      DinoHoheKI.checked := reg.ReadBoolWithDefault('DinoSpezial', false);
      IVD.checked := reg.ReadBoolWithDefault('DinoInterval', false);
      TempInt := reg.ReadIntegerWithDefault('DinoGeschwindigkeit', 13);
      if (TempInt > -1) and (TempInt < 1000) then
        DInterval.Text := inttostr(TempInt);
      MenuForm.Edit1.text :=
        reg.ReadStringWithDefault('NameSpieler1', 'Name Spieler 1 (Panzer)');
      MenuForm.Edit2.text :=
        reg.ReadStringWithDefault('NameSpieler2', 'Name Spieler 2 (Dino)');
      if not Spielernamen.Checked then
      begin
        MenuForm.Edit1.Text := 'Name Spieler 1 (Panzer)';
        MenuForm.Edit2.Text := 'Name Spieler 2 (Dino)';
      end;
      SaveINI;

      reg.CloseKey;
    end;
  finally
    FreeAndNil(reg);
  end;
end;

procedure TEinstellungForm.AbbClick(Sender: TObject);
begin
  Abb.font.color := clwindowtext;
  hide;
  MenuForm.show;
  LoadINI;
end;

procedure TEinstellungForm.PIntervalClick(Sender: TObject);
begin
  if sender = PLe then
  begin
    verwirrungedt.text := '5';
    pinterval.text := '13';
  end;
  if sender = PMi then
  begin
    verwirrungedt.text := '4';
    pinterval.text := '8';
  end;
  if sender = PSc then
  begin
    verwirrungedt.text := '3';
    pinterval.text := '3';
  end;
  optionchange(sender);
end;

procedure TEinstellungForm.DIntervalClick(Sender: TObject);
begin
  if sender = DLe then DInterval.text := '12';
  if sender = DMi then DInterval.text := '8';
  if sender = DSc then DInterval.text := '3';
  optionchange(sender);
end;

procedure TEinstellungForm.OptionChange(Sender: TObject);
begin
  Aenderung := true;
end;

end.

