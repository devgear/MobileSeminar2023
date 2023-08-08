unit FMUnitpas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,  System.IOUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TMForm = class(TForm)
    Image1: TImage;
    BT_Pre: TButton;
    BT_Next: TButton;
    Layout1: TLayout;
    Text_FName: TText;
    procedure FormShow(Sender: TObject);
    procedure BT_PreClick(Sender: TObject);
    procedure BT_NextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MForm: TMForm;

implementation

{$R *.fmx}
procedure TMForm.FormShow(Sender: TObject);
begin
 {$IFDEF MSWINDOWS}
    Image1.Bitmap.LoadFromFile(  '..\..\image\file1.jpg' );
 {$ENDIF}

 {$IF DEFINED(iOS) or DEFINED(ANDROID)}
    Image1.Bitmap.LoadFromFile( System.IOUtils.TPath.GetDocumentsPath() + PathDelim + 'file1.jpg' );
 {$ENDIF}
end;


procedure TMForm.BT_NextClick(Sender: TObject);
begin
 {$IF DEFINED(iOS) or DEFINED(ANDROID)}
    Image1.Bitmap.LoadFromFile( System.IOUtils.TPath.GetDocumentsPath() + PathDelim + 'file3.jpg' );
 {$ENDIF}
end;

procedure TMForm.BT_PreClick(Sender: TObject);
begin
 {$IF DEFINED(iOS) or DEFINED(ANDROID)}
    Image1.Bitmap.LoadFromFile( System.IOUtils.TPath.GetDocumentsPath() + PathDelim + 'file2.jpg' );
 {$ENDIF}
end;


end.
