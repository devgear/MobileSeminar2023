unit MLocalDB;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Objects;

type
  TMForm = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    ListView1: TListView;
    Label1: TLabel;
    Rectangle1: TRectangle;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MForm: TMForm;

implementation

Uses
  DB_VModule;       // Database 모듈 유닛 사용 선언

{$R *.fmx}

procedure TMForm.Button1Click(Sender: TObject);
var
  sdata : SAnsType;  // DBModule 유닛에 선언된 쿼리데이터 저장 레코드
  i: Integer;
  LItem: TListViewItem;
begin
  sdata :=  DataModule1.Select_All(); // 데이터 조회 하여 전송 받음

  ListView1.Items.Clear;
  ListView1.BeginUpdate();
  for i := 0 to sdata.qCount - 1 do
  begin
     LItem := ListView1.Items.Add;
     LItem.Text   := sdata.sFd1[ i ] + #32 + sdata.sFd2[ i ] + #32 + sdata.sFd3[ i ];;
     LItem.Detail := sdata.sFd4[ i ];
  end;
  ListView1.EndUpdate();

  Memo1.Lines.Add( sdata.qCount.ToString );
end;

procedure TMForm.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Add( DataModule1.A_Query );
end;

end.
