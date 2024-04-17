/////////////////////////////////////////////////////////
//  * Der Panzergeneral 2 - Version 1.5 - Quellcode *  //
//  -------------------------------------------------  //
//  Entwicklung: Michael Düpjohann & Daniel Marschall. //
//  -------------------------------------------------  //
//  (C)Copyright 2000 - 2005 ViaThinkSoft.             //
//  Alle Rechte vorbehalten.                           //
/////////////////////////////////////////////////////////

unit DPGUnit3;
                                                                         
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  THilfeForm = class(TForm)
    Panel: TPanel;
    CaptionLabel: TLabel;
    weiter: TBitBtn;
    TextMemo: TMemo;
    procedure WeiterClick(Sender: TObject);
    procedure weiterMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  HilfeForm: THilfeForm;

implementation

uses
  DPGGlobal, DPGUnit2, DPGUnit6;

{$R *.DFM}

procedure THilfeForm.WeiterClick(Sender: TObject);
begin
  weiter.font.color := clwindowtext;
  SpielForm.setfocus;
end;

procedure THilfeForm.weiterMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  weiter.font.color := clnavy;
end;

procedure THilfeForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  weiter.font.color := clwindowtext;
end;

procedure THilfeForm.FormShow(Sender: TObject);
begin
  weiter.setfocus;
end;

procedure THilfeForm.FormCreate(Sender: TObject);
begin
  HilfeForm.Weiter.Glyph.LoadFromFile(directory+'Bilder\OK.bmp');
end;

procedure THilfeForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SpielForm.dxtimer.enabled := true;
end;

end.

