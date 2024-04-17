/////////////////////////////////////////////////////////
//  * Der Panzergeneral 2 - Version 1.5 - Quellcode *  //
//  -------------------------------------------------  //
//  Entwicklung: Michael Düpjohann & Daniel Marschall. //
//  -------------------------------------------------  //
//  (C)Copyright 2000 - 2005 ViaThinkSoft.             //
//  Alle Rechte vorbehalten.                           //
/////////////////////////////////////////////////////////

unit DPGUnit2;
                                                                         
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Buttons, Gauges, ExtCtrls, ShellAPI, StdCtrls, ImgList,
  DXSounds, DXInput, DXSprite, DXClass, DXDraws, mmsystem, wininet;

type
  TSpielForm = class(TDXForm)
    Menu: TMainMenu;
    Spiel: TMenuItem;
    Neustart: TMenuItem;
    Hauptmenue: TMenuItem;
    Beenden: TMenuItem;
    Internet: TMenuItem;
    Link1: TMenuItem;
    Link3: TMenuItem;
    NeuesteVersion: TMenuItem;
    VerbesserungsEMail: TMenuItem;
    HighScore: TMenuItem;
    Anzeigen: TMenuItem;
    Leeren: TMenuItem;
    Hilfe: TMenuItem;
    Geschichte: TMenuItem;
    Ziel: TMenuItem;
    Steuerung: TMenuItem;
    Leer4: TMenuItem;
    Info: TMenuItem;
    Leer5: TMenuItem;
    Mitarbeiter: TMenuItem;
    Leer1: TMenuItem;
    Pause: TMenuItem;
    Leer2: TMenuItem;
    Leer3: TMenuItem;
    ImageList: TImageList;
    Updates: TMenuItem;
    N1: TMenuItem;
    Link2: TMenuItem;
    procedure dxdrawFinalize(Sender: TObject);
    procedure dxdrawInitialize(Sender: TObject);
    procedure DXTimerTimer(Sender: TObject; LagCount: Integer);
    procedure DXTimerActivate(Sender: TObject);
    procedure DXTimerDeactivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HauptmenueClick(Sender: TObject);
    procedure BeendenClick(Sender: TObject);
    procedure NeustartClick(Sender: TObject);
    procedure HilfeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure InternetClick(Sender: TObject);
    procedure LeerenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure DXDrawMouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure DXDrawMouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure pauseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure UpdatesClick(Sender: TObject);
  protected
    daten: textfile;
    Zu: Integer;
    PS, Freegamer: boolean;
    cheat: array[1..8] of boolean;
  public
    { VCL-Ersatz }
    dxdraw: TDxDraw;
    dximagelist: TDxImageList;
    dxspriteengine: tdxspriteengine;
    dxsound: tdxsound;
    dxwavelist: tdxwavelist;
    dxinput: tdxinput;
    dxtimer: tdxtimer;
    { VCL-Ersatz Ende }
    ende, VPanzStp, gestartet: boolean;
    DinoGaugeFore, PanzerGaugeFore: TColor;
    Kommentar, Spieler1Name, Spieler2Name: string;
    DinoLeben, PanzerBenzin, Spielzeit: integer;
    procedure Anzeige;
  end;

  TBackground = class(TBackgroundSprite)
  public
    constructor Create(AParent: TSprite); override;
  end;

  TWald = class(TImageSprite)
  public
    constructor Create(AParent: TSprite); override;
  end;

  TDino = class(TImageSprite)
  private
    FCounter: Integer;
    procedure DinoMove(MoveCount: integer; course: string);
    procedure Hit;
  protected
    procedure DoMove(MoveCount: Integer); override;
  public
    constructor Create(AParent: TSprite); override;
  end;

  TPanzer = class(TImageSprite)
  private
    FPanzerStop: boolean;
    procedure PanzerMove(MoveCount: integer; course: string);
  protected
    procedure DoCollision(Sprite: TSprite; var Done: Boolean); override;
    procedure DoMove(MoveCount: Integer); override;
  public
    constructor Create(AParent: TSprite); override;
  end;

var
  SpielForm: TSpielForm;

implementation

uses
  DPGGlobal, DPGUnit1, DPGUnit3, DPGUnit4, DPGUnit6, DPGUnit5;

{$R *.DFM}

{$R WindowsXP.RES}

var
  DinoX, DinoY, PanzerX, PanzerY: double;
  dinokitimer, panzerkitimer, panzerinterval, dinointerval, durchlauf: integer;
  Dinocolli, splpause: boolean;
  AktuelleMIDI: string;

constructor TWald.Create(AParent: TSprite);
begin
  inherited Create(AParent);
  Z := 4;
end;

constructor TBackground.Create(AParent: TSprite);
begin
  inherited Create(AParent);
  Image := SpielForm.DXImageList.Items.Find('Hintergrund');
  Z := 0;
end;

constructor TPanzer.Create(AParent: TSprite);
begin
  inherited Create(AParent);
  Image := SpielForm.DXImageList.Items.Find('PanzerR');
  Width := Image.Width;
  Height := Image.Height;
  Z := 1;
end;

constructor TDino.Create(AParent: TSprite);
begin
  inherited Create(AParent);
  Image := SpielForm.DXImageList.Items.Find('DinoL');
  Width := Image.Width;
  Height := Image.Height;
  Z := 1;
end;

procedure TDino.DinoMove(MoveCount: integer; course: string);
begin
  if course = 'O' then Y := Y - (300/1000)*MoveCount;
  if course = 'U' then Y := Y + (300/1000)*MoveCount;
  if course = 'L' then X := X - (300/1000)*MoveCount;
  if course = 'R' then X := X + (300/1000)*MoveCount;
  Image := SpielForm.dxImageList.Items.Find('Dino'+course);
end;

