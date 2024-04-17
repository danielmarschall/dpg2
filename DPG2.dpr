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
  DPGUnit5 in 'DPGUnit5.pas' {VideoForm},
  DPGUnit6 in 'DPGUnit6.pas' {SplashForm},
  DPGGlobal in 'DPGGlobal.pas';

{$R *.RES}

var
  Sem: THandle;
  Fehler: boolean;
  tempengineversion, tempcopyright: string;
  i, punkt: integer;

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
  Application.ShowMainForm := false;
  { Globale Variablen erstellen! }
  splashform.versioninfo.filename := paramstr(0);
  tempengineversion := splashform.versioninfo.ProductVersion;
  punkt := 0;
  for i := 1 to length(tempengineversion) do
  begin
    if copy(tempengineversion, i, 1) = '.' then inc(punkt);
    if punkt < 2 then
      engineversion := engineversion+copy(tempengineversion, i, 1);
  end;
  TempCopyright := splashform.versioninfo.LegalCopyright;
  for i := 1 to length(TempCopyright) do
  begin
    if copy(TempCopyright, i, 9) = 'Copyright' then
    begin
      Copyright := copy(TempCopyright, 0, i-1) + copy(TempCopyright, i+9,
        length(TempCopyright)-(i+8)) + '.';
    end;
  end;
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
  if not fileexists(directory+'Bilder\Video.bmp') then Fehler := true;
  if not fileexists(directory+'Bilder\Weltkugel.bmp') then Fehler := true;
  if not fileexists(directory+'DirectX\Grafik.dxg') then Fehler := true;
  if not fileexists(directory+'DirectX\Audio.dxw') then Fehler := true;
  // if not fileexists(directory+'Einstellungen\DPG2.ini') then Fehler := true;
  if not fileexists(directory+'Icons\Hilfe.ico') then Fehler := true;
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
  if not fileexists(directory+'Videos\Video.avi') then Fehler := true;
  if not fileexists(directory+'Videos\Audio.wav') then Fehler := true;
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
  Application.CreateForm(TVideoForm, VideoForm);
  counter(1);
  EinstellungForm.LoadINI;
  counter(1);
  SplashForm.Hide;
  SplashForm.Free;
  MenuForm.Visible := not EinstellungForm.checkboxvideo.checked;
  VideoForm.Visible := EinstellungForm.checkboxvideo.checked;
  Application.Run;
end.

