{*******************************************************************************
* Class_SetProg.pas-����� ���������� � �������������� �������� ���������       *
*                                                                              *
* ��������� <SettingForm1>-����������� �������� (��) �� ����                   *
*                                                                              *
* ����������� - ������� ������ ������������ - ������� �������                  *
*     �������� >> 32-14| E-Mail:mikhail.sazonov@niitp.ru                       *
*     Copyright (C)�� ��� ������ �������� - ������ 2024                        *
*     ������ ������: 10.04.2024 11:01:36                                       *
*******************************************************************************}

unit Class_SetProg;

interface

uses IniFiles;

const
//     cUNC: Set of Char = ['\', '/'];//������� �������� ����
     MAX_Frozen   = 100;//��� ����� ������������ ������ ������� ����� <= 100
     MAX_LogLevel = 3;  //��� ����� ������� ����������� ������� � 1
     DefDelay     = 15; //����� �������� ������������ TSK_INP � [���] �� ���������
     MaxDelay     = 150;//MAX ����� �������� ������������ TSK_INP � [���]
     MaxFileSize  = 10000;//��� ������ ������ ��� ��������� ������/�����������

resourcestring

{+++++++++++ ����� ������ �������� �������� +++++++++++++++++++++++++++++++++++}
 iSetNew  = 'SetProg.INI';     //��� INI ����� ����� �������� SetProg
 iSetOld  = 'SetProgOld.INI';  //��� INI ����� ������ �������� SetProg

 AppSmess = 'SMES-XP V.3.5';   //��� ���� ��������� SMES_XP

{$WARNINGS ON}
{$WARN SYMBOL_DEPRECATED ON}

type
  //��������� �� ��������� �������� ���������
//  TMsgChngPrg= procedure(Sender: TObject; Prm: Integer) of object;

