{*******************************************************************************
* Class_AppKardSet.pas-����� ���������� � �������������� �������� ���������    *
*                                                                              *
* ��������� <ClientKARD>-����������� �������� (��) �� ����                     *
*                                                                              *
* ����������� - ������� ������ ������������ - ������� �������                  *
*     �������� >> 32-14| E-Mail:mikhail.sazonov@niitp.ru                       *
*     Copyright (C)�� ��� ������ �������� - ���� 2024                          *
*     ������ ������: 28.03.2024 12:08:07                                       *
*******************************************************************************}

unit Class_AppKardSet;

interface

uses Winapi.Windows, System.SysUtils, Controls, Classes;

type



{ TAppKardSet }
 TAppKardSet = class(TObject)
    private //���� ������
     fPathProg      : string; //������ ���� � ���������
     fPathLog       : string; //������ ���� � ��������  LOG
     fPathSett      : string; //������ ���� � �������� SETTING
     fPathHelp      : string; //������ ���� � �������� Help
     fPathRprt      : string; //������ ���� � �������� Report  �������� ���� ��������
     fPathTemp      : string; //������ ���� � �������� TEMP

     fhAppl         : HWND;   //���������� �����

    private //������ ����� ������
      function Get_PathProg : string; virtual; //������ ���� � ���������
      function Get_PathLog  : string; virtual; //������ ���� � ��������  LOG
      function Get_PathSett : string; virtual; //������ ���� � �������� SETTING
      function Get_PathHelp : string; virtual; //������ ���� � �������� HELP
      function Get_PathRprt : string; virtual; //������ ���� � �������� Report
      function Get_PathTemp : string; virtual; //������ ���� � �������� TEMP

      function Get_hAppl          : HWND  ; virtual; //���������� �����

    private //������ ����� ������
      procedure Set_PathProg (Value: string); virtual; //������ ���� � ���������
      procedure Set_PathLog  (Value: string); virtual; //������ ���� � ��������  LOG
      procedure Set_PathSett (Value: string); virtual; //������ ���� � �������� SETTING
      procedure Set_PathHelp (Value: string); virtual; //������ ���� � �������� Help
      procedure Set_PathRprt (Value: string); virtual; //������ ���� � �������� Report
      procedure Set_PathTemp (Value: string); virtual; //������ ���� � �������� TEMP

      procedure Set_hAppl        (Value: HWND);   virtual;

    protected

    public
    constructor Create; overload;
    constructor Create(LogDir, SetDir, TmpDir, HlpDir, ReportDir: string); overload;
    destructor  Destroy;  override;

//    published //�������� ������-��� �����������

    //������\������ ����� ������
    property PathProg: string read Get_PathProg  write Set_PathProg;
    property PathLog : string read Get_PathLog   write Set_PathLog;
    property PathSett: string read Get_PathSett  write Set_PathSett;
    property PathHelp: string read Get_PathHelp  write Set_PathHelp;
    property PathRprt: string read Get_PathRprt  write Set_PathRprt;
    property PathTemp: string read Get_PathTemp  write Set_PathTemp;

    property hAppl: HWND read Get_hAppl  write Set_hAppl;

    {++++++++++++++++++ ������ ������ +++++++++++++++++++++++++++++++++++++++++++++}
    //���������� ����� ������ ������ �������, �����������
    procedure Assign(Source: TAppKardSet);

    //��������� ����� ������ ������ �������, �����������
    //���� OldPrm = NewOpm ����� FALSE, OldPrm <> NewOpm ����� TRUE
    function ComparePrm(OldPrm: TAppKardSet): Boolean;

    //������ �� ������
    function LoadFromIniFile(const fIniName: TFileName): TAppKardSet;
    //���������� �� ������
    procedure SaveInIniFile(const fIniName: TFileName);

  end;


implementation

uses
      IniFiles,
      ResStr_ForClass, ResStr_ClientKard, ResStr_GlobalResurs
      ;


{ TAppKardSet }

constructor TAppKardSet.Create;
begin
 //������ ���� � ���������
 fPathProg := IncludeTrailingPathDelimiter(ExtractFilePath(//���� � ���������
                                           GetModuleName(HInstance)));
 //������ ���� � ��������  LOG
 fPathLog  := IncludeTrailingPathDelimiter(PathProg + DirLog);//������ ���� ��������  LOG
 //������ ���� � �������� SETTING
 fPathSett := IncludeTrailingPathDelimiter(PathProg + DirSett);//������ ���� �������� SETTING
 //������ ���� � �������� REPORT
 fPathRprt := IncludeTrailingPathDelimiter(PathProg + DirReport);//������ ���� �������� REPORT
 //������ ���� � �������� HELP
 fPathHelp := IncludeTrailingPathDelimiter(PathProg + DirHlp);//������ ���� �������� HELP
 //������ ���� � �������� TEMP
 fPathTemp := IncludeTrailingPathDelimiter(PathProg + DirTmp);//������ ���� �������� TEMP
 fhAppl         := 0;  //���������� �����
