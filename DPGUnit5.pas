/////////////////////////////////////////////////////////
//  * Der Panzergeneral 2 - Version 1.5 - Quellcode *  //
//  -------------------------------------------------  //
//  Entwicklung: Michael Düpjohann & Daniel Marschall. //
//  -------------------------------------------------  //
//  (C)Copyright 2000 - 2005 ViaThinkSoft.             //
//  Alle Rechte vorbehalten.                           //
/////////////////////////////////////////////////////////

unit DPGUnit5;
                                                                                 
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  MPlayer, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TVideoForm = class(TForm)
    VideoTimer: TTimer;
    Weiter: TBitBtn;
    Beenden: TBitBtn;
    VideoPanel1: TPanel;
    VideoPanel2: TPanel;
    AviPlayer: TMediaPlayer;
    WavePlayer: TMediaPlayer;
    procedure WeiterClick(Sender: TObject);
    procedure BeendenClick(Sender: TObject);
    procedure WeiterMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BeendenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormHide(Sender: TObject);
    procedure VideoTimerTimer(Sender: TObject);
  private
    Play: boolean;
  end;

var
  VideoForm: TVideoForm;

implementation

uses
  DPGGlobal, DPGUnit1, DPGUnit2, DPGUnit3, DPGUnit4, DPGUnit6;

{$R *.DFM}

procedure TVideoForm.WeiterClick(Sender: TObject);
begin
  Weiter.Font.Color := clwindowtext;
  visible := false;
  MenuForm.visible := true;
  MenuForm.setfocus;
  if Play then
  begin
    WavePlayer.stop;
    WavePlayer.close;
    Play := false;
  end;
  AviPlayer.stop;
  AviPlayer.close;
end;

procedure TVideoForm.BeendenClick(Sender: TObject);
begin
  Beenden.Font.Color := clwindowtext;
  MenuForm.close;
end;

procedure TVideoForm.WeiterMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Beenden.Font.Color := clwindowtext;
  Weiter.Font.Color := clnavy;
end;

procedure TVideoForm.BeendenMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Weiter.Font.Color := clwindowtext;
  Beenden.Font.Color := clnavy;
end;

procedure TVideoForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Weiter.Font.Color := clwindowtext;
  Beenden.Font.Color := clwindowtext;
end;

procedure TVideoForm.FormShow(Sender: TObject);
begin
  weiter.setfocus;
  try
    AviPlayer.filename := directory+'Videos\Video.avi';
    AviPlayer.open;
    VideoPanel2.Width := AviPlayer.DisplayRect.Right;
    VideoPanel2.Height := AviPlayer.DisplayRect.Bottom;
    VideoPanel1.Width := VideoPanel2.width+(VideoPanel2.left*2);
    VideoPanel1.height := VideoPanel2.height+(VideoPanel2.top*2);
    AviPlayer.play;
  except
    VideoTimer.Tag := 1;
  end;
  if (EinstellungForm.CheckBoxVideo2.Checked) and (soundkarte) then
  begin
    WavePlayer.FileName:=directory+'Videos\Audio.wav';
    WavePlayer.Open;
    WavePlayer.Play;
    Play:=true;
  end;
  VideoTimer.enabled := true;
end;

procedure TVideoForm.FormCreate(Sender: TObject);
begin
  Weiter.Glyph.LoadFromFile(directory+'Bilder\OK.bmp');
  Beenden.Glyph.LoadFromFile(directory+'Bilder\Verlassen.bmp');
end;

procedure TVideoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MenuForm.close;
end;

procedure TVideoForm.FormHide(Sender: TObject);
begin
  VideoTimer.enabled := false;
end;

procedure TVideoForm.VideoTimerTimer(Sender: TObject);
begin
  if TTimer(Sender).Tag = 1 then
  begin
    weiter.Click;
  end;
  if (((EinstellungForm.checkboxvideo2.checked) and
    (WavePlayer.position=WavePlayer.length)) or
    not (EinstellungForm.checkboxvideo2.checked)) and
    (aviplayer.position=aviplayer.length) then
      TTimer(Sender).Tag := 1;
end;

end.