{ TSetProg }

  TSetProg = class(TObject)//��������� ��������� � ��������
   private
    fAPageIndex     : Integer;//�������� ��������
    fLogLevel       : Integer;//������� ����������� ���������
    fLogOnOff       : Boolean;//�������� � ���� ���/����.
    fMnMzOnOff      : Boolean;//������� ����������� � ����
    fShowErr        : Boolean;//���������� ������ �������������
    fAutoDelLog     : Boolean;//��������� �������. �������� ���-�����
    fAutoDelArh     : Boolean;//��������� �������. �������� �������� ������ ������
    fRewriteLog     : Boolean;//��������� ���������� LOG-�����
    fAutoStartMon   : Boolean;//��������� �������������� ������ �������� ��������
    fDelayInp       : Integer;//����� �������� ������������ TSK_INP � [���]
    fOldLogDay      : Integer;//������� ���-����� ������� ����
    fOldArhDay      : Integer;//������� �������� ����� ������ ������� ����
    fSizeMax        : Integer;//��� ������ ������ ��� ��������� ������/�����������
    fDirProg        : string; //������ ��� �������� ���������
    fCommandDir     : string; //������ ��� ������ �������� ��� INPUT|WORK|OUT
    fDirInp         : string; //������ ��� ��������� ��������
    fDirWork        : string; //������ ��� �������� ��������
    fDirOut         : string; //������ ��� ��������� ��������
    fDirExprt       : string; //������ ��� �������� ��� ��������
    fDirArchivCmd   : string; //������ ��� �������� ������ ������
    fDirExprtNet    : string; //������� ��� �������� ��������
    fDirReport      : string; //������ ��� �������� Report 
    fNameModul      : string; //������ ��� ������������ ������
    fVersion        : string; //������ �����
    fNameFileLog    : string; //������ ��� ���-�����
    fNameFileReport : string; //������ ��� ����� ������
    fAppFullName    : string; //������ ��� ����� e:\...Viewer\Smes_XP.exe
    fAppWndCapt     : string; //��� ��������� ���� Smes_XP (SMES-XP V.3.5)
    fAppProcName    : string; //��� �������� ���� Smes_XP
    fAppAutoClose   : Boolean;//������������� ��������� ����������, ��� ������ �� �������� ���������
    fLstOnOff       : Boolean;//����� �������� �� � �������
    
   private//������ �������� ����� - �������� ������ ������
    function Get_APageIndex  : Integer; virtual;//�������� ��������
    function Get_LogLevel    : Integer; virtual;//������� ����������� ���������
    function Get_LogOnOff    : Boolean; virtual;//�������� � ���� ���/����.
    function Get_MnMzOnOff   : Boolean; virtual;//������� ����������� � ����
    function Get_ShowErr     : Boolean; virtual;//���������� ������ �������������
    function Get_AutoDelLog  : Boolean; virtual;//��������� �������. �������� ���-�����
    function Get_AutoDelArh  : Boolean; virtual;//��������� �������. �������� �������� ������ ������ 
    function Get_RewriteLog  : Boolean; virtual;//��������� ���������� LOG-�����
    function Get_AutoStartMon: Boolean; virtual;//��������� �������������� ������ �������� ��������
    function Get_DelayInp    : Integer; virtual;//����� �������� ������������ TSK_INP � [���]
    function Get_OldArhDay   : Integer; virtual;//������� �������� ����� ������ ������� ����
    function Get_OldLogDay   : Integer; virtual;//������� ���-����� ������� ����
    function Get_FileSizeMax : Integer; virtual;//��� ������ ������ ��� ��������� ������/�����������
    function Get_DirProg     : string;  virtual;//������ ��� �������� ���������
    function Get_CommandDir  : string;  virtual;//������ ��� ������ �������� ��� INPUT|WORK|OUT
    function Get_DirInp      : string;  virtual;//������ ��� ��������� ��������
    function Get_DirWork     : string;  virtual;//������ ��� �������� ��������
    function Get_DirOut      : string;  virtual;//������ ��� ��������� ��������
    function Get_DirExprt    : string;  virtual;//������ ��� �������� ��� ��������
    function Get_DirReport   : string;  virtual;//������ ��� �������� Report
    function Get_DirArchivCmd: string;  virtual;//������ ��� �������� ������ ������
    function Get_DirExprtNet : string;  virtual;//������� ��� �������� ��������
    function Get_NameModul   : string;  virtual;//������ ��� ������������ ������
    function Get_Version     : string;  virtual;//������ �����
    function Get_NameLog     : string;  virtual;//������ ��� ���-�����
    function Get_NameReport  : string;  virtual;//������ ��� ����� ������
    function Get_AppFullName : string;  virtual;//������ ��� ����� e:\...Viewer\Smes_XP.exe
    function Get_AppWndCapt  : string;  virtual;//��� ��������� ���� Smes_XP (SMES-XP V.3.5)
    function Get_AppProcName : string;  virtual;//��� �������� ���� Smes_XP
    function Get_AppAutoClose: Boolean; virtual;//������������� ��������� ����������, ��� ������ �� �������� ���������
    function Get_LstOnOff    : Boolean; virtual;//����� �������� �� � �������
    
   private//��������� �������� ����� - �������� ������ ������
    procedure Set_APageIndex  (Value: Integer); virtual;//�������� ��������
    procedure Set_LogLevel    (Value: Integer); virtual;//������� ����������� ���������
    procedure Set_LogOnOff    (Value: Boolean); virtual;//�������� � ���� ���/����.
    procedure Set_MnMzOnOff   (Value: Boolean); virtual;//������� ����������� � ����
    procedure Set_ShowErr     (Value: Boolean); virtual;//���������� ������ �������������
    procedure Set_AutoDelArh  (Value: Boolean); virtual;//��������� �������. �������� �������� ������ ������
    procedure Set_AutoDelLog  (Value: Boolean); virtual;//��������� �������. �������� ���-�����
    procedure Set_RewriteLog  (Value: Boolean); virtual;//��������� ���������� LOG-�����
    procedure Set_AutoStartMon(Value: Boolean); virtual;//��������� �������������� ������ �������� ��������
    procedure Set_DelayInp    (Value: Integer); virtual;//����� �������� ������������ TSK_INP � [���]
    procedure Set_OldArhDay   (Value: Integer); virtual;//������� �������� ����� ������ ������� ����
    procedure Set_OldLogDay   (Value: Integer); virtual;//������� ���-����� ������� ����
    procedure Set_FileSizeMax (Value: Integer); virtual;//��� ������ ������ ��� ��������� ������/�����������
    procedure Set_DirProg     (Value: string); virtual; //������ ��� �������� ���������
    procedure Set_CommandDir  (Value: string); virtual; //������ ��� ������ �������� ��� INPUT|WORK|OUT
    procedure Set_DirInp      (Value: string); virtual; //������ ��� ��������� ��������
    procedure Set_DirWork     (Value: string); virtual; //������ ��� �������� ��������
    procedure Set_DirOut      (Value: string); virtual; //������ ��� ��������� ��������
    procedure Set_DirExprt    (Value: string); virtual; //������ ��� �������� ��� ��������
    procedure Set_DirReport   (Value: string); virtual; //������ ��� �������� Report
    procedure Set_DirArchivCmd(Value: string); virtual; //������ ��� �������� ������ ������
    procedure Set_DirExprtNet (Value: string); virtual; //������� ��� �������� ��������
    procedure Set_NameModul   (Value: string); virtual; //������ ��� ������������ ������
    procedure Set_Version     (Value: string); virtual; //������ �����
    procedure Set_NameLog     (Value: string); virtual; //������ ��� ���-�����
    procedure Set_NameReport  (Value: string); virtual; //������ ��� ����� ������
    procedure Set_AppFullName (Value: string); virtual; //������ ��� ����� e:\...Viewer\Smes_XP.exe
    procedure Set_AppWndCapt  (Value: string); virtual; //��� ��������� ���� Smes_XP (SMES-XP V.3.5)
    procedure Set_AppProcName (Value: string); virtual; //��� �������� ���� Smes_XP
    procedure Set_AppAutoClose(Value: Boolean); virtual;//������������� ��������� ����������, ��� ������ �� �������� ���������
    procedure Set_LstOnOff    (Value: Boolean); virtual;//����� �������� �� � �������
    
   public
    //���� fIniName:= '' ����� ������ �� ���������, ����� �� �����
    constructor Create;
    destructor Destroy; override;

    property APageIndex  : Integer read Get_APageIndex   write Set_APageIndex; //�������� ��������
    property LogLevel    : Integer read Get_LogLevel     write Set_LogLevel;   //������� ����������� ���������
    property LogOnOff    : Boolean read Get_LogOnOff     write Set_LogOnOff;   //�������� � ���� ���/����.
    property MnMzOnOff   : Boolean read Get_MnMzOnOff    write Set_MnMzOnOff;  //������� ����������� � ����
    property ShowErr     : Boolean read Get_ShowErr      write Set_ShowErr;    //���������� ������ �������������
    property AutoDelArh  : Boolean read Get_AutoDelArh   write Set_AutoDelArh; //��������� �������. �������� �������� ������ ������ 
    property AutoDelLog  : Boolean read Get_AutoDelLog   write Set_AutoDelLog; //��������� �������. �������� ���-�����
    property RewriteLog  : Boolean read Get_RewriteLog   write Set_RewriteLog; //��������� ���������� LOG-�����
    property AutoStartMon: Boolean read Get_AutoStartMon write Set_AutoStartMon;//��������� �������������� ������ �������� ��������
    property DelayInp    : Integer read Get_DelayInp     write Set_DelayInp;   //����� �������� ������������ TSK_INP � [���]
    property OldArhDay   : Integer read Get_OldArhDay    write Set_OldArhDay;  //������� �������� ����� ������ ������� ����
    property OldLogDay   : Integer read Get_OldLogDay    write Set_OldLogDay;  //������� ���-����� ������� ����
    property FileSizeMax : Integer read Get_FileSizeMax  write Set_FileSizeMax;//��� ������ ������ ��� ��������� ������/�����������
    property DirProg     : string  read Get_DirProg      write Set_DirProg;    //������ ��� �������� ���������
    property CommandDir  : string  read Get_CommandDir   write Set_CommandDir; //������ ��� ������ �������� ��� INPUT|WORK|OUT
    property DirInp      : string  read Get_DirInp       write Set_DirInp;     //������ ��� ��������� ��������
    property DirWork     : string  read Get_DirWork      write Set_DirWork;    //������ ��� �������� ��������
    property DirOut      : string  read Get_DirOut       write Set_DirOut;     //������ ��� ��������� ��������
    property DirExprt    : string  read Get_DirExprt     write Set_DirExprt;   //������ ��� �������� ��� ��������
    property DirReport   : string  read Get_DirReport    write Set_DirReport;  //������ ��� �������� Report
    property DirArchivCmd: string  read Get_DirArchivCmd write Set_DirArchivCmd;//������ ��� �������� ������ ������
    property DirExprtNet : string  read Get_DirExprtNet  write Set_DirExprtNet;//������� ��� �������� ��������
    property NameModul   : string  read Get_NameModul    write Set_NameModul;  //������ ��� ������������ ������
    property VersFile    : string  read Get_Version      write Set_Version;    //������ �����
    property NameLog     : string  read Get_NameLog      write Set_NameLog;    //������ ��� ���0-�����
    property NameReport  : string  read Get_NameReport   write Set_NameReport; //������ ��� ����� ������
    property AppFullName : string  read Get_AppFullName  write Set_AppFullName;//������ ��� ����� e:\...Viewer\Smes_XP.exe
    property AppWndCapt  : string  read Get_AppWndCapt   write Set_AppWndCapt; //��� ��������� ���� Smes_XP (SMES-XP V.3.5)
    property AppProcName : string  read Get_AppProcName  write Set_AppProcName;//��� �������� ���� Smes_XP
    property AppAutoClose: Boolean read Get_AppAutoClose write Set_AppAutoClose;//������������� ��������� ����������, ��� ������ �� �������� ���������
    property LstOnOff    : Boolean read Get_LstOnOff     write Set_LstOnOff;   //����� �������� �� � �������

    //������ ��������� ���������
    function LoadFromIniFile(const fIniName:string): TSetProg;
    //���������� �������� ���������
    function SaveInIniFile(const fIniName:string): Boolean;

    //�������� ������ ���-������ � �������� ������ ������
    function DeleteOldFile(const PathScan, //������� ������������
                                 ExtFile   //���������� ������ ������
                                 : string;
                           const Day,      //����� ����
                                 DelDir    //������� �������� ������� �������� 0-��������|1-�������
                                 : Integer
                          ): Integer;

    //�������� ������ �����
    function GetVersionFile(const FullNameFile: string): string;

    //�������� ��� ������ �����
    function GetNameModuleFile(const hModule: THandle): string;

    //���������� ����� ������ ������ �������, �����������
    procedure Assign(Source: TSetProg);

    //��������� ����� ������ ������ �������, �����������
    //���� OldPrm = NewOpm ����� FALSE, OldPrm <> NewOpm ����� TRUE
    function ComparePrm(OldPrm: TSetProg): Boolean;

    //�������� �������� �� ������� � ������������ ���������
    //���� DirTmp = '' �� ����������� ������ ������� ��������
    function TestDirExist(FullDirName, DirTmp: string): Boolean;
  end;


