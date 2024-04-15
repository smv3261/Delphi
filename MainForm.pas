unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.ImageList, System.Actions,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ImgList,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ComCtrls,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.PlatformDefaultStyleActnCtrls,
  FormMonitor
  ;

type
  TForm1 = class(TForm)
    mM1: TMainMenu;
    mniExit: TMenuItem;
    mniN1: TMenuItem;
    mniN2: TMenuItem;
    mniN3: TMenuItem;
    mniN11: TMenuItem;
    mniN21: TMenuItem;
    mniN31: TMenuItem;
    mniN41: TMenuItem;
    mniHelp: TMenuItem;
    ImgLstMain: TImageList;
    ActMgrMain: TActionManager;
    actExitProg: TAction;
    ActTlbrMain: TActionToolBar;
    actHelp: TAction;
    actAbout: TAction;
    mniAbout: TMenuItem;
    mniN4: TMenuItem;
    procedure ActExit_Execute(Sender: TObject);
    procedure actAbout_Execute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Class_AppKardSet, Class_SetProg, ResStr_ClientKard;

procedure TForm1.actAbout_Execute(Sender: TObject);
begin //Вывод информации о Программе...
 ShowMessage('Вывод информации о Программе...');
end;

procedure TForm1.ActExit_Execute(Sender: TObject);
begin // Закрыть программу и выйти
 Close;
end;

var
    AppKardSet: TAppKardSet; //
    SetProg   : TSetProg;

initialization
  AppKardSet := TAppKardSet.Create; // Создаем класс настроек
  AppKardSet.LoadFromIniFile('');   // Загружаем настройки
 SetProg    := TSetProg.Create;
finalization
 FreeAndNil(AppKardSet);
 FreeAndNil(SetProg);

end.
