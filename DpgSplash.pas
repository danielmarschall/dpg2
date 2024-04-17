/////////////////////////////////////////////////////////
//  * Der Panzergeneral 2 - Version 1.5 - Quellcode *  //
//  -------------------------------------------------  //
//  Entwicklung: Michael Düpjohann & Daniel Marschall. //
//  -------------------------------------------------  //
//  (C)Copyright 2000 - 2005 ViaThinkSoft.             //
//  Alle Rechte vorbehalten.                           //
/////////////////////////////////////////////////////////

unit DpgSplash;

interface                                              

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, StdCtrls, ExtCtrls, CoolGauge;

type
  TSplashForm = class(TForm)
    Hintergrund: TImage;
    Bevel: TBevel;
    NameLabel: TLabel;
    WaitLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  public
    { VCL-Ersatz }
    ProgressGge: tcoolgauge;
  end;

var
  SplashForm: TSplashForm;

implementation

uses
  DPGGlobal, DpgGame;

{$R *.DFM}

procedure TSplashForm.FormShow(Sender: TObject);
begin
  NameLabel.caption := NameLabel.caption + ' ' + ProgrammVersion;
  WaitLabel.caption := WaitLabel.caption + ' ' + ProgrammVersion;
  Hintergrund.Picture.LoadFromFile(directory+'Bilder\Sterne.bmp');
end;

procedure TSplashForm.FormCreate(Sender: TObject);
begin
  ProgressGge := tcoolgauge.Create(self);
  ProgressGge.Parent := self;
  ProgressGge.ForeColor1 := clRed;
  ProgressGge.ForeColor2 := clMaroon;
  ProgressGge.Left := 8;
  ProgressGge.Top := 132;
  ProgressGge.Width := 313;
  ProgressGge.Height := 28;
  ProgressGge.MaxValue := 100;
  ProgressGge.MinValue := 0;
  ProgressGge.Progress := ProgressGge.MinValue;
  ProgressGge.BackColor := $00DFDFDF;
end;

procedure TSplashForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ProgressGge);
end;

end.

