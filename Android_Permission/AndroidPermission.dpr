program AndroidPermission;

uses
  System.StartUpCopy,
  FMX.Forms,
  PMUnit in 'PMUnit.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
