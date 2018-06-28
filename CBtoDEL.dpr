program CBtoDEL;

uses
  Vcl.Forms,
  CBtoDELunit in 'CBtoDELunit.pas' {FormCBtoDEL};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCBtoDEL, FormCBtoDEL);
  Application.Run;
end.
