/////////////////////////////////////////////////////////
//  * Der Panzergeneral 2 - Version 1.5 - Quellcode *  //
//  -------------------------------------------------  //
//  Entwicklung: Michael Düpjohann & Daniel Marschall. //
//  -------------------------------------------------  //
//  (C)Copyright 2000 - 2005 ViaThinkSoft.             //
//  Alle Rechte vorbehalten.                           //
/////////////////////////////////////////////////////////

unit DPGGlobal;

interface

uses
  MMSystem, SysUtils;

const
  ProgrammVersion = '1.5d';
  CopyRight = '(C) 2000-2005 MD-Technologie'+#13#10+'Techn. Auffrischung 2024';
  DpgRegistrySettings = 'SOFTWARE\ViaThinkSoft\DPG2\Settings';

var
  Directory: string;

const
  { FPS tiefer = schnellere Bewegungen... }
  FPS = 295; { in Version 1.4: 215 }
  Wald1L = 33;
  Wald1T = 193;
  Wald1H = 81;
  Wald1W = 97;
  Wald2L = 129;
  Wald2T = 33;
  Wald2H = 201;
  Wald2W = 81;
  Wald3L = 209;
  Wald3T = 9;
  Wald3H = 57;
  Wald3W = 97;
  Wald4L = 305;
  Wald4T = 25;
  Wald4H = 65;
  Wald4W = 105;
  Wald5L = 337;
  Wald5T = 89;
  Wald5H = 81;
  Wald5W = 57;
  Wald6L = 305;
  Wald6T = 169;
  Wald6H = 121;
  Wald6W = 155;
  Wald7L = 209;
  Wald7T = 153;
  Wald7H = 57;
  Wald7W = 97;
  Wald8L = 161;
  Wald8T = 233;
  Wald8H = 57;
  Wald8W = 97;

function SoundKarte: boolean;
function IntegerValueOK(str: string; min: integer; max: integer): boolean;

implementation

function SoundKarte: boolean;
begin
  result := WaveOutGetNumDevs > 0;
end;

function IntegerValueOK(str: string; min: integer; max: integer): boolean;
var
  i, j: integer;
begin
  Val(str, i, j);
  if j = 0 then
  begin
    if (i < min) and (i > max) then result := false
      else result := true;
  end
  else
    result := false;
end;

end.