end;

constructor TAppKardSet.Create(LogDir, SetDir, TmpDir, HlpDir,
                                ReportDir: string);
begin
 fPathProg := ''; //������ ���� � ���������
 fPathLog  := ''; //������ ���� � ��������  LOG
 fPathSett := ''; //������ ���� � �������� SETTING
 fPathRprt := ''; //������ ���� � �������� REPORT
 fPathHelp := ''; //������ ���� � �������� HELP
 fPathTemp := ''; //������ ���� � �������� TEMP
end;

destructor TAppKardSet.Destroy;
begin

  inherited;
end;

procedure TAppKardSet.Assign(Source: TAppKardSet);
begin //���������� ����� ������ ������ �������, �����������
 if Source is TAppKardSet then
   begin
     PathProg       := (Source as TAppKardSet).PathProg; //������ ���� � ���������
     PathLog        := (Source as TAppKardSet).PathLog;  //������ ���� � ��������  LOG
     PathSett       := (Source as TAppKardSet).PathSett; //������ ���� � �������� SETTING
     PathRprt       := (Source as TAppKardSet).PathRprt; //������ ���� � �������� REPORT
     PathHelp       := (Source as TAppKardSet).PathHelp; //������ ���� � �������� HELP
     PathTemp       := (Source as TAppKardSet).PathTemp; //������ ���� � �������� TEMP
     hAppl          := (Source as TAppKardSet).hAppl;    //���������� �����
   end
   else
   Exception.Create(ErrClssCopy);

end;

function TAppKardSet.ComparePrm(OldPrm: TAppKardSet): Boolean;
begin
 if (OldPrm.PathProg <> Self.PathProg) or //������ ���� � ���������
    (OldPrm.PathLog  <> Self.PathLog)  or //������ ���� � ��������  LOG
    (OldPrm.PathSett <> Self.PathSett) or //������ ���� � �������� SETTING
    (OldPrm.PathRprt <> Self.PathRprt) or //������ ���� � �������� REPORT
    (OldPrm.PathHelp <> Self.PathHelp) or //������ ���� � �������� HELP
    (OldPrm.PathTemp <> Self.PathTemp) or //������ ���� � �������� TEMP
    (OldPrm.hAppl    <> Self.hAppl)       //���������� �����
    then
        Result:= True  //�� ����������
   else
     Result:= False;  //�� �� ����������
//���� OldPrm = NewPrm ����� FALSE, OldPrm <> NewPrm ����� TRUE
end;

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  + ������ ����� ������                                                       +
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)

function TAppKardSet.Get_hAppl: HWND;
begin
 Result := fhAppl;
end;

function TAppKardSet.Get_PathHelp: string;
begin
 Result := fPathHelp;
end;

function TAppKardSet.Get_PathLog: string;
begin
 Result := fPathLog;
end;

function TAppKardSet.Get_PathProg: string;
begin
 Result := fPathProg;
end;

function TAppKardSet.Get_PathRprt: string;
begin
 Result := fPathRprt;
end;

function TAppKardSet.Get_PathSett: string;
begin
 Result := fPathSett;
end;

function TAppKardSet.Get_PathTemp: string;
begin
 Result := fPathTemp;
end;


{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 + ������ ������ ������                                                      +
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*}

function TAppKardSet.LoadFromIniFile(const fIniName: TFileName): TAppKardSet;
begin

end;


procedure TAppKardSet.SaveInIniFile(const fIniName: TFileName);
begin

end;


{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 + ������ ������ �����                                                            +
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*}


{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 + ������ ����� ������                                                       +
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

procedure TAppKardSet.Set_hAppl(Value: HWND);
begin
 fhAppl := Value;
end;

procedure TAppKardSet.Set_PathLog(Value: string);
begin
 fPathLog := Value;
end;

procedure TAppKardSet.Set_PathProg(Value: string);
begin //������ ���� � ���������
 fPathProg := Value;
end;

procedure TAppKardSet.Set_PathRprt(Value: string);
begin
 fPathRprt := Value;
end;

procedure TAppKardSet.Set_PathSett(Value: string);
begin
 fPathSett := Value;
end;

procedure TAppKardSet.Set_PathHelp(Value: string);
begin
 fPathHelp := Value;
end;

procedure TAppKardSet.Set_PathTemp(Value: string);
begin
 fPathTemp := Value;
end;

end.