procedure TDino.DoMove(MoveCount: Integer);
begin
  inherited DoMove(MoveCount);
  PixelCheck := True;
  if not Collisioned then
  begin
    Inc(FCounter, MoveCount);
    if FCounter > 1200 then
    begin
      Dead;
      if SpielForm.DinoLeben > 0 then
      begin
        with TDino.Create(SpielForm.DXSpriteEngine.Engine) do
        begin
          X := random(SpielForm.dxdraw.width-width);
          Y := random(SpielForm.dxdraw.height-height);
        end;
      end;
    end;
  end
  else
  begin
    if EinstellungForm.checkboxdino.checked then
    begin
      inc(dinokitimer, movecount);
      if dinokitimer >= dinointerval then
      begin
        dinokitimer := 0;
        if EinstellungForm.dinoHoheKI.checked then
        begin
          if panzery=dinoy then
          begin
            if dinoy>SpielForm.dxdraw.height div 2 then
              DinoMove(MoveCount, 'O');
            if panzery<SpielForm.dxdraw.height div 2 then
              DinoMove(MoveCount, 'U');
            if panzery=SpielForm.dxdraw.height div 2 then
            begin
              if random(2)=1 then DinoMove(MoveCount, 'O') else
                DinoMove(MoveCount, 'U');
            end;
          end;
          if (dinox<>panzerx) and (dinoy<panzery) then DinoMove(MoveCount, 'O');
          if (dinox<>panzerx) and (dinoy>panzery) then DinoMove(MoveCount, 'U');
          if dinox=panzerx then
          begin
            if dinox<SpielForm.dxdraw.Width div 2 then DinoMove(MoveCount, 'R');
            if dinox>SpielForm.dxdraw.Width div 2 then DinoMove(MoveCount, 'L');
            if dinox=SpielForm.dxdraw.Width div 2 then
            begin
              if random(2)=1 then DinoMove(MoveCount, 'L') else
                DinoMove(MoveCount, 'R');
            end;
          end;
          if (dinoy<>panzery) and (dinox<panzerx) then DinoMove(MoveCount, 'L');
          if (dinoy<>panzery) and (dinox>panzerx) then DinoMove(MoveCount, 'R');
        end
        else
        begin
          if dinoy<panzery then DinoMove(MoveCount, 'O');
          if dinoy>panzery then DinoMove(MoveCount, 'U');
          if dinox<panzerx then DinoMove(MoveCount, 'L');
          if dinox>panzerx then DinoMove(MoveCount, 'R');
        end;
      end;
    end
    else
    begin
      if isButton3 in SpielForm.DXInput.States then DinoMove(MoveCount, 'O');
      if isButton4 in SpielForm.DXInput.States then DinoMove(MoveCount, 'U');
      if isButton5 in SpielForm.DXInput.States then DinoMove(MoveCount, 'L');
      if isButton6 in SpielForm.DXInput.States then DinoMove(MoveCount, 'R');
    end;
    if X<1 then X := 1;
    if X>SpielForm.dxdraw.width-(Width+1) then
      X := SpielForm.dxdraw.width-(Width+1);
    if Y<1 then Y := 1;
    if Y>SpielForm.dxdraw.height-(Height+36) then
      Y := SpielForm.dxdraw.height-(Height+36);
    DinoX := X;
    DinoY := Y;
    if DinoColli then DinoColli := false;
  end;
end;

procedure TDino.Hit;
begin
  Collisioned := False;
  DinoColli := true;
  if EinstellungForm.checkBoxSound.checked and soundkarte then
    SpielForm.dxwavelist.items.find('Getötet').play(false);
  if EinstellungForm.Blut.checked then
    Image := SpielForm.dxImageList.Items.Find('Blut')
  else Image := SpielForm.dxImageList.Items.Find('Explosion');
  Width := Image.Width;
  Height := Image.Height;
  AnimCount := Image.PatternCount;
  AnimLooped := false;
  AnimSpeed := 15/1000;
  AnimPos := 0;
  SpielForm.Kommentar:='';
  if not SpielForm.freegamer then
  begin
    if SpielForm.DinoLeben > 0 then dec(SpielForm.DinoLeben);
    SpielForm.Anzeige;
    if SpielForm.DinoLeben=strtoint(EinstellungForm.dinoEnergy.text) then
      SpielForm.DinoGaugeFore:=clgreen;
    if SpielForm.DinoLeben=(StrToInt(EinstellungForm.dinoEnergy.text) div 4) +
      (StrToInt(EinstellungForm.dinoEnergy.text) div 2) then
      SpielForm.DinoGaugeFore:=cllime;
    if SpielForm.DinoLeben=(StrToInt(EinstellungForm.dinoEnergy.text) div 2) then
      SpielForm.DinoGaugeFore:=clyellow;
    if SpielForm.DinoLeben=(StrToInt(EinstellungForm.dinoEnergy.text) div 4) then
      SpielForm.DinoGaugeFore:=clred;
  end;
end;

procedure TPanzer.DoCollision(Sprite: TSprite; var Done: Boolean);
begin
  if Sprite is TDino then
    TDino(Sprite).Hit;
  Done := False;
end;

procedure TPanzer.PanzerMove(MoveCount: integer; course: string);
begin
  if course = 'O' then Y := Y - (300/1000)*MoveCount;
  if course = 'U' then Y := Y + (300/1000)*MoveCount;
  if course = 'L' then X := X - (300/1000)*MoveCount;
  if course = 'R' then X := X + (300/1000)*MoveCount;
  Image := SpielForm.dxImageList.Items.Find('Panzer'+course);
end;

procedure TPanzer.DoMove(MoveCount: Integer);
var
  Pzu1, Pzu2: integer;
