program CompareSpeed;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  hash in 'hash.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
