unit DB_VModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FMX.dialogs, system.JSON, FireDAC.FMXUI.Wait;

//---------------------------------------------------------
// 테이블에서 조회한 데이터를 메인폼으로 넘겨줄 데이터 정의
type SAnsType = Record
   qCount : integer;
   sFd1, sFd2, sFd3, sFd4 : TStringList;
End;
//---------------------------------------------------------


type
  TDataModule1 = class(TDataModule)
    FDQuery1: TFDQuery;
    FDConnection1: TFDConnection;
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     function Select_All: SAnsType;
     function A_Query: string;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.FDConnection1BeforeConnect(Sender: TObject);
begin

  {$IFDEF MSWINDOWS}
  FDConnection1.Params.Values[ 'Database' ] := ExtractFilePath(ParamStr(0)) + '..\..\stest.db';
  {$ENDIF}

  {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  FDConnection1.Params.Values[ 'Database' ] :=                                //  StartUp\Library
           TPath.Combine( TPath.GetDocumentsPath(), 'stest.db');
  {$ENDIF}                                                                    // .\assets\internal

end;


function TDataModule1.Select_All() : SAnsType;
begin
  result.sFd1 := TStringList.Create;
  result.sFd2 := TStringList.Create;
  result.sFd3 := TStringList.Create;
  result.sFd4 := TStringList.Create;

  FDConnection1.Open;
  try
    FDQuery1.Close;
    FDQuery1.SQL.Clear;
    FDQuery1.SQL.Add( 'Select * from table1' );
    FDQuery1.Open;
    FDQuery1.First;

    // 조회한 데이터를 레코드에 저장.
    while Not FDQuery1.EOF do
    begin
      result.sFd1.Add( FDQuery1.FieldByName('field1').AsString );
      result.sFd2.Add( FDQuery1.FieldByName('field2').AsString );
      result.sFd3.Add( FDQuery1.FieldByName('field3').AsString );
      result.sFd4.Add( FDQuery1.FieldByName('field4').AsString );

      FDQuery1.Next;
      Inc( result.qCount );
    end;
    result.qCount := result.sFd1.Count;

  except
    on e: Exception do begin
      ShowMessage( e.Message );
    end;
  end;

  FDConnection1.Close;
end;



function TDataModule1.A_Query: string;
var
  JTopObj, JsubObj : TJSONObject;
  JArr  : TJSONArray;
  JPair : TJSONPair;

begin
  JTopObj := TJSONObject.Create;  // 메인 블럭 정의

  try
    FDConnection1.Open;

    try
      FDQuery1.Close;
      FDQuery1.SQL.Clear;
      FDQuery1.SQL.Add( 'Select * from table1' );
      FDQuery1.Open;
      FDQuery1.First;

      JArr :=  TJSONArray.Create;    // Json 배열 정의
      while Not FDQuery1.EOF do
      begin
        JsubObj := TJSONObject.Create;   // 각 항목 블럭

        JsubObj.AddPair( 'field1', FDQuery1.FieldByName('field1').AsString );
        JsubObj.AddPair( 'field2', FDQuery1.FieldByName('field2').AsString );
        JsubObj.AddPair( 'field3', FDQuery1.FieldByName('field3').AsString );
        JsubObj.AddPair( 'field4', FDQuery1.FieldByName('field4').AsString );

        JArr.AddElement( JsubObj );
        FDQuery1.Next;
      end;

      JPair := TJSONPair.Create( 'Items', JArr );                              // Items 항목 아래에 배열세트를 넣는다.
      JTopObj.AddPair( 'Count', TJSONNumber.Create( FDQuery1.RecordCount ) );  // 상단에 레코드 카운트 표시
      JTopObj.AddPair( JPair );                                                // 메인블럭에 Items 배열세트 넣음.

    except
      on e: Exception do begin
         result := e.Message;
      end;
    end;


  finally
    FDConnection1.Close;

    result := JTopObj.ToString;
    JTopObj.Free;
  end;

end;



end.
