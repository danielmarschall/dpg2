/////////////////////////////////////////////////////////
//  * Der Panzergeneral 2 - Version 1.5 - Quellcode *  //
//  -------------------------------------------------  //
//  Entwicklung: Michael Düpjohann & Daniel Marschall. //
//  -------------------------------------------------  //
//  (C)Copyright 2000 - 2005 ViaThinkSoft.             //
//  Alle Rechte vorbehalten.                           //
/////////////////////////////////////////////////////////

unit DPGUnit1;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, MPlayer, DXClass, DXSprite, DXInput, DXDraws,
  DXSounds, INIFiles;

type
  TMenuForm = class(TDXForm)
    Hintergrund: TImage;
    Start: TBitBtn;
    Optionen: TBitBtn;
    Video: TBitBtn;
    Ende: TBitBtn;
    Los: TBitBtn;
    Abb: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    VersionLabel: TLabel;
    CopyPanel: TPanel;
    CopyLabel1: TLabel;
    CopyLabel2: TLabel;
    Name1: TLabel;
    Name2: TLabel;
    procedure EndeClick(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure OptionenClick(Sender: TObject);
    procedure LosClick(Sender: TObject);
    procedure AbbClick(Sender: TObject);
    procedure Videoclick(Sender: TObject);
    procedure StartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure HintergrundMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure videoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EndeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure OptionenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LosMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AbbMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

var
  MenuForm: TMenuForm;
  Aenderung: boolean;

implementation

uses
  DPGGlobal, DPGUnit2, DPGUnit3, DPGUnit4, DPGUnit5, DPGUnit6;

{$R *.DFM}

procedure TMenuForm.EndeClick(Sender: TObject);
begin
  ende.font.color := clwindowtext;
  close;
end;

procedure TMenuForm.StartClick(Sender: TObject);
begin
  start.font.color := clwindowtext;
  start.visible := false;
  video.visible := false;
  Optionen.Visible := false;
  Ende.Visible := false;                                                   
  edit1.visible := true;
  edit2.visible := true;
  name1.visible := true;
  name2.visible := true;
  los.visible := true;
  abb.visible := true;
  los.SetFocus;
end;

procedure TMenuForm.OptionenClick(Sender: TObject);
begin
  optionen.font.color := clwindowtext;
  visible := false;
  EinstellungForm.visible := true;
  EinstellungForm.setfocus;
end;

procedure TMenuForm.LosClick(Sender: TObject);
begin
  los.font.color := clwindowtext;
  SpielForm.DinoLeben := Strtoint(EinstellungForm.dinoEnergy.text);
  SpielForm.PanzerBenzin := Strtoint(EinstellungForm.panzerEnergy.text);
  SpielForm.Spielzeit := 0;
  SpielForm.PanzerGaugeFore := clgreen;
  SpielForm.DinoGaugeFore := clgreen;
  SpielForm.PanzerBenzin := strtoint(EinstellungForm.panzerEnergy.text);
  SpielForm.DinoLeben := strtoint(EinstellungForm.dinoEnergy.text);
  SpielForm.Spieler1Name := edit1.text;
  SpielForm.Spieler2Name := edit2.text;
  if (edit1.text = '') or (edit1.text = 'Name Spieler 1 (Panzer)') then
    SpielForm.Spieler1Name := 'Spieler1';
  if (edit2.text = '') or (edit2.text = 'Name Spieler 2 (Dino)') then
    SpielForm.Spieler2Name := 'Spieler2';
  if EinstellungForm.Spielernamen.checked then EinstellungForm.SaveINI;
  Randomize;
  SpielForm.dxSpriteEngine.Engine.Clear;
  with TBackground.Create(SpielForm.DXSpriteEngine.Engine) do
  begin
    SetMapSize(1, 1);
    X := 1;
    Y := 1;
  end;
  with TPanzer.Create(SpielForm.DXSpriteEngine.Engine) do
  begin
    X := 26;
    Y := 11;
  end;
  with TDino.Create(SpielForm.DXSpriteEngine.Engine) do
  begin
    X := 436;
    Y := 31;
  end;
  with TWald.Create(SpielForm.DXSpriteEngine.Engine) do
  begin
    Image := SpielForm.dxImageList.Items.Find('Wald1');
    x := Wald1l;
    y := Wald1t;
    width := image.width;
    height := image.height;
  end;
  with TWald.Create(SpielForm.DXSpriteEngine.Engine) do
  begin
    Image := SpielForm.dxImageList.Items.Find('Wald2');
    x := Wald2l;
    y := Wald2t;
    width := image.width;
    height := image.height;
  end;
  with TWald.Create(SpielForm.DXSpriteEngine.Engine) do
  begin
    Image := SpielForm.dxImageList.Items.Find('Wald3');
    x := Wald3l;
    y := Wald3t;
    width := image.width;
    height := image.height;
  end;
  with TWald.Create(SpielForm.DXSpriteEngine.Engine) do
  begin
    Image := SpielForm.dxImageList.Items.Find('Wald4');
    x := Wald4l;
    y := Wald4t;
    width := image.width;
    height := image.height;
  end;
  with TWald.Create(SpielForm.DXSpriteEngine.Engine) do
  begin
    Image := SpielForm.dxImageList.Items.Find('Wald5');
    x := Wald5l;
    y := Wald5t;
    width := image.width;
    height := image.height;
  end;
  with TWald.Create(SpielForm.DXSpriteEngine.Engine) do
  begin
    Image := SpielForm.dxImageList.Items.Find('Wald6');
    x := Wald6l;
    y := Wald6t;
    width := image.width;
    height := image.height;
  end;
  with TWald.Create(SpielForm.DXSpriteEngine.Engine) do
  begin
    Image := SpielForm.dxImageList.Items.Find('Wald7');
    x := Wald7l;
    y := Wald7t;
    width := image.width;
    height := image.height;
  end;
  with TWald.Create(SpielForm.DXSpriteEngine.Engine) do
  begin
    Image := SpielForm.dxImageList.Items.Find('Wald8');
    x := Wald8l;
    y := Wald8t;
    width := image.width;
    height := image.height;
  end;
  SpielForm.pause.bitmap.loadfromfile(directory+'Bilder\Abbrechen.bmp');
  SpielForm.pause.caption := 'Pause';
  SpielForm.ende := false;
  Visible := False;
  SpielForm.visible := true;
  SpielForm.setfocus;
end;

procedure TMenuForm.AbbClick(Sender: TObject);
begin
  abb.font.color := clwindowtext;
  start.visible := true;
  video.visible := true;
  Optionen.Visible := true;
  Ende.Visible := true;
  edit1.visible := false;
  edit2.visible := false;
  name1.visible := false;
  name2.visible := false;
  los.visible := false;
  abb.visible := false;
  start.SetFocus;
end;

procedure TMenuForm.Videoclick(Sender: TObject);
begin
  video.font.color := clwindowtext;
  { if EinstellungForm.checkboxvideo.checked=false then
  begin
    MessageDLG('Das Anfangsvideo wurde nicht aktiviert!',
      mtInformation, [mbOK], 0);
    exit;
  end; }
  visible := false;
  VideoForm.visible := true;
  VideoForm.setfocus;
end;

procedure TMenuForm.StartMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  optionen.font.color := clwindowtext;
  video.font.color := clwindowtext;
  ende.font.color := clwindowtext;
  los.font.color := clwindowtext;
  abb.font.color := clwindowtext;
  start.font.color := clnavy;
end;

procedure TMenuForm.HintergrundMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  start.font.color := clwindowtext;
  optionen.font.color := clwindowtext;
  video.font.color := clwindowtext;
  ende.font.color := clwindowtext;
  los.font.color := clwindowtext;
  abb.font.color := clwindowtext;
end;

procedure TMenuForm.videoMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  start.font.color := clwindowtext;
  optionen.font.color := clwindowtext;
  ende.font.color := clwindowtext;
  los.font.color := clwindowtext;
  abb.font.color := clwindowtext;
  video.font.color := clnavy;
end;

procedure TMenuForm.EndeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  start.font.color := clwindowtext;
  optionen.font.color := clwindowtext;
  video.font.color := clwindowtext;
  los.font.color := clwindowtext;
  abb.font.color := clwindowtext;
  ende.font.color := clnavy;
end;

procedure TMenuForm.OptionenMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  start.font.color := clwindowtext;
  video.font.color := clwindowtext;
  ende.font.color := clwindowtext;
  los.font.color := clwindowtext;
  abb.font.color := clwindowtext;
  optionen.font.color := clnavy;
end;

procedure TMenuForm.LosMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  start.font.color := clwindowtext;
  optionen.font.color := clwindowtext;
  video.font.color := clwindowtext;
  ende.font.color := clwindowtext;
  abb.font.color := clwindowtext;
  los.font.color := clnavy;
end;

procedure TMenuForm.AbbMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  start.font.color := clwindowtext;
  optionen.font.color := clwindowtext;
  video.font.color := clwindowtext;
  ende.font.color := clwindowtext;
  los.font.color := clwindowtext;
  abb.font.color := clnavy;
end;

procedure TMenuForm.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if sender = edit1 then
  begin
    if length(edit1.Text)>edit1.maxlength then edit1.Text := '';
  end
  else
    if sender = edit2 then
      if length(edit2.Text)>edit2.maxlength then edit2.Text := '';
end;

procedure TMenuForm.FormShow(Sender: TObject);
begin
  Start.SetFocus;
end;

procedure TMenuForm.FormCreate(Sender: TObject);
begin
  VersionLabel.caption := VersionLabel.caption + ' ' + engineversion;
  Hintergrund.Picture.LoadFromFile(directory+'Bilder\Hintergrund.bmp');
  Start.Glyph.LoadFromFile(directory+'Bilder\OK.bmp');
  Los.Glyph.LoadFromFile(directory+'Bilder\OK.bmp');
  Abb.Glyph.LoadFromFile(directory+'Bilder\Abbrechen.bmp');
  Ende.Glyph.LoadFromFile(directory+'Bilder\Verlassen.bmp');
  Video.Glyph.LoadFromFile(directory+'Bilder\Video.bmp');
  Optionen.Glyph.LoadFromFile(directory+'Bilder\Buch.bmp');
  CopyLabel1.caption := Copyright;
end;

end.

