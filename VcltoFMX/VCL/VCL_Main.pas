unit VCL_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TFormVCL = class(TForm)
    ListView1: TListView;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormVCL: TFormVCL;

implementation

Uses
  DB_VModule;       // Database 모듈 유닛 사용 선언


{$R *.dfm}

procedure TFormVCL.Button1Click(Sender: TObject);
var
  sdata : SAnsType;  // DBModule 유닛에 선언된 쿼리데이터 저장 레코드
  i: Integer;
begin
  sdata :=  DataModule1.Select_All(); // 데이터 조회 하여 전송 받음

  ListView1.Items.Clear;
  for i := 0 to sdata.qCount - 1 do
   begin
     with ListView1.Items.Add do begin
       Caption :=  sdata.sFd1[ i ] + #32 + sdata.sFd2[ i ] + #32 + sdata.sFd3[ i ];
       SubItems.Add( sdata.sFd4[ i ] );
   end;
  end;

  Memo1.Lines.Add( sdata.qCount.ToString );
end;



procedure TFormVCL.Button2Click(Sender: TObject);
var
  sss : string;
begin
  sss :=  DataModule1.A_Query;

  Memo1.Lines.Add( sss  );
end;

end.
