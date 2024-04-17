/////////////////////////////////////////////////////////
//  * Der Panzergeneral 2 - Version 1.5 - Quellcode *  //
//  -------------------------------------------------  //
//  Entwicklung: Michael Düpjohann & Daniel Marschall. //
//  -------------------------------------------------  //
//  (C)Copyright 2000 - 2005 ViaThinkSoft.             //
//  Alle Rechte vorbehalten.                           //
/////////////////////////////////////////////////////////

program DPG2;

{$DESCRIPTION 'Der Panzergeneral II 1.5'}

uses
  Windows,
  Messages,
  SysUtils,
  Controls,
  Forms,
  Dialogs,
  System.UITypes,
  DPGUnit1 in 'DPGUnit1.pas' {MenuForm},
  DPGUnit2 in 'DPGUnit2.pas' {SpielForm},
  DPGUnit3 in 'DPGUnit3.pas' {HilfeForm},
  DPGUnit4 in 'DPGUnit4.pas' {EinstellungForm},
  DPGUnit6 in 'DPGUnit6.pas' {SplashForm},
  DPGGlobal in 'DPGGlobal.pas';

{$R *.RES}

var
  Sem: THandle;
  Fehler: boolean;

procedure Counter(progress: integer);
begin
  splashform.ProgressGge.Progress := splashform.ProgressGge.Progress + progress;
end;

begin
  { Programm schon gestartet? }
  Sem := CreateSemaphore(nil, 0, 1, 'Der Panzergeneral 2');
  if (Sem <> 0) and (GetLastError = ERROR_ALREADY_EXISTS) then
  begin
    CloseHandle(Sem);
    MessageDlg('Das Spiel wurde bereits gestartet.', mtInformation, [mbOK], 0);
    exit;
  end;
  { Verzeichnis ermitteln }
  directory := extractfilepath(paramstr(0));
  { Programm vorbereiten! }
  SplashForm := TSplashForm.Create(Application);
  SplashForm.Show;
  SplashForm.Update;
  Application.Initialize;
  Application.Title := 'Der Panzergeneral 2';
  Application.MainFormOnTaskBar := true;
  Application.ShowMainForm := false;
  { Dateien vorhanden? }
  Fehler := false;
  if not fileexists(directory+'Bilder\Abbrechen.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Blatt.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Blätter.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Brief.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Buch.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Fragezeichen.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Hintergrund.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Neustart.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\OK.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Standard.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Sterne.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Tastatur.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Verlassen.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Weltkugel.bmp') then Fehler := true;
  if not fileexists(directory+'DirectX\Grafik.dxg') then Fehler := true;
  if not fileexists(directory+'DirectX\Audio.dxw') then Fehler := true;
  // if not fileexists(directory+'Einstellungen\DPG2.ini') then Fehler := true;
  if not fileexists(directory+'Musik\Freegamer.mid') then Fehler := true;
  if not fileexists(directory+'Musik\Musik1.mid') then Fehler := true;
  if not fileexists(directory+'Musik\Musik2.mid') then Fehler := true;
  if not fileexists(directory+'Musik\Musik3.mid') then Fehler := true;
  if not fileexists(directory+'Musik\Musik4.mid') then Fehler := true;
  if not fileexists(directory+'Musik\Musik5.mid') then Fehler := true;
  if not fileexists(directory+'Texte\Geschichte.txt') then Fehler := true;
  if not fileexists(directory+'Texte\HighScore.txt') then Fehler := true;
  if not fileexists(directory+'Texte\Informationen.txt') then Fehler := true;
  if not fileexists(directory+'Texte\Mitarbeiter.txt') then Fehler := true;
  if not fileexists(directory+'Texte\Steuerung.txt') then Fehler := true;
  if not fileexists(directory+'Texte\Ziel.txt') then Fehler := true;
  if Fehler then
  begin
    MessageDLG('Dateien, die die Programmstabilität gewährleisten, sind ' +
      'nicht mehr vorhanden!'+#13#10+'Bitte installieren Sie DPG II erneut...',
      mtWarning, [mbOK], 0);
    exit;
  end;
  { Keine Soundkarte?! }
  if not soundkarte then
    MessageDlg('Es wurde keine Soundkarte gefunden!' + #13#10 +
    'Entweder ist keine Soundkarte angeschlossen oder sie ist nicht ' +
    'ordnungsgemäß installiert.' + #13#10 + 'Es können daher keine Musik und ' +
    'keine Geräusche abgespielt werden.', mtError, [mbOK], 0);
  { Programm starten! }
  counter(1);
  Application.CreateForm(TMenuForm, MenuForm);
  counter(1);
  Application.CreateForm(TSpielForm, SpielForm);
  counter(1);
  Application.CreateForm(THilfeForm, HilfeForm);
  counter(1);
  Application.CreateForm(TEinstellungForm, EinstellungForm);
  counter(1);
  EinstellungForm.LoadINI;
  counter(1);
  SplashForm.Hide;
  FreeAndNil(SplashForm);
  MenuForm.Visible := true;
  Application.Run;
end.

