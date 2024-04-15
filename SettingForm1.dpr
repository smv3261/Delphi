program SettingForm1;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  Class_AppKardSet in 'Classes\Class_AppKardSet.pas',
  ResStr_ForClass in 'Resource_String\ResStr_ForClass.pas',
  Class_SetProg in 'Classes\Class_SetProg.pas',
  ResStr_ClientKard in 'Resource_String\ResStr_ClientKard.pas',
  ResStr_GlobalResurs in 'Resource_String\ResStr_GlobalResurs.pas',
  FormMonitor in 'FormsPrj\MonitorForm\FormMonitor.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
