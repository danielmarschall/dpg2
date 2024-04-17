{
////////////////////////////////////////////////////////////////////////////////
/ Jazarsoft CoolGauge                                                          /
////////////////////////////////////////////////////////////////////////////////
/                                                                              /
/ VERSION      : 1.2                                                           /
/ AUTHOR       : James Azarja                                                  /
/ CREATED      : 10 July 2000                                                  /
/ CREATED      : 26 April 2001                                                 /
/ WEBSITE      : http://www.jazarsoft.com/                                     /
/ SUPPORT      : support@jazarsoft.com                                         /
/ BUG-REPORT   : bugreport@jazarsoft.com                                       /
/ COMMENT      : comment@jazarsoft.com                                         /
/ LEGAL        : Copyright (C) 2000-2001 Jazarsoft.                            /
/                                                                              /
////////////////////////////////////////////////////////////////////////////////
/ NOTE         :                                                               /
/                                                                              /
/ This code may be used and modified by anyone so long as  this header and     /
/ copyright  information remains intact.                                       /
/                                                                              /
/ The code is provided "as-is" and without warranty of any kind,               /
/ expressed, implied or otherwise, including and without limitation, any       /
/ warranty of merchantability or fitness for a  particular purpose.            /
/                                                                              /
/ In no event shall the author be liable for any special, incidental,          /
/ indirect or consequential damages whatsoever (including, without             /
/ limitation, damages for loss of profits, business interruption, loss         /
/ of information, or any other loss), whether or not advised of the            /
/ possibility of damage, and on any theory of liability, arising out of        /
/ or in connection with the use or inability to use this software.             /
/                                                                              /
////////////////////////////////////////////////////////////////////////////////
}
{$WARNINGS OFF}
{$HINTS OFF}
unit CoolGauge;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  tCoolGaugeStyle = (sSolid,sDithered);
  
  TCoolGauge = class(TCustomControl)
  private
   Updategradient  : Boolean;
   FMinValue       : Integer;
   FMaxValue       : Integer;
   FCurValue       : Integer;
   FBackColor      : tColor;
   FBorderStyle    : tBorderStyle;
   FForeColor1     : tColor;
   FForeColor2     : tcolor;
   FStyle          : tCoolGaugeStyle;
   FText           : String;
   FFrame          : Boolean;
   Buffer          : tBitmap;
   Procedure SetMinValue(Value:Integer);
   Procedure SetMaxValue(Value:Integer);
   Procedure SetCurValue(Value:Integer);
   Procedure SetBackColor(color:tColor);
   Procedure SetForeColor1(color:tColor);
   Procedure SetForeColor2(color:tColor);
   Procedure SetBorderStyle(Value: TBorderStyle);
   procedure SetStyle(Style:tCoolGaugeStyle);
   Procedure SetText(Text:String);
   Procedure SetFrame(Value:Boolean);
  protected
   procedure Paint; override;
  public
   constructor Create(AOwner: TComponent); override;
   Destructor  Destroy;override;
  published
    property Top;
    property Left;
    property Align;
    property Width;
    property Height;
    property Visible;
    property Hint;
    property ShowHint;
    property Font;
    property Cursor;
    property Name;

    property BorderStyle: TBorderStyle read FBorderStyle    write SetBorderStyle default bsSingle;
    property MinValue   : Integer      read FMinValue       Write SetMinValue   default 0;
    property MaxValue   : Integer      read FMaxValue       Write SetMaxValue   default 100;
    property Progress   : integer      read FCurValue       Write SetCurValue   default 0;
    property BackColor  : tColor       read FBackColor      Write SetBackColor  default clWhite;
    property ForeColor1 : tColor       read FForeColor1     Write SetForeColor1 default clBlue;
    property ForeColor2 : tColor       read FForeColor2     Write SetForeColor2 default clRed;
    property Style 	: tCoolGaugeStyle read FStyle       Write SetStyle      default sDithered;
    property Text 	: String       read FText           Write SetText;
    property Frame      : boolean      Read FFrame          Write SetFrame      default True;
  end;

procedure Register;

implementation

Procedure TCoolGauge.SetFrame(Value:Boolean);
Begin
 If FFrame<>Value then
 Begin
   FFrame:=Value;
   If Value then
     ControlStyle := ControlStyle + [csFramed] else
     ControlStyle := ControlStyle - [csFramed];
   Refresh;
 End;
End;

Procedure TCoolGauge.SetMinValue(Value:Integer);
Begin
 if Value <> FMinValue then
 begin
   if Value < FMaxValue then FMinValue := Value;
   if FCurValue < Value then FCurValue := Value;
   Refresh;
 end;
End;

Procedure TCoolGauge.SetMaxValue(Value:Integer);
Begin
 if Value <> FMaxValue then
 begin
   if Value > FMinValue then FMaxValue := Value;
   if FCurValue > Value then FCurValue := Value;
   refresh;
 end;
End;

Procedure TCoolGauge.SetCurValue(Value:Integer);
var
 temp : integer;
Begin
 temp:=Round((Width/FMaxValue)*FCurValue);
 if Value <> FCurValue then
 begin
  if (Value >= FMinValue) and
     (Value <= FMaxValue) then FCurValue := Value;
  if ((Width/FMaxValue)*FCurValue) <>temp then
   refresh;
 end;
End;

Procedure TCoolGauge.SetBackColor(color:tColor);
Begin
 if Color <> FBackColor then
 begin
  FBackColor:=Color;
  refresh;
 end;
End;

Procedure TCoolGauge.SetForeColor1(color:tColor);
Begin
 if Color <> FForeColor1 then
 begin
  FForeColor1:=Color;
  Updategradient:=True;
  Refresh;
 end;
End;

