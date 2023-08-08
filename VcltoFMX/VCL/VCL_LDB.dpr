program VCL_LDB;

uses
  Vcl.Forms,
  VCL_Main in 'VCL_Main.pas' {FormVCL},
  DB_VModule in 'DB_VModule.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormVCL, FormVCL);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