implementation

uses SysUtils, Windows, ResStr_ForClass, Classes;

{ TSetProg }

{+$WARN SYMBOL_DEPRECATED  }

procedure TSetProg.Assign(Source: TSetProg);
begin//���������� ����� ������ ������ �������, �����������
 if Source is TSetProg then
   begin
    APageIndex  := (Source as TSetProg).APageIndex; //�������� ��������
    LogLevel    := (Source as TSetProg).LogLevel;   //������� ����������� ���������
    LogOnOff    := (Source as TSetProg).LogOnOff;   //�������� � ���� ���/����.
    MnMzOnOff   := (Source as TSetProg).MnMzOnOff;  //������� ����������� � ����
    ShowErr     := (Source as TSetProg).ShowErr;    //���������� ������ �������������
    AutoDelArh  := (Source as TSetProg).AutoDelArh; //��������� �������. �������� �������� ������ ������
    AutoDelLog  := (Source as TSetProg).AutoDelLog; //��������� �������. �������� ���-�����
    RewriteLog  := (Source as TSetProg).RewriteLog; //��������� ���������� LOG-�����
    AutoStartMon:= (Source as TSetProg).AutoStartMon;//��������� �������������� ������ �������� ��������
    DelayInp    := (Source as TSetProg).DelayInp;   //����� �������� ������������ TSK_INP � [���]
    OldArhDay   := (Source as TSetProg).OldArhDay;  //������� �������� ����� ������ ������� ����
    OldLogDay   := (Source as TSetProg).OldLogDay;  //������� ���-����� ������� ����
    FileSizeMax := (Source as TSetProg).FileSizeMax;//��� ������ ������ ��� ��������� ������/�����������
    DirProg     := (Source as TSetProg).DirProg;    //������ ��� �������� ���������
    CommandDir  := (Source as TSetProg).CommandDir; //������ ��� ������ �������� ��� INPUT|WORK|OUT
    DirInp      := (Source as TSetProg).DirInp;     //������ ��� ��������� ��������
    DirWork     := (Source as TSetProg).DirWork;    //������ ��� �������� ��������
    DirOut      := (Source as TSetProg).DirOut;     //������ ��� ��������� ��������
    DirExprt    := (Source as TSetProg).DirExprt;   //������ ��� �������� ��� ��������
    DirReport   := (Source as TSetProg).DirReport;  //������ ��� �������� Report
    DirArchivCmd:= (Source as TSetProg).DirArchivCmd;//������ ��� �������� ������ ������
    DirExprtNet := (Source as TSetProg).DirExprtNet;//������� ��� �������� ��������
    NameModul   := (Source as TSetProg).NameModul;  //������ ��� ������������ ������
    VersFile    := (Source as TSetProg).VersFile;   //������ �����
    NameLog     := (Source as TSetProg).NameLog;    //������ ��� ���-�����
    NameReport  := (Source as TSetProg).NameReport; //������ ��� ����� ������
    AppFullName := (Source as TSetProg).AppFullName;//������ ��� ����� e:\...Viewer\Smes_XP.exe
    AppWndCapt  := (Source as TSetProg).AppWndCapt; //��� ��������� ���� Smes_XP
    AppProcName := (Source as TSetProg).AppProcName;//��� �������� ���� Smes_XP
    AppAutoClose:= (Source as TSetProg).AppAutoClose;//������������� ��������� ����������, ��� ������ �� �������� ���������
    LstOnOff    := (Source as TSetProg).fLstOnOff;  //����� �������� �� � �������
   end
     else
       Exception.Create(ErrClssCopy);