begin
  inherited DoMove(MoveCount);
  if not FPanzerstop then
  begin
    if EinstellungForm.checkboxpanzer.checked then
    begin
      if not DinoColli then
      begin
        inc(panzerkitimer, movecount);
        if panzerkitimer >= panzerinterval then
        begin
          panzerkitimer := 0;
          if EinstellungForm.PanzerHoheKI.checked then
          begin
            if panzery<dinoy then PanzerMove(MoveCount, 'U');
            if panzery>dinoy then PanzerMove(MoveCount, 'O');
            if panzerx<dinox then PanzerMove(MoveCount, 'R');
            if panzerx>dinox then PanzerMove(MoveCount, 'L');
          end
          else
          begin
            if ((dinox<=105) and (dinox>32)) and ((dinoy>=192) and
              (dinoy<249)) or ((dinox<=185) and (dinox>128)) and
              ((dinoy>=32) and (dinoy<209)) or ((dinox<=281) and
              (dinox>208)) and ((dinoy>=8) and (dinoy<41)) or ((dinox<=387) and
              (dinox>304)) and ((dinoy>=24) and (dinoy<65)) or ((dinox<=369) and
              (dinox>335)) and ((dinoy>=88) and (dinoy<145)) or
              ((dinox<=434) and (dinox>304)) and ((dinoy>=168) and
              (dinoy<265)) or ((dinox<=281) and (dinox>208)) and
              ((dinoy>=152) and (dinoy<185)) or ((dinox<=233) and
              (dinox>160)) and ((dinoy>=232) and (dinoy<265)) then
            begin
              Pzu1:=Random(SpielForm.Zu) + 1;
              if Pzu1=1 then
              begin
                if panzery<dinoy then PanzerMove(MoveCount, 'U');
                if panzery>dinoy then PanzerMove(MoveCount, 'O');
                if panzerx<dinox then PanzerMove(MoveCount, 'R');
                if panzerx>dinox then PanzerMove(MoveCount, 'L');
              end
              else
              begin
                Pzu2:=Random(4) + 1;
                if Pzu2=1 then PanzerMove(MoveCount, 'U');
                if Pzu2=2 then PanzerMove(MoveCount, 'O');
                if Pzu2=3 then PanzerMove(MoveCount, 'R');
                if Pzu2=4 then PanzerMove(MoveCount, 'L');
              end;
            end
            else
            begin
              if panzery<dinoy then PanzerMove(MoveCount, 'U');
              if panzery>dinoy then PanzerMove(MoveCount, 'O');
              if panzerx<dinox then PanzerMove(MoveCount, 'R');
              if panzerx>dinox then PanzerMove(MoveCount, 'L');
            end;
          end;
        end;
      end;
    end
    else
    begin
      if isUp in SpielForm.DXInput.States then PanzerMove(MoveCount, 'O');
      if isDown in SpielForm.DXInput.States then PanzerMove(MoveCount, 'U');
      if isLeft in SpielForm.DXInput.States then PanzerMove(MoveCount, 'L');
      if isRight in SpielForm.DXInput.States then PanzerMove(MoveCount, 'R');
      if (isButton1 in SpielForm.DXInput.States) and (not FPanzerStop) then
      begin
        if EinstellungForm.checkboxsound.checked and soundkarte then
          SpielForm.dxwavelist.items.find('PanzerStop').play(false);
        FPanzerstop := true;
        SpielForm.VPanzStp := true;
      end;
    end;
    if X<1 then X := 1;
    if X>SpielForm.dxdraw.width-(Width+1) then
      X := SpielForm.dxdraw.width-(Width+1);
    if Y<1 then Y := 1;
    if Y>SpielForm.dxdraw.height-(Height+36) then
      Y := SpielForm.dxdraw.height-(Height+36);
    PanzerX := X;
    PanzerY := Y;
    Collision;
  end
  else
  begin
    if (isButton2 in SpielForm.DXInput.States) and fpanzerstop then
    begin
      if EinstellungForm.checkboxsound.checked and soundkarte then
        SpielForm.dxwavelist.items.find('PanzerStart').play(false);
      FPanzerStop := false;
      SpielForm.VPanzStp := false;
    end;
  end;
end;

