program CBtoDEL;

uses
  Vcl.Forms,
  CBtoDELunit in 'CBtoDELunit.pas' {FormCBtoDEL},
  dgridlib in '..\UTILS\dgridlib.pas',
  utild in '..\UTILS\utild.pas',
  define in '..\UTILS\define.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCBtoDEL, FormCBtoDEL);
  Application.Run;
end.
