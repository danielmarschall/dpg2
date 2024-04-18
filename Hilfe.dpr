/////////////////////////////////////////////////////////
//  * Der Panzergeneral 2 - Version 1.5 - Quellcode *  //
//  -------------------------------------------------  //
//  Entwicklung: Michael Düpjohann & Daniel Marschall. //
//  -------------------------------------------------  //
//  (C)Copyright 2000 - 2005 ViaThinkSoft.             //
//  Alle Rechte vorbehalten.                           //
/////////////////////////////////////////////////////////

program Hilfe;

uses
  ShellAPI,
  Sysutils,
  Forms;

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Der Panzergeneral II 1.5 - Hilfe';
  if fileexists(extractfilepath(paramstr(0)) + 'DPG2 Hilfe\index.htm') then
    ShellExecute(Application.Handle, 'open',
      PChar(extractfilepath(paramstr(0)) + 'DPG2 Hilfe\index.htm'),'','',1);
end.