end;

function TSetProg.ComparePrm(OldPrm: TSetProg): Boolean;
begin//��������� ����� ������ ������ �������, �����������
 if //(OldPrm.APageIndex   <> Self.APageIndex) or   //�������� ��������
    (OldPrm.LogLevel     <> Self.LogLevel)     or   //������� ����������� ���������
    (OldPrm.LogOnOff     <> Self.LogOnOff)     or   //�������� � ���� ���/����.
    (OldPrm.MnMzOnOff    <> Self.MnMzOnOff)    or   //������� ����������� � ����
    (OldPrm.ShowErr      <> Self.ShowErr)      or   //���������� ������ �������������
    (OldPrm.AutoDelArh   <> Self.AutoDelArh)   or   //��������� �������. �������� �������� ������ ������
    (OldPrm.AutoDelLog   <> Self.AutoDelLog)   or   //��������� �������. �������� ���-�����
    (OldPrm.RewriteLog   <> Self.RewriteLog)   or   //��������� ���������� LOG-�����
    (OldPrm.AutoStartMon <> Self.AutoStartMon) or   //��������� �������������� ������ �������� ��������
    (OldPrm.DelayInp     <> Self.DelayInp)     or   //����� �������� ������������ TSK_INP � [���]
    (OldPrm.OldArhDay    <> Self.OldArhDay)    or   //������� �������� ����� ������ ������� ����
    (OldPrm.OldLogDay    <> Self.OldLogDay)    or   //������� ���-����� ������� ����
    (OldPrm.FileSizeMax  <> Self.FileSizeMax)  or   //��� ������ ������ ��� ��������� ������/�����������
    (OldPrm.DirProg      <> Self.DirProg)      or   //������ ��� �������� ���������
    (OldPrm.CommandDir   <> Self.CommandDir)   or   //������ ��� ������ �������� ��� INPUT|WORK|OUT
    (OldPrm.DirInp       <> Self.DirInp)       or   //������ ��� ��������� ��������
    (OldPrm.DirWork      <> Self.DirWork)      or   //������ ��� �������� ��������
    (OldPrm.DirOut       <> Self.DirOut)       or   //������ ��� ��������� ��������
    (OldPrm.DirExprt     <> Self.DirExprt)     or   //������ ��� �������� ��� ��������
    (OldPrm.DirArchivCmd <> Self.DirArchivCmd) or   //������ ��� �������� ������ ������
    (OldPrm.DirReport    <> Self.DirReport)    or   //������ ��� �������� Report
    (OldPrm.DirExprtNet  <> Self.DirExprtNet)  or   //������� ��� �������� ��������
    (OldPrm.NameModul    <> Self.NameModul)    or   //������ ��� ������������ ������
    (OldPrm.VersFile     <> Self.VersFile)     or   //������ �����
    (OldPrm.NameLog      <> Self.NameLog)      or   //������ ��� ���-�����
    (OldPrm.NameReport   <> Self.NameReport)   or   //������ ��� ����� ������
    (OldPrm.AppFullName  <> Self.AppFullName)  or   //������ ��� ����� e:\...Viewer\Smes_XP.exe
    (OldPrm.AppWndCapt   <> Self.AppWndCapt)   or   //��� ��������� ���� Smes_XP
    (OldPrm.AppProcName  <> Self.AppProcName)  or   //��� �������� ���� Smes_XP
    (OldPrm.AppAutoClose <> Self.AppAutoClose) or   //������������� ��������� ����������, ��� ������ �� �������� ���������
    (OldPrm.LstOnOff     <> Self.LstOnOff )         //����� �������� �� � �������
    then
        Result:= True  //�� ����������
   else
     Result:= False;  //�� �� ����������
//���� OldPrm = NewPrm ����� FALSE, OldPrm <> NewPrm ����� TRUE
end;

function TSetProg.TestDirExist(FullDirName, DirTmp: string): Boolean;
var
   Tmp: string;
begin//�������� �������� �� �������
 Result:= False;//��� ������� �� ���������, ��� ��� ���
 FullDirName:= ExpandUNCFileName(ExcludeTrailingPathDelimiter //���� ����, ������
                         (FullDirName));//������ ���� ����� ����� � ������� UNC     
  if (FullDirName <> '') and (not DirectoryExists(FullDirName)) then
    begin//�������� ���
     Result:= False;
     Exit;
    end;
 if DirTmp = '' then Exit;//������� ��� ��������� �� �����, �������
 Tmp:= ExtractFileName(FullDirName);//��������� ��� ������ �������
 if (CompareText(Tmp, DirTmp) = 0) then
   begin//��� ������� ���������
    if (not DirectoryExists(FullDirName)) then
       Result:= False
        else                  
       Result:= True;//������� ����
   end
     else
        Result:= False;//��� ������� �� ���������
end;


{+++++++++++ ������ � ������ � ���������� ������ ++++++++++++++++++++++++++++++}

