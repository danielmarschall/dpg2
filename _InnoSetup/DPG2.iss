; DPG 2 Setup Script for InnoSetup 5.1.9
; by Daniel Marschall

; Shut-Down Game?!

[Setup]
AppName=Der Panzergeneral II
AppVerName=Der Panzergeneral II 1.5
AppVersion=1.5
AppCopyright=© Copyright 2000 - 2007 ViaThinkSoft.
AppPublisher=ViaThinkSoft
AppPublisherURL=https://www.viathinksoft.de/
AppSupportURL=https://www.md-technologie.de/
AppUpdatesURL=https://www.viathinksoft.de/
DefaultDirName={pf}\Der Panzergeneral 2
DefaultGroupName=Der Panzergeneral 2
VersionInfoCompany=ViaThinkSoft
VersionInfoCopyright=© Copyright 2000 - 2007 ViaThinkSoft.
VersionInfoDescription=Der Panzergeneral II 1.5 Setup
VersionInfoTextVersion=1.0.0.0
VersionInfoVersion=1.5
Compression=zip/9
; Configure Sign Tool in InnoSetup at "Tools => Configure Sign Tools" (adjust the path to your SVN repository location)
; Name    = sign_single   
; Command = "C:\SVN\...\sign_single.bat" $f
SignTool=sign_single
SignedUninstaller=yes

[Languages]
Name: de; MessagesFile: "compiler:Languages\German.isl"

[LangOptions]
LanguageName=Deutsch
LanguageID=$0407

[Tasks]
Name: "desktopicon"; Description: "Erstelle eine Verknüpfung auf dem &Desktop"; GroupDescription: "Programmverknüpfungen:"; MinVersion: 4,4

[Files]
Source: "..\DPG2.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\Hilfe.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\Bilder\Abbrechen.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Blatt.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Blätter.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Brief.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Buch.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Fragezeichen.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Hintergrund.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Neustart.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\OK.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Standard.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Sterne.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Tastatur.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Verlassen.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Weltkugel.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\Bilder\Link.bmp"; DestDir: "{app}\Bilder"; Flags: ignoreversion
Source: "..\DirectX\Audio.dxw"; DestDir: "{app}\DirectX"; Flags: ignoreversion
Source: "..\DirectX\Grafik.dxg"; DestDir: "{app}\DirectX"; Flags: ignoreversion
Source: "..\Einstellungen\DPG2.ini"; DestDir: "{app}\Einstellungen"; Flags: ignoreversion
Source: "..\Musik\Freegamer.mid"; DestDir: "{app}\Musik"; Flags: ignoreversion
Source: "..\Musik\Musik1.mid"; DestDir: "{app}\Musik"; Flags: ignoreversion
Source: "..\Musik\Musik2.mid"; DestDir: "{app}\Musik"; Flags: ignoreversion
Source: "..\Musik\Musik3.mid"; DestDir: "{app}\Musik"; Flags: ignoreversion
Source: "..\Musik\Musik4.mid"; DestDir: "{app}\Musik"; Flags: ignoreversion
Source: "..\Musik\Musik5.mid"; DestDir: "{app}\Musik"; Flags: ignoreversion
Source: "..\Texte\Geschichte.txt"; DestDir: "{app}\Texte"; Flags: ignoreversion
Source: "..\Texte\HighScore.txt"; DestDir: "{app}\Texte"; Flags: ignoreversion
Source: "..\Texte\Informationen.txt"; DestDir: "{app}\Texte"; Flags: ignoreversion
Source: "..\Texte\Mitarbeiter.txt"; DestDir: "{app}\Texte"; Flags: ignoreversion
Source: "..\Texte\Steuerung.txt"; DestDir: "{app}\Texte"; Flags: ignoreversion
Source: "..\Texte\Ziel.txt"; DestDir: "{app}\Texte"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F3.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F4f2.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\Informationen.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\MD.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\MD.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\Mitarbeiter.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\Steuerung.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\TuT.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\Ziel.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\Lizenzvertrag.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\IPf2.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\IPf1.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\IPf.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\IP.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\IP.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\index.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\Geschichte.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\Fg.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\FG.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F4f4.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F4f5.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F1b.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F2f2.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F5.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F5.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F4f6.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F4f3.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F4f1.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F4f.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F4.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F4.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F3.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F2f.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F2f1.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F2.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F2.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F1a.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\DM.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\DM.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F1a.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\F1b.jpg"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\DPG2.htm"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion
Source: "..\DPG2 Hilfe\DPG2.css"; DestDir: "{app}\DPG2 Hilfe"; Flags: ignoreversion

[Folders]
Name: "{group}\Webseiten"

[Icons]
;Name: "{group}\Webseiten\Daniel Marschalls Webportal"; Filename: "https://www.daniel-marschall.de/"
;Name: "{group}\Webseiten\MD-Technologie"; Filename: "https://www.md-technologie.de/"
;Name: "{group}\Webseiten\ViaThinkSoft"; Filename: "https://www.viathinksoft.de/"
;Name: "{group}\Webseiten\Projektseite auf ViaThinkSoft"; Filename: "https://www.viathinksoft.de/index.php?page=projektanzeige&seite=projekt-21"
Name: "{group}\DPG 2 Hilfe"; Filename: "{app}\Hilfe.exe"
Name: "{group}\Der Panzergeneral 2"; Filename: "{app}\DPG2.exe"
Name: "{userdesktop}\Der Panzergeneral 2"; Filename: "{app}\DPG2.exe"; MinVersion: 4,4; Tasks: desktopicon
;Name: "{group}\Der Panzergeneral 2 deinstallieren"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\DPG2.exe"; Description: "Der Panzergeneral 2 starten"; Flags: nowait postinstall skipifsilent

[Code]
function InitializeSetup(): Boolean;
begin
  if CheckForMutexes('DPG15Setup')=false then
  begin
    Createmutex('DPG15Setup');
    Result := true;
  end
  else
  begin
    Result := False;
  end;
end;
