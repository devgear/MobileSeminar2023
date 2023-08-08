program FileDist;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMUnitpas in 'FMUnitpas.pas' {MForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMForm, MForm);
  Application.Run;
end.