constructor TSetProg.Create;
begin//������� �� ���������
 inherited;
  fAPageIndex     := 0;     //�������� ��������
  fLogLevel       := 1;     //������� ����������� ���������
  fLogOnOff       := True;  //�������� � ���� ���.
  fMnMzOnOff      := False; //������� ����������� � ���� ����.
  fShowErr        := False; //���������� ������ ������������� ���.
  fAutoDelArh     := True;  //��������� �������. �������� �������� ������ ������ ���.
  fAutoDelLog     := False; //��������� �������. �������� ���-����� ���.
  fRewriteLog     := False; //��������� ���������� ������
  fAutoStartMon   := True;  //��������� �������������� ������ �������� ��������
  fDelayInp       := DefDelay;//����� �������� ������������ TSK_INP � [���]
  fOldArhDay      := 90;    //������� �������� ����� ������ ������� ����
  fOldLogDay      := 90;    //������� ���-����� ������� ����
  fSizeMax        := MaxFileSize;//��� ������ ������ ��� ��������� ������/�����������
  fDirProg        := ExtractFileDir(GetModuleName(HInstance));  //������ ��� �������� ���������
  fCommandDir     := '';   //������ ��� ������ �������� ��� INPUT|WORK|OUT
  fDirInp         := '';   //������ ��� ��������� ��������
  fDirWork        := '';   //������ ��� �������� ��������
  fDirOut         := '';   //������ ��� ��������� ��������
  fDirExprt       := '';   //������ ��� �������� ��� ��������
  fDirArchivCmd   := '';   //������ ��� �������� ������ ������
  fDirReport      := '';   //������ ��� �������� Report
  fDirExprtNet    := '';   //������ ��� �������� �������� ��������
  fNameModul      := '';   //��� ����������� *.Dll ��� *.EXE
  fVersion        := '';   //������ *.Dll ��� *.EXE
  fNameFileLog    := '';   //������ ��� ���-�����
  fNameFileReport := '';   //������ ��� ����� ������
  fAppFullName    := '';   //������ ��� ����� e:\...Viewer\Smes_XP.exe
  fAppWndCapt     := AppSmess;//��� ��������� ���� Smes_XP
  fAppAutoClose   := False;//������������� ��������� ����������, ��� ������ �� �������� ���������
  fLstOnOff       := False;//����� �������� �� � �������
end;

destructor TSetProg.Destroy;
begin
 inherited;
end;

function TSetProg.Get_AutoStartMon: Boolean;
begin
 Result:= fAutoStartMon;
end;

function TSetProg.Get_APageIndex: Integer;
begin
 Result:= fAPageIndex;
end;

function TSetProg.Get_AutoDelArh: Boolean;
begin
 Result:= fAutoDelArh;
end;

function TSetProg.Get_AutoDelLog: Boolean;
begin
 Result:= fAutoDelLog;
end;

function TSetProg.Get_ShowErr: Boolean;
begin
 Result:= fShowErr;
end;

function TSetProg.Get_AppWndCapt: string;
begin
 Result:= AnsiUpperCase(Trim(fAppWndCapt));
end;

function TSetProg.Get_AppAutoClose: Boolean;
begin
 Result:= fAppAutoClose;
end;

function TSetProg.Get_AppFullName: string;
begin
 Result:= AnsiUpperCase(Trim(fAppFullName));
end;

function TSetProg.Get_AppProcName: string;
begin
 Result:= AnsiUpperCase(Trim(fAppProcName));
end;

function TSetProg.Get_CommandDir: string;
begin
 Result:= ExcludeTrailingPathDelimiter(Trim(fCommandDir));
end;

function TSetProg.Get_DelayInp: Integer;
begin
 if  fDelayInp <= 0 then  Result:= DefDelay
   else
 if  fDelayInp > MaxDelay then  Result:= MaxDelay
   else
 Result:= fDelayInp;
end;

function TSetProg.Get_DirArchivCmd: string;
begin
 Result:= ExcludeTrailingPathDelimiter(Trim(fDirArchivCmd));
end;

function TSetProg.Get_DirExprt: string;
begin
 Result:= ExcludeTrailingPathDelimiter(Trim(fDirExprt));
end;

function TSetProg.Get_DirExprtNet: string;
begin
 Result:= AnsiUpperCase(ExcludeTrailingPathDelimiter(Trim(fDirExprtNet)));
end;

function TSetProg.Get_DirInp: string;
begin
 Result:= ExcludeTrailingPathDelimiter(Trim(fDirInp));
end;

function TSetProg.Get_DirOut: string;
begin
 Result:= ExcludeTrailingPathDelimiter(Trim(fDirOut));
end;

function TSetProg.Get_DirProg: string;
begin
 Result:= ExcludeTrailingPathDelimiter(Trim(fDirProg));
end;

function TSetProg.Get_DirReport: string;
begin
 Result:= ExcludeTrailingPathDelimiter(Trim(fDirReport));
end;

function TSetProg.Get_DirWork: string;
begin
 Result:= ExcludeTrailingPathDelimiter(Trim(fDirWork));
end;

function TSetProg.Get_FileSizeMax: Integer;
begin
 Result:= fSizeMax;
end;

function TSetProg.Get_LogLevel: Integer;
begin
 if  fLogLevel <= 0 then Result:= 1
   else
 if  fLogLevel >= MAX_LogLevel then Result:= MAX_LogLevel
   else
     Result:= fLogLevel; 
end;

function TSetProg.Get_LogOnOff: Boolean;
begin
 Result:= fLogOnOff;
end;

function TSetProg.Get_MnMzOnOff: Boolean;
begin
 Result:= fMnMzOnOff;
end;

function TSetProg.Get_NameReport: string;
begin
 Result:= Trim(fNameFileReport);
end;

function TSetProg.Get_NameLog: string;
begin
 Result:= Trim(fNameFileLog);
end;

function TSetProg.Get_NameModul: string;
begin
 Result:= Trim(fNameModul);
end;

function TSetProg.Get_OldArhDay: Integer;
begin
 Result:= fOldArhDay;
end;

function TSetProg.Get_OldLogDay: Integer;
begin
 Result:= fOldLogDay;
end;

function TSetProg.Get_RewriteLog: Boolean;
begin
 Result:= fRewriteLog;
end;

function TSetProg.Get_Version: string;
begin
 Result:= Trim(fVersion);
end;

function TSetProg.Get_LstOnOff: Boolean;
begin
 Result:= fLstOnOff;
end;

function TSetProg.LoadFromIniFile(const fIniName: string): TSetProg;
var
   fIni: TIniFile;
   Sctn: string;//��� ������ INI-����� = ����� ������
begin//������ ��������� ��������� �� Ini-�����
 Result:= nil;
 fIni:= TIniFile.Create(fIniName);
 //��� ������ INI-����� = ����� ������
 Sctn:= TSetProg.ClassName;//������  INI-�����
 with Self do
 try
   try
    Set_APageIndex  (fIni.ReadInteger(Sctn, 'ActivePageIndex', 0));    //�������� ��������
    Set_LogLevel    (fIni.ReadInteger(Sctn, 'LogLevel'       , fLogLevel));//������� ����������� ���������
    Set_LogOnOff    (fIni.ReadBool   (Sctn, 'Log_OnOff'      , fLogOnOff)); //�������� � ���� ���/����.
    Set_MnMzOnOff   (fIni.ReadBool   (Sctn, 'MiniMize_OnOff' , fMnMzOnOff)); //������� ����������� � ����
    Set_ShowErr     (fIni.ReadBool   (Sctn, 'ShowErr'        , fShowErr)); //���������� ������ �������������
    Set_AutoDelArh  (fIni.ReadBool   (Sctn, 'AutoDelArh'     , fAutoDelArh)); //��������� �������. �������� �������� ������ ������
    Set_AutoDelLog  (fIni.ReadBool   (Sctn, 'AutoDelLog'     , fAutoDelLog)); //��������� �������. �������� ���-�����
    Set_RewriteLog  (fIni.ReadBool   (Sctn, 'RewriteLog'     , fRewriteLog));//��������� ���������� LOG-�����
    Set_AutoStartMon(fIni.ReadBool   (Sctn, 'AutoStartMon'   , fAutoStartMon));//��������� ������������� ����� ��������
    Set_DelayInp    (fIni.ReadInteger(Sctn, 'DelayInp'       , fDelayInp));    //����� �������� ������������ TSK_INP � [���]
    Set_OldArhDay   (fIni.ReadInteger(Sctn, 'OldArhDay'      , fOldArhDay));   //������� �������� ����� ������ ������� ����
    Set_OldLogDay   (fIni.ReadInteger(Sctn, 'OldLogDay'      , fOldLogDay));   //������� ���-����� ������� ����
    Set_FileSizeMax (fIni.ReadInteger(Sctn, 'FileSizeMax'    , fSizeMax));//������ ��� ������ ������ ��� ��������� ������/�����������
    Set_DirProg     (fIni.ReadString (Sctn, 'DirProg'        , ''));  //������ ��� �������� ���������
    Set_CommandDir  (fIni.ReadString (Sctn, 'CommandDir'     , ''));  //������ ��� ������ �������� ��� INPUT|WORK|OUT
    Set_DirInp      (fIni.ReadString (Sctn, 'DirInp'         , ''));  //������ ��� ��������� ��������
    Set_DirWork     (fIni.ReadString (Sctn, 'DirWork'        , ''));  //������ ��� �������� ��������
    Set_DirOut      (fIni.ReadString (Sctn, 'DirOut'         , ''));  //������ ��� ��������� ��������
    Set_DirExprt    (fIni.ReadString (Sctn, 'DirExprt'       , ''));  //������ ��� �������� ��� ��������
    Set_DirArchivCmd(fIni.ReadString (Sctn, 'DirArhivCmd'    , ''));  //������ ��� �������� ������ ������
    Set_DirReport   (fIni.ReadString (Sctn, 'DirReport'      , ''));  //������ ��� �������� Report
    Set_DirExprtNet (fIni.ReadString (Sctn, 'DirExprtNet'    , ''));  //������� ��� �������� ��������
    Set_NameModul   (fIni.ReadString (Sctn, 'NameModule'     , ''));  //������ ��� ������������ ������
    Set_Version     (fIni.ReadString (Sctn, 'Version_File'   , ''));  //������ �����
    Set_NameLog     (fIni.ReadString (Sctn, 'NameLog'        , ''));   //������ ��� ���-�����
    Set_NameReport  (fIni.ReadString (Sctn, 'NameReport'     , ''));   //������ ��� ����� ������
    Set_AppFullName (fIni.ReadString (Sctn, 'AppFullName'    , ''));   //������ ��� ����� e:\...Viewer\Smes_XP.exe
    Set_AppWndCapt  (fIni.ReadString (Sctn, 'AppWndCapt'     , ''));   //��� ��������� ���� Smes_XP (SMES-XP V.3.5)
    Set_AppProcName (fIni.ReadString (Sctn, 'AppProcName'    , fAppProcName)); //��� �������� ���� Smes_XP
    Set_AppAutoClose(fIni.ReadBool   (Sctn, 'AppAutoClose'   , fAppAutoClose));//������������� ��������� ����������, ��� ������ �� �������� ���������
    Set_LstOnOff    (fIni.ReadBool   (Sctn, 'LstOnOff'       , fLstOnOff));//����� �������� �� � �������
    Result:= Self;
   except
    raise //���������� ���� ����������
     Exception.Create(Format(ErrClssRead, [Sctn, fIni.FileName]));
   end;
 finally
  FreeAndNil(fIni);
 end;
end;


function TSetProg.SaveInIniFile(const fIniName: string): Boolean;
var
   fIni: TIniFile;
   Sctn: string;//��� ������ INI-����� = ����� ������
begin//���������� �������� ��������� � Ini-����
 Result:= False;
 fIni:= TIniFile.Create(fIniName);
 //��� ������ INI-����� = ����� ������
 Sctn:= Self.ClassName;//������  INI-�����  
 try
   try
   with Self do
    begin
     fIni.WriteInteger(Sctn, 'ActivePageIndex',  fAPageIndex); //�������� ��������
     fIni.WriteInteger(Sctn, 'LogLevel',         fLogLevel);   //������� ����������� ���������
     fIni.WriteBool   (Sctn, 'Log_OnOff',        fLogOnOff);   //�������� � ���� ���/����.
     fIni.WriteBool   (Sctn, 'MiniMize_OnOff',   fMnMzOnOff);  //������� ����������� � ����
     fIni.WriteBool   (Sctn, 'ShowErr',          fShowErr);    //���������� ������ �������������
     fIni.WriteBool   (Sctn, 'AutoDelArh',       fAutoDelArh); //��������� �������. �������� �������� ������ ������
     fIni.WriteBool   (Sctn, 'AutoDelLog',       fAutoDelLog); //��������� �������. �������� ���-�����
     fIni.WriteBool   (Sctn, 'RewriteLog',       fRewriteLog); //��������� ���������� LOG-�����
     fIni.WriteBool   (Sctn, 'AutoStartMon',     fAutoStartMon);//��������� �������������� ������ �������� ��������
     fIni.WriteInteger(Sctn, 'DelayInp',         fDelayInp);   //����� �������� ������������ TSK_INP � [���]  
     fIni.WriteInteger(Sctn, 'OldArhDay',        fOldArhDay);  //������� �������� ����� ������ ������� ����
     fIni.WriteInteger(Sctn, 'OldLogDay',        fOldLogDay);  //������� ���-����� ������� ����
     fIni.WriteInteger(Sctn, 'FileSizeMax',      fSizeMax);//������ ��� ������ ������ ��� ��������� ������/�����������
     fIni.WriteString (Sctn, 'DirProg',          fDirProg);    //������ ��� �������� ���������
     fIni.WriteString (Sctn, 'CommandDir',       fCommandDir);  //������ ��� ������ �������� ��� INPUT|WORK|OUT
     fIni.WriteString (Sctn, 'DirInp',           fDirInp);     //������ ��� ��������� ��������
     fIni.WriteString (Sctn, 'DirWork',          fDirWork);    //������ ��� �������� ��������
     fIni.WriteString (Sctn, 'DirOut',           fDirOut);     //������ ��� ��������� ��������
     fIni.WriteString (Sctn, 'DirExprt',         fDirExprt);   //������ ��� �������� ��� ��������
     fIni.WriteString (Sctn, 'DirArchivCmd',     fDirArchivCmd);//������ ��� �������� ��� ��������
     fIni.WriteString (Sctn, 'DirReport',        fDirReport);  //������ ��� �������� Report
     fIni.WriteString (Sctn, 'DirExprtNet',      fDirExprtNet);//������� ��� �������� ��������
     fIni.WriteString (Sctn, 'NameModule',       fNameModul);  //������ ��� ������������ ������
     fIni.WriteString (Sctn, 'Version_File',     fVersion);   //������ �����
     fIni.WriteString (Sctn, 'NameLog',          fNameFileLog);    //������ ��� ���-�����
     fIni.WriteString (Sctn, 'NameReport',       fNameFileReport); //������ ��� ����� ������
     fIni.WriteString (Sctn, 'AppFullName',      fAppFullName);//������ ��� ����� e:\...Viewer\Smes_XP.exe
     fIni.WriteString (Sctn, 'AppWndCapt',       fAppWndCapt); //��� ��������� ���� Smes_XP (SMES-XP V.3.5)
     fIni.WriteString (Sctn, 'AppProcName',      fAppProcName);//��� �������� ���� Smes_XP
     fIni.WriteBool   (Sctn, 'AppAutoClose',     fAppAutoClose);//������������� ��������� ����������, ��� ������ �� �������� ���������
     fIni.WriteBool   (Sctn, 'LstOnOff',         fLstOnOff);   //����� �������� �� � �������
    Result:= True;
    end;
   except
    raise //���������� ���� ����������
     Exception.Create(Format(ErrClssSave, [Sctn, fIni.FileName]));
   end;
 finally
  FreeAndNil(fIni);
 end;
end;

{+++++++++++ ��������� �������� ����� ������ +++++++++++++++++++}

procedure TSetProg.Set_AutoStartMon(Value: Boolean);
begin
 fAutoStartMon:= Value;
end;

procedure TSetProg.Set_APageIndex(Value: Integer);
begin
 fAPageIndex:= Value;
end;

procedure TSetProg.Set_AutoDelArh(Value: Boolean);
begin
 fAutoDelArh:= Value;
end;

procedure TSetProg.Set_AutoDelLog(Value: Boolean);
begin
 fAutoDelLog:= Value;
end;

procedure TSetProg.Set_ShowErr(Value: Boolean);
begin
 fShowErr:= Value;
end;

procedure TSetProg.Set_AppWndCapt(Value: string);
begin
 fAppWndCapt:= AnsiUpperCase(Trim(Value));
end;

procedure TSetProg.Set_AppAutoClose(Value: Boolean);
begin
 fAppAutoClose:= Value;
end;

procedure TSetProg.Set_AppFullName(Value: string);
begin
 fAppFullName:= AnsiUpperCase(Trim(Value));
end;

procedure TSetProg.Set_AppProcName(Value: string);
begin
 fAppProcName:= AnsiUpperCase(Trim(Value));
end;

procedure TSetProg.Set_CommandDir(Value: string);
begin
 fCommandDir:= ExcludeTrailingPathDelimiter(Trim(Value));
end;

procedure TSetProg.Set_DelayInp(Value: Integer);
begin
 if  Value <= 0 then  fDelayInp:= DefDelay
     else
 if  DelayInp > MaxDelay then fDelayInp:= MaxDelay
     else
 fDelayInp:= Value;
end;

procedure TSetProg.Set_DirArchivCmd(Value: string);
begin
 fDirArchivCmd:= ExcludeTrailingPathDelimiter(Trim(Value));
end;

procedure TSetProg.Set_DirExprt(Value: string);
begin
 fDirExprt:= ExcludeTrailingPathDelimiter(Trim(Value));
end;

procedure TSetProg.Set_DirExprtNet(Value: string);
begin
 fDirExprtNet:= AnsiUpperCase(ExcludeTrailingPathDelimiter(Trim(Value)));
end;

procedure TSetProg.Set_DirInp(Value: string);
begin
 fDirInp:= ExcludeTrailingPathDelimiter(Trim(Value));
end;

procedure TSetProg.Set_DirOut(Value: string);
begin
 fDirOut:= ExcludeTrailingPathDelimiter(Trim(Value));
end;

procedure TSetProg.Set_DirProg(Value: string);
begin
 fDirProg:= ExcludeTrailingPathDelimiter(Trim(Value));
end;

procedure TSetProg.Set_DirReport(Value: string);
begin
 fDirReport:= ExcludeTrailingPathDelimiter(Trim(Value));
end;

procedure TSetProg.Set_DirWork(Value: string);
begin
 fDirWork:= ExcludeTrailingPathDelimiter(Trim(Value));
end;

procedure TSetProg.Set_FileSizeMax(Value: Integer);
begin
 fSizeMax:= Value;