Procedure TCoolGauge.SetForeColor2(color:tColor);
Begin
 if Color <> FForeColor2 then
 begin
  FForeColor2:=Color;
  Updategradient:=True;
  Refresh;
 end;
End;

procedure TCoolGauge.SetBorderStyle(Value: TBorderStyle);
begin
 if Value <> FBorderStyle then
 begin
  FBorderStyle := Value;
  Refresh;
 end;
end;

procedure TCoolGauge.SetStyle(Style:tCoolGaugeStyle);
Begin
 if Style <> FStyle then
 begin
  FStyle := Style;
  Updategradient:=True;
  Refresh;
 end;
End;

Procedure TCoolGauge.Settext(Text:String);
Begin
 if Text <> FText then
 begin
  Ftext := Text;
  refresh;
 end;
End;


constructor TCoolGauge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csFramed, csOpaque];
  FMinValue := 0;
  FMaxValue := 100;
  FCurValue := 0;
  FFrame:=True;
  FBackColor:= clWhite;
  FForeColor1:= clBlue;
  FForeColor2:= clRed;
  FBorderStyle:=bsSingle;
  FStyle:=sDithered;
  FText:='%d%%';
  Width := 100;
  Height := 20;
  Buffer:=tBitmap.Create;
  buffer.width:=1;
  buffer.height:=1;
end;

Destructor TCoolGauge.Destroy;
begin
  buffer.free;
  inherited Destroy;
end;

procedure TCoolGauge.Paint;
type
 tRGB = Record
         R,G,B : byte;
        End; 

Function ColorToRGB(Color:TColor):TRGB;
Begin
 Result.R:=GetRValue(Color);
 Result.G:=GetGValue(Color);
 Result.B:=GetBValue(Color);
End;
        
var
 X,Y        : Integer;
 Str        : String;
 Percent    : Integer;
 Rect       : tRect;
 SourceRGB,
 DestRGB,
 CurrRGB    : tRGB;
 RMode      ,
 GMode      ,
 BMode      : Byte;
 ourrect    : tRect;
 Bitmap     : tbitmap;
 Textbuf    : tBitmap;
 Scale      : real;
 PostoStop  : Integer;
begin
 If (buffer.width<>width) or (buffer.height<>height) or
    UpdateGradient then
 begin
  UpdateGradient:=False;
  buffer.free;
  buffer:=tbitmap.create;
  buffer.width:=width;
  buffer.height:=height;

  With Buffer.Canvas do
  Begin
   SourceRGB:=ColorToRGB(FForeColor1);
   DestRGB:=ColorToRGB(FForeColor2);
   CurrRGB:=SourceRGB;

   If FStyle=sDithered then
   Begin
    If SourceRGB.R > DestRGB.R then RMode:=2 else { Dec }
    If SourceRGB.R < DestRGB.R then RMode:=1;     { Inc }
    If SourceRGB.G > DestRGB.G then GMode:=2 else { Dec }
    If SourceRGB.G < DestRGB.G then GMode:=1;     { Inc }
    If SourceRGB.B > DestRGB.B then BMode:=2 else { Dec }
    If SourceRGB.B < DestRGB.B then BMode:=1;     { Inc }

    Rect.top:=0;
    Rect.bottom:=Height;

    For X:=0 to 255 do
    begin
     Rect.Left   := Round((X)  * width div 256);
     Rect.right  := round((X+1)* width div 256);

     Begin
      If CurrRGB.R <> DestRGB.R then
       If RMode = 1 then CurrRGB.R:=CurrRGB.R+1 else CurrRGB.R:=CurrRGB.R-1;
      If CurrRGB.G <> DestRGB.G then
       If GMode = 1 then CurrRGB.G:=CurrRGB.G+1 else CurrRGB.G:=CurrRGB.G-1;
      If CurrRGB.B <> DestRGB.B then
       If BMode = 1 then CurrRGB.B:=CurrRGB.B+1 else CurrRGB.B:=CurrRGB.B-1;
       brush.color:=tcolor(rgb(CurrRGB.R,CurrRGB.G,CurrRGB.B));
      End;
     fillrect(rect);
    end;
   End else
   If FStyle=sSolid then
   Begin
    Rect.Left :=0;
    Rect.Right:=Width;
    Rect.Top:=0;
    Rect.Bottom:=Height;
    brush.color:=FForeColor1;
    fillrect(rect);
   End;
  end;
 End;

 bitmap:=tbitmap.create;
 bitmap.width:=width;
 bitmap.height:=height;
 bitmap.Canvas.Brush.Color:=FBackColor;
 bitmap.Canvas.FillRect(clientrect);
 bitblt(bitmap.canvas.Handle,0,0,Round((Width/FMaxValue)*FCurValue),height,
        buffer.canvas.handle,0,0,srcCopy);

 If FText<>'' then
 Begin
  Percent:=round((FCurValue / FmaxValue) * 100);
  Str:=format(Ftext,[Percent]);
  Bitmap.Canvas.Brush.Color:=Font.Color;
  Bitmap.Canvas.Brush.Style:=bsClear;
  Bitmap.Canvas.Font:=Font;
  Bitmap.Canvas.textOut((Width-Bitmap.canvas.TextWidth(Str)) div 2,(Height-Bitmap.canvas.TextHeight(Str)) div 2,Str);
 End;

 if FBorderStyle = bsSingle then
 Begin
  bitmap.Canvas.Brush.Color:=Font.Color;
  bitmap.Canvas.FrameRect(clientRect);
 End;

 bitblt(canvas.handle,0,0,width,height,bitmap.canvas.handle,0,0,SrcCopy);
 bitmap.free;
end;

procedure Register;
begin
  RegisterComponents('Jazarsoft', [TCoolGauge]);
end;

end.
