program FMX_DB;

uses
  System.StartUpCopy,
  FMX.Forms,
  MLocalDB in 'MLocalDB.pas' {MForm},
  DB_VModule in 'DB_VModule.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMForm, MForm);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