end;

procedure TSetProg.Set_LogLevel(Value: Integer);
begin
 if  (Value <= 0) then  Value := 1
   else
  if  (Value >= MAX_LogLevel) then Value := MAX_LogLevel;
 fLogLevel:= Value; 
end;

procedure TSetProg.Set_LogOnOff(Value: Boolean);
begin
 fLogOnOff:= Value;
end;

procedure TSetProg.Set_MnMzOnOff(Value: Boolean);
begin
 fMnMzOnOff:= Value;
end;

procedure TSetProg.Set_NameReport(Value: string);
begin
 fNameFileReport:= Trim(Value);
end;

procedure TSetProg.Set_NameLog(Value: string);
begin
 fNameFileLog:= Trim(Value);
end;

procedure TSetProg.Set_NameModul(Value: string);
begin
 fNameModul:= Trim(Value);
end;

procedure TSetProg.Set_OldArhDay(Value: Integer);
begin
 fOldArhDay:= Value;
end;

procedure TSetProg.Set_OldLogDay(Value: Integer);
begin
 fOldLogDay:= Value;
end;

procedure TSetProg.Set_RewriteLog(Value: Boolean);
begin
 fRewriteLog:= Value;
end;

procedure TSetProg.Set_Version(Value: string);
begin
 fVersion:= Trim(Value);
end;

procedure TSetProg.Set_LstOnOff(Value: Boolean);
begin
 fLstOnOff:= Value;
end;

// ����������� �������� ������ � ���������
function Recursiv(PathScan, fExt: string; Day, DelDir: Integer;
                  var Lst: TStringList): Integer;
Var
   SR : TSearchRec;
begin
 try
  PathScan:= IncludeTrailingPathDelimiter(PathScan);
  if FindFirst(PathScan + '*.*', faAnyFile, SR) = 0 then //����� ������� �����
    repeat  //���� ������ ������
      if (SR.Attr and faDirectory) = faDirectory  then
       begin //we found Directory: "PathFile + SRec.name"
        if (SR.Name <> '.') and (SR.Name <> '..') then
          begin//������ �������
           Recursiv(PathScan + SR.Name, fExt, Day, DelDir, Lst);//��������� ����� � �������� �������
          end
       end
      else
     if (AnsiPos(AnsiUpperCase(fExt), AnsiUpperCase(SR.Name)) >0 ) or (fExt = '*') then
       begin//������ ����- ��������� ��������� ��������� ���� � �����
   if ((SR.Attr and faDirectory <> faDirectory) and
        ((SR.Attr and faVolumeID) <> faVolumeID) and
          (FileDateToDateTime(SR.Time) < Date - Day)) then
        try
         Lst.Add(PathScan + SR.Name); //��������� ������ ���� � �����
         if DeleteFile(PChar(PathScan + SR.Name))<> False then
           begin
            if (DelDir > 0)  then //���� 0-��������|1-�������
            RemoveDir(PathScan);  //�� ������� ������
            end;  
        except
         Break;
        end;
       end;
    until FindNext(SR) <> 0;//����� ��������� ������
  SysUtils.FindClose(SR);
  Result:= Lst.Count;
 except //��������� ����������
  on EListError: Exception do 
    begin
     Result:= 0;
     Exception.Create('function FindFilesLst �� OperSearch.DLL ��������� �������!');
    end;
 end;
end;

//�������� ������ ���-������ � �������� ������ ������
function TSetProg.DeleteOldFile(const PathScan, //������� ������������
                                      ExtFile   //���������� ������ ������
                                      : string;
                                const Day,      //����� ����
                                      DelDir    //������� �������� ������� �������� 0-��������|1-�������
                                      : Integer   
                                ): Integer;
Var
   PathFile: string;//���� � ����� � ��� �����
   sLst: TStrings;
begin// ������ ����� *.*** � �������� �������� � ������������
 sLst:= TStringList.Create;
 try
  PathFile:= IncludeTrailingPathDelimiter(PathScan);//���� ��� �� ��������
  Recursiv(PathFile, ExtFile, Day, DelDir, TStringList(sLst));
  Result:= sLst.Count;
 finally
  FreeAndNil(sLst);
 end;
end;


function TSetProg.GetVersionFile(const FullNameFile: string): string;
resourcestring
   ErrVersFile1= '�� ���� ��������� ������ �����: ';
   ErrVersFile2= '������ ����� ��� ����������� ��� ����������';
   FrmtVersFile= '%2d.%2d.%2d.%2d';
var
   Info: Pointer;
   InfoSize: DWORD;
   FileInfo: PVSFixedFileInfo;
   FileInfoSize: DWORD;
   Tmp: DWORD;
begin//�������� ������ �����  FullNameFile= ������ ��� �����
 // Get the size of the FileVersionInformatioin
 InfoSize := GetFileVersionInfoSize(PChar(FullNameFile), Tmp);
 // If InfoSize = 0, then the file may not exist, or
 // it may not have file version information in it.
 if InfoSize = 0 then
   begin
    Result:= ( ErrVersFile1+ FullNameFile +'.'#10#13 + ErrVersFile2);
//    raise Exception.Create( ErrVersFile1+ FullNameFile +'.'#10#13 + ErrVersFile2);

   end
     else
       begin
         GetMem(Info, InfoSize);
         try
           // Get the information
          GetFileVersionInfo(PChar(FullNameFile), 0, InfoSize, Info);
           // Query the information for the version
          VerQueryValue(Info, '\', Pointer(FileInfo), FileInfoSize);
           // Now fill in the version information
          Result := PChar(Format(FrmtVersFile,[ FileInfo.dwFileVersionMS shr 16,
                                                FileInfo.dwFileVersionMS and $FFFF,
                                                FileInfo.dwFileVersionLS shr 16,
                                                FileInfo.dwFileVersionLS and $FFFF]));
         finally
          FreeMem(Info, FileInfoSize);
         end;
       end;
 // Allocate memory for the file version information
end;


function TSetProg.GetNameModuleFile(const hModule: THandle): string;
begin//�������� ��� ������ �����
 Result:= ExtractFileName(GetModuleName(hModule)); 
end;

end.