procedure TSpielForm.DXTimerActivate(Sender: TObject);
begin
  Caption := Application.Title;
  if VPanzStp and SpielForm.visible then
  begin
    if EinstellungForm.checkboxsound.checked and soundkarte then
      dxwavelist.items.find('PanzerStart').play(false); // ?
    VPanzStp := false;
  end;
  if EinstellungForm.checkboxMusic.checked and soundkarte and
    (not HilfeForm.visible) and SpielForm.visible then
      MCISendString(pchar('play "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
end;

procedure TSpielForm.DXTimerDeactivate(Sender: TObject);
begin
  Caption := Application.Title + ' [Pause]';
  if (not VPanzStp) and SpielForm.visible then
  begin
    if EinstellungForm.checkboxsound.checked and soundkarte then
      dxwavelist.items.find('PanzerStop').play(false);
    VPanzStp := true;
  end;
  if EinstellungForm.checkboxMusic.checked and soundkarte and
    (not HilfeForm.visible) and SpielForm.visible then
      MCISendString(pchar('stop "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
end;

procedure TSpielForm.DXTimerTimer(Sender: TObject; LagCount: Integer);
var
  MCIStatus: array[0..255] of char;
  l, t, w, h: integer;
  templeft: integer;
begin
  if ((not SpielForm.dxdraw.CanDraw) or (SpielForm.ende)) or
    (not SpielForm.dxdraw.CanDraw) and (SpielForm.ende) then exit;
  DXInput.Update;
  LagCount := 1000 div FPS;
  DXSpriteEngine.Move(LagCount);
  DXSpriteEngine.Dead;
  dxdraw.Surface.Fill(8156483);  // Hintegrundfarbe!
  DXSpriteEngine.Draw;
  with DXDraw.Surface.Canvas do
  begin
    Font.Color := clblack;
    {* Brushmodus einstellen *}
    Brush.Style := bsClear;
    {* Schrift setzen *}
    Textout(0, 329, 'Benzin:');
    Textout(152, 329, 'Kommentar:');
    Textout(152, 345, 'Spielzeit:');
    Textout(427, 329, 'Lebensenergie:');
    Textout(103, 345, Spieler1Name);
    // Zu erledigen: LEFTTEMP ANWENDEN!
    Textout(386, 345, Spieler2Name);
    Textout(216, 345, IntToStr(Spielzeit));
    Textout(216, 329, Kommentar);
    if EinstellungForm.checkboxBenzin.checked then
    begin
      templeft := 91;
      if length(Inttostr(DinoLeben)) = 1 then templeft := 91;
      if length(Inttostr(DinoLeben)) = 2 then templeft := 85;
      if length(Inttostr(DinoLeben)) = 3 then templeft := 79;
      Textout(templeft, 329, IntToStr(PanzerBenzin));
    end;
    if EinstellungForm.checkboxLebensenergie.checked then
    begin
      templeft := 518;
      if length(Inttostr(DinoLeben)) = 1 then templeft := 518;
      if length(Inttostr(DinoLeben)) = 2 then templeft := 512;
      if length(Inttostr(DinoLeben)) = 3 then templeft := 506;
      Textout(templeft, 329, IntToStr(DinoLeben));
    end;
    {* Rahmen zeichnen *}
    Rectangle(Rect(0, 0, 527, 361));
    MoveTo(1, 326);
    LineTo(526, 326);
    MoveTo(149, 327);
    LineTo(149, 360);
    MoveTo(377, 327);
    LineTo(377, 360);
    MoveTo(150, 343);
    LineTo(377, 343);
    {* Panzer-Gauge-zeichnen *}
    l := 0;
    t := 344;
    w := 100;
    h := 17;
    Brush.Color := clBlack;
    FillRect(Rect(l+w-1-trunc((strtoint(
      EinstellungForm.panzerEnergy.text)-PanzerBenzin) /
      (strtoint(EinstellungForm.panzerEnergy.text) / (w-2))), t+1, l+w-1, t+h-1));
    Brush.Color := PanzerGaugeFore;
    FillRect(Rect(l+1, t+1, l+w-1-trunc((strtoint(
      EinstellungForm.panzerEnergy.text)-PanzerBenzin) /
      (strtoint(EinstellungForm.panzerEnergy.text) / (w-2))), t+h-1));
    Brush.Style := bsClear;
    Rectangle(Rect(l, t, l+w, t+h));
    {* Dino-Gauge-zeichnen *}
    l := 427;
    t := 344;
    w := 100;
    h := 17;
    Brush.Color := clBlack;
    FillRect(Rect(l+w-1-trunc((strtoint(
      EinstellungForm.dinoEnergy.text)-DinoLeben) /
      (strtoint(EinstellungForm.dinoEnergy.text) / (w-2))), t+1, l+w-1, t+h-1));
    Brush.Color := DinoGaugeFore;
    FillRect(Rect(l+1, t+1, l+w-1-trunc((strtoint(
      EinstellungForm.dinoEnergy.text)-DinoLeben) /
      (strtoint(EinstellungForm.dinoEnergy.text) / (w-2))), t+h-1));
    Brush.Style := bsClear;
    Rectangle(Rect(l, t, l+w, t+h));
    {* Canvas freigeben *}
    Release;
  end;
  dxdraw.Flip;
  if EinstellungForm.CheckBoxMusic.checked and soundkarte then
  begin
    MCISendString(pchar('status "'+directory+AktuelleMIDI+'"'+' mode'), MCIStatus, 255, 0);
    if MCIStatus = 'stopped' then
    begin
      MCISendString(pchar('seek "'+directory+AktuelleMIDI+'"'+' to start'), nil, 255, 0);
      MCISendString(pchar('play "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
    end;
  end;
  inc(durchlauf);
  if durchlauf >= 100 then
  begin
    durchlauf := 0;
    if not freegamer then
    begin
      if not VPanzStp then
      begin
        if PanzerBenzin > 0 then dec(PanzerBenzin);
      end;
      inc(Spielzeit);
      Anzeige;
      if PanzerBenzin=strtoint(EinstellungForm.panzerEnergy.text) then
        PanzerGaugeFore:=clgreen;
      if PanzerBenzin=(StrToInt(EinstellungForm.panzerEnergy.text) Div 4) +
        (StrToInt(EinstellungForm.panzerEnergy.text) Div 2) then
          PanzerGaugeFore:=cllime;
      if PanzerBenzin=(StrToInt(EinstellungForm.panzerEnergy.text) Div 2) then
        PanzerGaugeFore:=clyellow;
      if PanzerBenzin=(StrToInt(EinstellungForm.panzerEnergy.text) Div 4) then
        PanzerGaugeFore:=clred;
    end;
    if (PanzerBenzin <= 0) and (DinoLeben <= 0) and (not freegamer) then
    begin
      dxtimer.enabled := false;
      if EinstellungForm.checkBoxSound.checked and soundkarte then
        dxwavelist.items.find('Gewonnen').play(false);
      Assignfile(daten, directory+'Texte\HighScore.txt');
      Append(daten);
      WriteLN(daten, datetostr(date) + ' - ' + timetostr(time) + ':' +
        #13#10 + #09 + Spieler1Name + ' (Panzer): ' + Inttostr(PanzerBenzin) +
        #13#10 + #09 + Spieler2Name + ' (Dino): ' + Inttostr(DinoLeben) +
        #13#10 + #09 + 'Zeit: ' + Inttostr(Spielzeit) + #13#10);
      CloseFile(daten);
      ende := true;
      Kommentar:='Was geht ab?!';
      MessageDLG('Gleichstand - Keiner hat gewonnen!', mtInformation, [mbOK], 0);
      Kommentar:='';
      MenuForm.start.visible:=true;
      MenuForm.video.visible:=true;
      MenuForm.Optionen.Visible:=true;
      MenuForm.Ende.Visible:=true;
      MenuForm.edit1.visible:=false;
      MenuForm.edit2.visible:=false;
      MenuForm.name1.visible:=false;
      MenuForm.name2.visible:=false;
      MenuForm.los.visible:=false;
      MenuForm.abb.visible:=false;
      if EinstellungForm.checkboxmusic.checked and soundkarte then
        MCISendString(pchar('stop "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
      Visible:=false;
      MenuForm.Visible:=true;
      MenuForm.setfocus;
      ende := true;
      exit;
    end;
    if (DinoLeben <= 0) and (not freegamer) then
    begin
      dxtimer.enabled := false;
      if EinstellungForm.checkBoxSound.checked and soundkarte then
        dxwavelist.items.find('Gewonnen').play(false);
      Assignfile(daten, directory+'Texte\HighScore.txt');
      Append(daten);
      WriteLN(daten, datetostr(date) + ' - ' + timetostr(time) + ':' +
        #13#10 + #09 + Spieler1Name + ' (Panzer): ' + Inttostr(PanzerBenzin) +
        #13#10 + #09 + Spieler2Name + ' (Dino): ' + Inttostr(DinoLeben) +
        #13#10 + #09 + 'Zeit: ' + Inttostr(Spielzeit) + #13#10);
      CloseFile(daten);
      ende := true;
      Kommentar:='Sie haben es geschafft!!!';
      MessageDLG('Gratulation Panzergeneral ' + Spieler1Name +
        ', Sie haben gewonnen!', mtInformation, [mbOK], 0);
      Kommentar:='';
      MenuForm.start.visible:=true;
      MenuForm.video.visible:=true;
      MenuForm.Optionen.Visible:=true;
      MenuForm.Ende.Visible:=true;
      MenuForm.edit1.visible:=false;
      MenuForm.edit2.visible:=false;
      MenuForm.name1.visible:=false;
      MenuForm.name2.visible:=false;
      MenuForm.los.visible:=false;
      MenuForm.abb.visible:=false;
      if EinstellungForm.checkboxmusic.checked and soundkarte then
        MCISendString(pchar('stop "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
      Visible:=false;
      MenuForm.Visible:=true;
      MenuForm.setfocus;
      ende := true;
      exit;
    end;
    if (PanzerBenzin <= 0) and (not freegamer) then
    begin
      dxtimer.enabled := false;
      if EinstellungForm.checkBoxSound.checked and soundkarte then
        dxwavelist.items.find('Gewonnen').play(false);
      Assignfile(daten, directory+'Texte\HighScore.txt');
      Append(daten);
      WriteLN(daten, datetostr(date) + ' - ' + timetostr(time) + ':' + #13#10 +
        #09 + Spieler1Name + ' (Panzer): ' + Inttostr(PanzerBenzin) + #13#10 +
        #09 + Spieler2Name + ' (Dino): ' + Inttostr(DinoLeben) + #13#10 + #09 +
        'Zeit: ' + Inttostr(Spielzeit) + #13#10 + #13#10);
      CloseFile(daten);
      ende := true;
      Kommentar:='Das darf nicht wahr sein!!!';
      MessageDLG(Spieler2Name +
        ', du hast es geschafft, du bist entkommen!', mtInformation, [mbOK], 0);
      Kommentar:='';
      MenuForm.start.visible:=true;
      MenuForm.video.visible:=true;
      MenuForm.Optionen.Visible:=true;
      MenuForm.Ende.Visible:=true;
      MenuForm.edit1.visible:=false;
      MenuForm.edit2.visible:=false;
      MenuForm.name1.visible:=false;
      MenuForm.name2.visible:=false;
      MenuForm.los.visible:=false;
      MenuForm.abb.visible:=false;
      if EinstellungForm.checkboxmusic.checked and soundkarte then
        MCISendString(pchar('stop "'+directory+AktuelleMIDI+'"'), nil, 255, 0);;
      Visible:=false;
      MenuForm.Visible:=true;
      MenuForm.setfocus;
      ende := true;
      exit;
    end;
  end;
  if not freegamer then
  begin
    if Spielzeit=60 then
      Kommentar:='Sie sollten sich etwas beeilen!';
    if Spielzeit=65 then Kommentar:='';
    if Spielzeit=120 then
      Kommentar:='Ihr Gegner schläft gleich ein!';
    if Spielzeit=125 then Kommentar:='';
    if Spielzeit=180 then
      Kommentar:='Wird das heute noch was?!';
    if Spielzeit=185 then Kommentar:='';
    if Spielzeit=240 then
      Kommentar:='Jetzt beeilen Sie sich endlich!';
    if Spielzeit=245 then Kommentar:='';
    if Spielzeit=300 then
      Kommentar:='Wir haben nicht unendlich Zeit!';
    if Spielzeit=305 then Kommentar:='';
    if Spielzeit=365 then
      Kommentar:='Dino: Du kriegst mich nicht, ätsch!';
    if Spielzeit=370 then Kommentar:='';
    if Spielzeit=430
      then Kommentar:='Dino: schnarch... schnarch...';
    if Spielzeit=435 then Kommentar:='';
    if Spielzeit=495
      then Kommentar:='LANGWEILIG!!!';
    if Spielzeit=500 then Kommentar:='';
  end
  else Kommentar:='Spielen ohne Begrenzung!';
end;

procedure TSpielForm.dxdrawFinalize(Sender: TObject);
begin
  DXTimer.Enabled := False;
end;

procedure TSpielForm.dxdrawInitialize(Sender: TObject);
begin
  DXTimer.Enabled := True;
end;

procedure TSpielForm.Anzeige;
begin
end;

procedure TSpielForm.HauptmenueClick(Sender: TObject);
var
  i: integer;
begin
  dxtimer.enabled := false;
  if EinstellungForm.checkboxMusic.checked and soundkarte then
    MCISendString(pchar('stop "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
  for i := 1 to 8 do cheat[i]:=false;
  freegamer:=false;
  MenuForm.start.visible:=true;
  MenuForm.video.visible:=true;
  MenuForm.Optionen.Visible:=true;
  MenuForm.Ende.Visible:=true;
  MenuForm.edit1.visible:=false;
  MenuForm.edit2.visible:=false;
  MenuForm.name1.visible:=false;
  MenuForm.name2.visible:=false;
  MenuForm.los.visible:=false;
  MenuForm.abb.visible:=false;
  PanzerBenzin:=Strtoint(EinstellungForm.dinoEnergy.text);
  DinoLeben:=Strtoint(EinstellungForm.panzerEnergy.text);
  Anzeige;
  Visible:=false;
  MenuForm.Visible:=true;
  MenuForm.setfocus;
  DXSpriteEngine.Engine.Clear;
end;

procedure TSpielForm.FormShow(Sender: TObject);
begin
  dxtimer.Enabled := true;
  dxtimer.ActiveOnly := true;

  randomize;
  if EinstellungForm.CheckBoxPanzer.checked then
  begin
    if EinstellungForm.IVP.checked then
    begin
      Panzerinterval:=strtoint(EinstellungForm.PInterval.text);
      Zu := strtoint(EinstellungForm.verwirrungedt.text);
    end
    else
    begin
      if EinstellungForm.PLe.Checked then
      begin
        Panzerinterval:=13;
        Zu:=5;
      end;
      if EinstellungForm.PMi.Checked then
      begin
        Panzerinterval:=8;
        Zu:=4;
      end;
      if EinstellungForm.PSc.Checked then
      begin
        Panzerinterval:=3;
        Zu:=3;
      end;
    end;
  end;
  if EinstellungForm.CheckBoxDino.checked then
  begin
    if EinstellungForm.IVD.checked then
      Dinointerval := strtoint(EinstellungForm.DInterval.text)
    else
    begin
      if EinstellungForm.DLe.Checked then Dinointerval := 13;
      if EinstellungForm.DMi.Checked then Dinointerval := 8;
      if EinstellungForm.DSc.Checked then Dinointerval := 3;
    end;
  end;

  if EinstellungForm.CheckBoxMusic.checked and soundkarte then
  begin
    if EinstellungForm.Musik1.checked then
      AktuelleMIDI := 'Musik\musik1.mid';
    if EinstellungForm.Musik2.checked then
      AktuelleMIDI := 'Musik\musik2.mid';
    if EinstellungForm.Musik3.checked then
      AktuelleMIDI := 'Musik\musik3.mid';
    if EinstellungForm.Musik4.checked then
      AktuelleMIDI := 'Musik\musik4.mid';
    if EinstellungForm.Musik5.checked then
      AktuelleMIDI := 'Musik\musik5.mid';
    MCISendString(pchar('open "'+directory+AktuelleMIDI+'"'), nil, 255, 0);

    if not DXSound.Initialized then
    begin
      try
        DXSound.Initialize;
        dxwavelist.Items.LoadFromFile(directory+'DirectX\Audio.dxw');
      except
        EinstellungForm.CheckBoxSound.enabled := False;
        dxwavelist.items.clear;
      end;
    end;
  end
  else
  begin
    DXSound.Finalize;
  end;

  SpielForm.dxtimer.enabled := true;
  SpielForm.anzeige;
end;

// http://www.delphipraxis.net/post43515.html
Function GetHTML(AUrl: string): string;
var
  databuffer : array[0..4095] of char;
  ResStr : string;
  hSession, hfile: hInternet;
  dwindex,dwcodelen,dwread,dwNumber: cardinal;
  dwcode : array[1..20] of char;
  res    : pchar;
  Str    : pchar;
begin
  ResStr:='';
  if system.pos('http://',lowercase(AUrl))=0 then
     AUrl:='http://'+AUrl;

  // Hinzugefügt
  application.ProcessMessages;

  hSession:=InternetOpen('InetURL:/1.0',
                         INTERNET_OPEN_TYPE_PRECONFIG,
                         nil,
                         nil,
                         0);
  if assigned(hsession) then
  begin
    // Hinzugefügt
    application.ProcessMessages;

    hfile:=InternetOpenUrl(
           hsession,
           pchar(AUrl),
           nil,
           0,
           INTERNET_FLAG_RELOAD,
           0);
    dwIndex  := 0;
    dwCodeLen := 10;

    // Hinzugefügt
    application.ProcessMessages;

    HttpQueryInfo(hfile,
                  HTTP_QUERY_STATUS_CODE,
                  @dwcode,
                  dwcodeLen,
                  dwIndex);
    res := pchar(@dwcode);
    dwNumber := sizeof(databuffer)-1;
    if (res ='200') or (res ='302') then
    begin
      while (InternetReadfile(hfile,
                              @databuffer,
                              dwNumber,
                              DwRead)) do
      begin

        // Hinzugefügt
        application.ProcessMessages;

        if dwRead =0 then
          break;
        databuffer[dwread]:=#0;
        Str := pchar(@databuffer);
        resStr := resStr + Str;
      end;
    end
    else
      ResStr := 'Status:'+res;
    if assigned(hfile) then
      InternetCloseHandle(hfile);
  end;

  // Hinzugefügt
  application.ProcessMessages;

  InternetCloseHandle(hsession);
  Result := resStr; 
end;

procedure TSpielForm.UpdatesClick(Sender: TObject);
var
  temp: string;
begin
  temp := GetHTML('http://www.viathinksoft.de/update/?id=dpg2');
  if copy(temp, 0, 7) = 'Status:' then
  begin
    Application.MessageBox('Ein Fehler ist aufgetreten. Wahrscheinlich ist keine Internetverbindung aufgebaut, oder der der ViaThinkSoft-Server temporär offline.', 'Fehler', MB_OK + MB_ICONERROR)
  end
  else
  begin
    if GetHTML('http://www.viathinksoft.de/update/?id=dpg2') <> '1.5c' then
    begin
      if Application.MessageBox('Eine neue Programmversion ist vorhanden. Möchten Sie diese jetzt herunterladen?', 'Information', MB_YESNO + MB_ICONASTERISK) = ID_YES then
        shellexecute(application.handle, 'open', pchar('http://www.viathinksoft.de/update/?id=@dpg2'), '', '', sw_normal);
    end
    else
    begin
      Application.MessageBox('Es ist keine neue Programmversion vorhanden.', 'Information', MB_OK + MB_ICONASTERISK);
    end;
  end;
end;

procedure TSpielForm.BeendenClick(Sender: TObject);
begin
  SpielForm.Close;
end;

procedure TSpielForm.NeustartClick(Sender: TObject);
var
  i: integer;
begin
  dxtimer.enabled := false;
  for i := 1 to 8 do cheat[i]:=false;
  Kommentar:='';
  if EinstellungForm.checkBoxMusic.checked and soundkarte then
  begin
    if freegamer then
    begin
      MCISendString(pchar('close "'+directory+AktuelleMIDI+'"'), nil, 255, 0); // ?
      if EinstellungForm.Musik1.checked then AktuelleMIDI := 'Musik\musik1.mid';
      if EinstellungForm.Musik2.checked then AktuelleMIDI := 'Musik\musik2.mid';
      if EinstellungForm.Musik3.checked then AktuelleMIDI := 'Musik\musik3.mid';
      if EinstellungForm.Musik4.checked then AktuelleMIDI := 'Musik\musik4.mid';
      if EinstellungForm.Musik5.checked then AktuelleMIDI := 'Musik\musik5.mid';
      MCISendString(pchar('open "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
      freegamer := false;
    end
    else
    begin
      MCISendString(pchar('stop "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
      MCISendString(pchar('seek "'+directory+AktuelleMIDI+'"'+' to start'), nil, 255, 0);
    end;
    MCISendString(pchar('play "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
  end;
  PanzerBenzin := 0;
  MenuForm.los.click;
  dxtimer.enabled := true;
end;

procedure TSpielForm.HilfeClick(Sender: TObject);
begin
  dxtimer.enabled := false;
  if sender=Geschichte then
  begin
    HilfeForm.caption := 'Hilfe';
    HilfeForm.TextMemo.lines.loadfromfile(directory+'Texte\Geschichte.txt');
    HilfeForm.CaptionLabel.caption:='Geschichte';
  end;
  if sender=Ziel then
  begin
    HilfeForm.caption := 'Hilfe';
    HilfeForm.TextMemo.lines.loadfromfile(directory+'Texte\Ziel.txt');
    HilfeForm.CaptionLabel.caption:='Ziel';
  end;
  if sender=Steuerung then
  begin
    HilfeForm.caption := 'Hilfe';
    HilfeForm.TextMemo.lines.loadfromfile(directory+'Texte\Steuerung.txt');
    HilfeForm.CaptionLabel.caption:='Steuerung';
  end;
  if sender=Info then
  begin
    HilfeForm.caption := 'Hilfe';
    HilfeForm.TextMemo.lines.loadfromfile(directory+'Texte\Informationen.txt');
    HilfeForm.CaptionLabel.caption:='Informationen';
  end;
  if sender=Mitarbeiter then
  begin
    HilfeForm.caption := 'Hilfe';
    HilfeForm.TextMemo.lines.loadfromfile(directory+'Texte\Mitarbeiter.txt');
    HilfeForm.CaptionLabel.caption:='Mitarbeiter';
  end;
  if sender=Anzeigen then
  begin
    HilfeForm.caption := 'HighScores';
    HilfeForm.TextMemo.lines.loadfromfile(directory+'Texte\HighScore.txt');
    HilfeForm.CaptionLabel.caption:='HighScores';
  end;
  HilfeForm.showmodal;
end;

procedure TSpielForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SpielForm.Hide;
  DXSpriteEngine.Engine.Clear;
  DXTimer.enabled := false;
  if soundkarte and EinstellungForm.checkboxmusic.checked then
    MCISendString(pchar('close "'+directory+AktuelleMIDI+'"'), nil, 255, 0); // NEU!
  dxinput.Destroy;
  dxsound.Finalize;
  dxSpriteEngine.Engine.Clear;
  MenuForm.close;
end;

procedure TSpielForm.InternetClick(Sender: TObject);
begin
  if sender=link1 then
    ShellExecute(Handle, 'open', 'http://www.md-technologie.de/', '', '', 1);
  if sender=link2 then
    ShellExecute(Handle, 'open', 'http://www.daniel-marschall.de/', '', '', 1);
  if sender=link3 then
    ShellExecute(Handle, 'open', 'http://www.viathinksoft.de/', '', '', 1);
  if sender=neuesteversion then
    ShellExecute(Handle, 'open',
    'http://www.viathinksoft.de/index.php?page=projektanzeige&seite=projekt-21', '', '', 1);
  if Sender=VerbesserungsEMail then
    ShellExecute(Handle, 'open',
    pchar('mailto:info@daniel-marschall.de?subject=Verbesserungen zu DPG 2, Version ' + EngineVersion), '', '', 1);
end;

procedure TSpielForm.LeerenClick(Sender: TObject);
begin
  if MessageDlg('Wirklich alle HighScores löschen?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    AssignFile(daten, 'Texte\HighScore.txt');
    Rewrite(daten);
    WriteLN(daten, 'HighScores in DPG II:');
    WriteLN(daten, '=====================');
    WriteLN(daten);
    CloseFile(daten);
  end;
end;

procedure TSpielForm.FormCreate(Sender: TObject);
begin
  { Beginne VCL-Ersatz }
  dxtimer := tdxtimer.Create(self);
  dxtimer.Interval := 33;
  dxtimer.OnActivate := DXTimerActivate;
  dxtimer.OnDeactivate := DXTimerDeactivate;
  dxtimer.OnTimer := DXTimerTimer;
  dxtimer.Enabled := false;
  dxtimer.ActiveOnly := false;

  dxdraw := tdxdraw.Create(self);
  dxdraw.Parent := self;
  dxdraw.Left := 0;
  dxdraw.Top := 0;
  dxdraw.Width := 527;
  dxdraw.Height := 361;
  dxdraw.AutoInitialize := True;
  dxdraw.AutoSize := True;
  dxdraw.Color := 4420988;
  dxdraw.Display.BitCount := 24;
  dxdraw.Display.FixedBitCount := False;
  dxdraw.Display.FixedRatio := False;
  dxdraw.Display.FixedSize := False;
  dxdraw.Options := [doAllowReboot, doWaitVBlank, doCenter, doDirectX7Mode, doHardware, doSelectDriver];
  dxdraw.SurfaceHeight := 361;
  dxdraw.SurfaceWidth := 527;
  dxdraw.OnFinalize := DXDrawFinalize;
  dxdraw.OnInitialize := DXDrawInitialize;
  dxdraw.TabOrder := 0;
  dxdraw.OnMouseDown := DXDrawMouseDown;
  dxdraw.OnMouseUp := DXDrawMouseUp;

  dxsound := tdxsound.Create(self);
  dxsound.AutoInitialize := false;

  dxinput := tdxinput.Create(self);
  dxinput.Joystick.ForceFeedback := true;
  dxinput.Keyboard.ForceFeedback := true;

  dxwavelist := tdxwavelist.Create(self);
  dxwavelist.DXSound := dxsound;

  dximagelist := tdximagelist.create(self);
  dximagelist.DXDraw := dxdraw;

  dxspriteengine := tdxspriteengine.create(self);
  dxspriteengine.DXDraw := dxdraw;

  { Ende VCL-Ersatz }

  dxtimer.interval := 1000 div FPS;
  //dxwavelist.Items.LoadFromFile(directory+'DirectX\Audio.dxw');
  dxImageList.Items.loadfromfile(directory+'DirectX\Grafik.dxg');
  dxImageList.Items.MakeColorTable;
  dxdraw.ColorTable := dxImageList.Items.ColorTable;
  dxdraw.DefColorTable := dxImageList.Items.ColorTable;
  dxdraw.UpdatePalette;

  neustart.bitmap.loadfromfile(directory+'Bilder\Neustart.bmp');
  hauptmenue.bitmap.loadfromfile(directory+'Bilder\Abbrechen.bmp');
  beenden.bitmap.loadfromfile(directory+'Bilder\Verlassen.bmp');
  link1.bitmap.loadfromfile(directory+'Bilder\Link.bmp');
  link2.bitmap.loadfromfile(directory+'Bilder\Link.bmp');
  link3.bitmap.loadfromfile(directory+'Bilder\Link.bmp');
  Updates.bitmap.loadfromfile(directory+'Bilder\Weltkugel.bmp');
  neuesteversion.bitmap.loadfromfile(directory+'Bilder\Blatt.bmp');
  verbesserungsemail.bitmap.loadfromfile(directory+'Bilder\Brief.bmp');
  anzeigen.bitmap.loadfromfile(directory+'Bilder\Blätter.bmp');
  leeren.bitmap.loadfromfile(directory+'Bilder\Abbrechen.bmp');
  info.bitmap.loadfromfile(directory+'Bilder\Buch.bmp');
  geschichte.bitmap.loadfromfile(directory+'Bilder\Fragezeichen.bmp');
  ziel.bitmap.loadfromfile(directory+'Bilder\Fragezeichen.bmp');
  steuerung.bitmap.loadfromfile(directory+'Bilder\Fragezeichen.bmp');
  mitarbeiter.bitmap.loadfromfile(directory+'Bilder\Blätter.bmp');
  spiel.bitmap.loadfromfile(directory+'Bilder\Tastatur.bmp');
  internet.bitmap.loadfromfile(directory+'Bilder\Weltkugel.bmp');
  highscore.bitmap.loadfromfile(directory+'Bilder\Buch.bmp');
  hilfe.bitmap.loadfromfile(directory+'Bilder\Fragezeichen.bmp');
end;

procedure TSpielForm.FormHide(Sender: TObject);
begin
  dxtimer.enabled := false;
  gestartet := false;
  if soundkarte and EinstellungForm.checkboxmusic.checked then
    MCISendString(pchar('close "'+directory+AktuelleMIDI+'"'), nil, 255, 0); // NEU!
end;

procedure TSpielForm.DXDrawMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button <> mbLeft then exit;
  if (x>=Wald1l) and (x<=Wald1l+Wald1w) and (y>=Wald1t) and (y<=Wald1t+Wald1h) then cheat[1] := true;
  if (x>=Wald2l) and (x<=Wald2l+Wald2w) and (y>=Wald2t) and (y<=Wald2t+Wald2h) then cheat[2] := true;
  if (x>=Wald3l) and (x<=Wald3l+Wald3w) and (y>=Wald3t) and (y<=Wald3t+Wald3h) then cheat[3] := true;
  if (x>=Wald4l) and (x<=Wald4l+Wald4w) and (y>=Wald4t) and (y<=Wald4t+Wald4h) then cheat[4] := true;
  if (x>=Wald5l) and (x<=Wald5l+Wald5w) and (y>=Wald5t) and (y<=Wald5t+Wald5h) then cheat[5] := true;
  if (x>=Wald6l) and (x<=Wald6l+Wald6w) and (y>=Wald6t) and (y<=Wald6t+Wald6h) then cheat[6] := true;
  if (x>=Wald7l) and (x<=Wald7l+Wald7w) and (y>=Wald7t) and (y<=Wald7t+Wald7h) then cheat[7] := true;
  if (x>=Wald8l) and (x<=Wald8l+Wald8w) and (y>=Wald8t) and (y<=Wald8t+Wald8h) then cheat[8] := true;
end;

procedure TSpielForm.DXDrawMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (not freegamer) and cheat[1] and cheat[2] and cheat[3] and cheat[4] and
    cheat[5] and cheat[6] and cheat[7] and cheat[8] then
  begin
    freegamer:=true;
    if EinstellungForm.checkboxmusic.checked and soundkarte then
    begin
      MCISendString(pchar('stop "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
      MCISendString(pchar('close "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
      AktuelleMIDI := 'Musik\Freegamer.mid';
      MCISendString(pchar('open "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
      MCISendString(pchar('play "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
    end;
  end;
end;

procedure TSpielForm.PauseClick(Sender: TObject);
begin
  splpause := not splpause;
  dxtimer.enabled := not splpause;
  if splpause then
  begin
    if EinstellungForm.checkboxMusic.checked and soundkarte and
      (not HilfeForm.visible) then
        MCISendString(pchar('stop "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
    pause.bitmap.loadfromfile(directory+'Bilder\OK.bmp');
    pause.caption := 'Spiel &fortsetzen';
  end
  else
  begin
    if EinstellungForm.checkboxMusic.checked and soundkarte and
      (not HilfeForm.visible) then
        MCISendString(pchar('play "'+directory+AktuelleMIDI+'"'), nil, 255, 0);
    pause.bitmap.loadfromfile(directory+'Bilder\Abbrechen.bmp');
    pause.caption := '&Pause';
  end;
end;

procedure TSpielForm.FormDestroy(Sender: TObject);
begin
  dximagelist.free;
  dxspriteengine.free;
  dxdraw.Free;
  dxwavelist.free;
  dxsound.free;
  //dxinput.free;
  dxtimer.Free;
end;

end.

