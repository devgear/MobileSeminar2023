unit PMUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,  System.Permissions,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.DialogService,
  FMX.Platform;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    BT_PNumer: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BT_PNumerClick(Sender: TObject);
  private
    procedure DisplayRationale(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
    procedure Loacation_PermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
    procedure Camera_PermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
    procedure PNumber_PermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);


    { Private declarations }
  public
    { Public declarations }
    FPermissionLoacation, FPermissionCamera, FPermissionPNumber : string;
  end;

var
  Form1: TForm1;

implementation

uses
{$IFDEF ANDROID}
   Androidapi.JNI.Os,
   Androidapi.Helpers,
   AndroidApi.Jni.JavaTypes,

   Androidapi.JNI.Telephony,  Androidapi.JNI.GraphicsContentViewText, Androidapi.JNIBridge;  // for 전화번호
{$ENDIF}


{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FPermissionLoacation := JStringToString(TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION );
  FPermissionCamera    := JStringToString(TJManifest_permission.JavaClass.CAMERA );
  FPermissionPNumber   := JStringToString(TJManifest_permission.JavaClass.READ_PHONE_NUMBERS );
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  PermissionsService.RequestPermissions([FPermissionLoacation], Loacation_PermissionRequestResult, DisplayRationale);
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
  PermissionsService.RequestPermissions([FPermissionCamera], Camera_PermissionRequestResult, DisplayRationale);
end;


procedure TForm1.Button4Click(Sender: TObject);
begin
  PermissionsService.RequestPermissions([FPermissionPNumber], PNumber_PermissionRequestResult, DisplayRationale);
end;

//----------------------------------------------------------------------------------------------------------------------------------
procedure TForm1.DisplayRationale(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
var
  I: Integer;
  RationaleMsg: string;
begin
  for I := 0 to High(APermissions) do
  begin
    if APermissions[I] = FPermissionLoacation then
      RationaleMsg := RationaleMsg + 'The app needs to access the Permission Location' + SLineBreak + SLineBreak

    else if APermissions[I] = FPermissionCamera then
      RationaleMsg := RationaleMsg + 'The app needs to access the Permission Camera' + SLineBreak + SLineBreak

    else if APermissions[I] = FPermissionPNumber then
      RationaleMsg := RationaleMsg + 'The app needs to access the Permission Phone Number' + SLineBreak + SLineBreak;
  end;

  // Show an explanation to the user *asynchronously* - don't block this thread waiting for the user's response!
  // After the user sees the explanation, invoke the post-rationale routine to request the permissions
  TDialogService.ShowMessage(RationaleMsg,
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc;
    end)
end;


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------
procedure TForm1.Loacation_PermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
begin
  // 3 permissions involved: CAMERA, READ_EXTERNAL_STORAGE, WRITE_EXTERNAL_STORAGE
//  if (Length(AGrantResults) = 3) and
//     (AGrantResults[0] = TPermissionStatus.Granted) and
//     (AGrantResults[1] = TPermissionStatus.Granted) and
//     (AGrantResults[2] = TPermissionStatus.Granted) then

  if ( Length(AGrantResults) = 1) and
     (AGrantResults[0] = TPermissionStatus.Granted) then
     TDialogService.ShowMessage('Location permissions OK ' )
  else
    TDialogService.ShowMessage('The required permissions are not granted');
end;


procedure TForm1.Camera_PermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
begin
  if ( Length(AGrantResults) = 1) and
     (AGrantResults[0] = TPermissionStatus.Granted) then
    TDialogService.ShowMessage('Camera permissions OK ' )
  else
    TDialogService.ShowMessage('The required permissions are not granted');
end;


procedure TForm1.PNumber_PermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
begin
  if ( Length(AGrantResults) = 1) and
     (AGrantResults[0] = TPermissionStatus.Granted) then
    TDialogService.ShowMessage('Phone Number permissions OK ' )
  else
    TDialogService.ShowMessage('The required permissions are not granted');
end;


//**********************************************
// 사용자 전화번호 알아내기 샘플
procedure TForm1.BT_PNumerClick(Sender: TObject);
var
  obj : JObject;
  PhoneManager : JTelephonyManager;
  PhoneNumber : string;
begin
  obj := SharedActivityContext.getSystemService(TJContext.JavaClass.TELEPHONY_SERVICE);
  PhoneManager := TJTelephonyManager.Wrap((obj as ILocalObject).GetObjectID);
  PhoneNumber := JStringToString(PhoneManager.getLine1Number);
  ShowMessage( PhoneNumber );
end;




end.
