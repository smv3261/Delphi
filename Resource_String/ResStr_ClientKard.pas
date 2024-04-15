unit ResStr_ClientKard;

interface

const
   CmdMax = 10; //��� ����� ������ �����
   InpCmd: array[1..CmdMax] of PChar = ('KARD.WRITE_DATA',   //������ ������
                                        'KARD.READ_DATA',    //������ ������
                                        'KARD.REPLACE_DATA', //���������� ������
                                        'STATE_CONTR',       //�������� ���������
                                        'BREAK_TASK',        //��������� ����������
                                        'KARD.SUMM_TABLE',   //��������� ���. � ������(-��)
                                        'KARD.DETAL_TABLE',  //��������� ���. �������(-��)
                                        'KARD.WRITE_REFER',  //������ ������(����� ����� ������ ��������)
                                        'KARD.REPLACE_REFER',//���������� ������(����� ����� ������ ��������)
                                        'KARD.OUT_DATA'      //���������� ������(����� ����� ������ ��������)
                                                             //� �������� ��� �� ����� � ������� OUT_PATH                       
                                        ); //����� ������������������ ������
                                      
   fDataInfo = '__DATA_INFO.TXT';//��� ����� ������ ���������� � ��

   fDspInt = '### ### ### ### ##0';//������-������ ������ �� ������� ����� ��������

   MaxSmes = 2;//��� ����� ������ Smes_Xp
   CmdSmes: array[1..MaxSmes] of string = ('RELOAD_IMG=%s', //������� ����������� �����������
                                           'OPENFILE=%s'    //������� ������� �����������
                                          );
   RsltSmes = 'CANCEL';                                   //����� ����� �� SMES_XP
   
resourcestring

{+++++++++++ ����� �� +++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
// ������ �� ������� � ResStr_SetServer.pas
// Local_Alias = 'Local_Kard' ;//����� ��� ������ ��������� ��
// Server_Alias= 'Server_Kard';//����� ��� ������ ��������� ��

{+++++++++++ ������ � ���������� ���������� INI- ����� ++++++++++++++++++++++++}
 sCMD   = 'COMMAND'; //������ ������
// sInpDt = 'INP_DATA';//������ ������� ������
 sOptn  = 'OPTIONS'; //������ ����� �������
 sFltr  = 'FILTERS'; //������ �������� ��� �������
 sRslt  = 'RESULT';  //������ ���������� ���������� ������
 sRprt  = 'REPORT';  //������ ������ � ����������� ������
 sOutDt = 'OUT_DATA';//������ �������� ������
 sImgInf= 'IMG_INF'; //������ �������� ���������� �� �����������
 
{+++++++++++ ����� ���������� INI- ����� ++++++++++++++++++++++++++++++++++++++}
 pCMD1     = 'COMMAND1' ;//�������-�������� ��� ����������
 pDataName = 'DATA_NAME';//�������� ��� ������ �������������
 pDataPath = 'DATA_PATH';//�������� ���� � �������� ��������
 pOutPath  = 'OUT_PATH' ;//�������� ���� � �������� ����������
 pSizeMax  = 'FILE_MAX_SIZE';//������ ��� ������ ������ ��� ��������� ������/�����������
 
{+++++++++++ ��������� ���������� INI- ����� ++++++++++++++++++++++++++++++++++}
 pRslt     = 'RESULT'   ;//�������� ����������
 pERROR    = 'ERROR';    //�������� ����������
 pRprt     = 'REPORT';   //�������� ����������
 pFldLst   = 'FIELD_LIST';//�������� ������ ����� �������

 vOK       = 'OK'   ;      //�������� ��������� - ��
 vErr      = 'ERR';        //�������� ��������� - ERROR
 vStCntr   = 'STATE_CONTR';//�������� ��������� - STATE_CONTR - 
                           //�������� ������ ��������� ClientKARDa

//+++++++ ������������ ������ � INI-����� ++++++++++++++++++++++++++++++++++++++
{} 
 pWrite    = 'KARD.WRITE_DATA';   //�������� ������� 'KARD.Write_DATA' 
 pWrtRefer = 'KARD.WRITE_REFER';  //�������� ������� KARD.WRITE_REFER
 pRead     = 'KARD.READ_DATA';    //�������� ������� 'KARD.READ_DATA'
 pReplace  = 'KARD.REPLACE_DATA'; //�������� ������� 'KARD.REPLACE_DATA' 
 pRplcRefer= 'KARD.REPLACE_REFER';//�������� ������� KARD.REPLACE_REFER 
 pSummTbl  = 'KARD.SUMM_TABLE';   //�������� ������� KARD.SUMM_TABLE
 pDetalTbl = 'KARD.DETAL_TABLE';  //�������� ������� KARD.DETAL_TABLE
 pOutData  = 'KARD.OUT_DATA';     //�������� ������� KARD.OUT_DATA
 pStateCntr= 'KARD.STATE_CONTR';  //�������� ������� KARD.STATE_CONTR
 pBreak    = 'KARD.BREAK_TASK';   //�������� ������� KARD.BREAK_TASK

                           
{+++++++++++ �������� ��� ���������� INI- ����� +++++++++++++++++++++++++++++++}
 ZS        = '_ZS';        //��������� � ����� ����� �������� ������ ��������� ClientKARDa
 sSubRefer = '_REFER';     //��������� � ����� ����� 
 sSubData  = 'OUT_DATA';   //��������� � ����� ����� 

{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}  

{+++++++++++ ���������� ���������� ����� ++++++++++++++++++++++++++++++++++++++}
 Ext  = '.TS�'; //���������� ���������� �����

{+++++++++++ ���� � �������� ������ ���������� �� ������ ++++++++++++++++++++++}
 fLstField = 'ListField.txt';//��� ����� ������ ������� ����� ��

{+++++++++++ ��������� ���� � ����������� � ��� +++++++++++++++++++++++++++++++}
 iClientKard = 'Form_ClientKard.Ini';//��� IniFile-����� ����� ClientKard.EXE
 HlpFile     = 'KARD_hlp.chm';       //��� ����� ������ � �������
 
{+++++++++++ ����� LOG-������ +++++++++++++++++++++++++++++++++++++++++++++++++}
 fLogClientDb= 'ClientKard' ;//��� ����� ������ ���� ������ ClientKard
 fLogCmnd    = 'CommandKard' ;//��� ����� ������ ���� ������ ������

{+++++++++++ ������ �������� � ��������� ++++++++++++++++++++++++++++++++++++++}
   CmdCpt         = '��������� ��������� �����';
   CmdBeg         = '������ ��������� ��������� ����� ������� <%s>';
   CmdEnd         = '����� ��������� ��������� ����� ������� <%s>';
   CmdTxt         = '������� ������� <%s>. <OK> ';
   CmdErr         = '�������� ������� <%s> �� ����������';
   CmdRunExcept   = '��������� ����� <%s> ������� ����������!';
   CmdFileAccept  = '������ ���� <%s> - ��������� ���� �����. <OK>';
   CmdFile        = '�������� ���� <%s> �������� ��������� ������ �����.<OK>';
   CmdNoFile      = '�������� ���� <%s> �� �������� ��������� ������ �����!';
   CmdKeyYes      = '���� <%s>> %s> ���� � ��������� ����� <%s>.<OK>';
   CmdKeyEmpt     = '���� <%s>> %s> � ��������� ����� <%s> ������!';
   CmdKeyNo       = '����� <%s>> %s> ��� � ��������� ����� <%s>!';
   CmdKeyTest     = '�������� ������� ��������� � ��������� �����';
   CmdSectionNo   = '������ <%s> ��� � ��������� �����!';
   CmdSectionTest = '�������� ������� ������ � ��������� �����';
   CmdPrmYes      = '�������� <%s> ���� � ��������� �����.<OK>';
   CmdPrmNo       = '��������� <%s> ��� � ��������� �����!';
   CmdKeyValue    = '������ <%s> |���� <%s> |�������� ����� <%s> |';
   
   DelSessCapt    = '�������� ������!';
   DelFileCapt    = '�������� ����� ������!';
   DelSess        = '�������� ����� ������ ID = %s';
   DelSessYes     = '������ ����� ID = %s';

   CancelUser     = '�������� �������������!';
   ExitFromScan   = '����� �� ������������ �������� <%s> !';
   ErrScanDir     = '������ ������������ �������� <%s> !';
   ErrTaskRange   = '������ ������� ���������!';
   
{---------- ��������� �� �������  ---------------------------------------------}

   FileAccessErr     = '������ ������� � ����� <%s>!';
   FileAccessOk      = '������� � ����� <%s> ��������. <OK>';
   FileAccessCpt     = '�������� ������� � ����� ';
   FileAcceptCpt     = '��������� ������ ���������� �����';
   FileAddCpt        = '���������� �����';
   FileChangeAttr    = '��������� ��������� �����';
   FileCopyCpt       = '����������� �����';
   FileCreateCpt     = '�������� �����';
   FileDel           = '�������� ����� <%s> ������ <%s> �������. <OK>';
   FileDelAll        = '�������� ���� ������ ������ <%s> �������. <OK>';
   FileDelAllQstn    = '������� ��� ����� ������ <%s> ?';
   FileDelCancel     = '�������� ����� <%s> �������� �������������! <OK>';
   FileDelCapt       = '�������� �����-(��)!';
   FileDelCpt        = '�������� �����';
   FileDelErr        = '������ �������� ����� <%s> ������ - <%s>';
   FileDelErrCapt    = '������ �������� �����-(��)!';
   FileDelErrSess    = '������ �������� ���� ������ ������ - <%s>';
   FileDelNoSlct     = '��� ���������� ������ ��� ��������!'#13 + '������� ���������� ������� �����!';
   FileDelQstn       = '������� ���� <%s> ������ <%s> ?';
   FileFindCount     = '� �������� <%s> ������� <%d> ������. <OK>';
   FoundDir          = '������� ��������� - %d ';
   FindDirOnly       = '����� �������� <%s> ';
   FileFindDir       = '����� ������ � �������� <%s> ';
   FileListCpt       = '������ ������';
   FileListEmpty     = '������ ������ ������!';
   FileListFind      = '������ ������ ��� ������ ��������� ';
   FileListCount     = '����� ������ %d ������.';
   FileFindProcErr   = '������ � ��������� ������ ������ - <%s>!';
   FileFindZero      = '� �������� <%s> �� ������� ������!';
   FileIniWrite      = '���� <%s> ������� �� <%s> �������.<OK>';
   FileNameNew       = '����� ���';
   FileNameOld       = '������ ���';
   FileNoSlctCapt    = '��� ���������� ������!';
   FileNotFound      = '���� <%s> �� ������!';
   FileRemoved       = '����������� �����';
   FileRename        = '�������������� �����';
   FileSaveExcept    = '���������� ����� <%s> ������� ����������!';
   FilesNoWrite      = '����� �� �������� � ��!';
   FilesSlctFirst    = '������� ���������� ������� �����!';
   FileTransmitInDb  = '������� <%d> ������.';
   FileWriteCpt      = '������ ����� ������ � ��';
   FileWrite         = '������ ����� ������ � �� <%s> .<OK>';
   FileWriteCptErr   = '������ ������ �����!';
   FileWriteErrInDb  = '�%0.2d ���� <%s>> �� ������� � ��!';
   FileWriteInDb     = '�%0.2d ���� <%s>> Id = <%s> ������� � �� �������.<OK>';
   FileWriteResult   = '�������� ������� � �� <%d> ������.';
   FileWriteWait     = '����������� ������ ������ ������ � ��! ����� ���������� ��������!';
   FileWriteCptFromDb    = '������ ����� ������ �� �������!';
   FileWriteErrFromDb    = '������ ������ ����� <%s> �� ������� � ������� <%s> !';
   FileWriteFromDb       = '���� <%s> ������� �� ������� �������.<OK>';
   FileWriteResultFromDb = '�������� ������� �� ������� <%d> ������.';
   
   IdPspNoWrite   = '�� �������� ������ �� ��������';
   IdPspWrite     = '�� �������� ������ ��������';
   PspWriteCpt    = '������ �������� ������';
   PspNoWrite     = '������� ������ �� �������';
   PspWrite       = '������� ������ �������';
   
   LstFieldInput = '���� ����� �������� �������';
   LstFieldDb    = '���� ����� ��';

   MonitorNotAnswer    = '������� �� ��������!';
   MonitorStarted      = '������� �������� <%s> �������';
   MonitorStoped       = '������� �������� <%s> ����������';
   MonitorStopedForced = '������� �������� <%s> ���������� �������������';
   MonitorInitialState = '�������� ���������: ������� �������� <%s> �� ��������';
   MonitorError        = '��� ������ �������� �������� <%s> �������� ������. ���: %d, ���������: %s';
   MonitorCreatError   = '��� �������� ������ �������� �������� <%s> �������� ������ <%s> !';
   MonitorPreViewRun   = '�������� ������������ �������� �������� <%s>';
   
   SearchDirInDirDb = '����� ��������� � �������� �� <%s>';
   SessBreakTask    = '�������� ������� ���������� - BREAK_TASK!';
   SessBreakUser    = '�������� ������� ���������� <BREAK_TASK> �� ������������!';
   SessDelErrCapt   = '������ �������� ������!';
   SessDelErr       = '������ �������� ������ ��������� - <%s>';
   SessExist        = '����� ��������� <%s> ��� ���� � ��!';
   SessNoExist      = '����� ��������� <%s> ��� � ��!';
   SessReadBreak    = '������ ������ �������� - BREAK_TASK!';
   SessRewrite      = '���������� ������: %s';
   SessRewriteOk    = '���������� ������ %s ������ ������� <OK>';
   SessRewriteErr   = '��� ���������� ������ ��������� ������!';
   SessYesRewrite   = '���������� ������ ���������!';
   SessNoRewrite    = '���������� ������ ���������!';
   SessRewriteQuery = '����� ������������?';
   SessRewriteBreak = '���������� ������ �������� - BREAK_TASK!';
   SessWrite        = '����� ��������� <%s> ������� � �� <OK>';
   SessWriteOk      = '������� � �� <OK>';
   SessWriteNo      = '�� ������� � ��!';
   SessWritePsp     = '������� ������ ��������� <%s> ';
   SessWriteAdd     = '���.�� ������ ��������� <%s> ';
   SessWriteObsrv   = '�� ������ ������ ��������� <%s> ';
   SessWriteDwn     = '�� ����� ������ ������ ��������� <%s> ';
   SessWritePos     = '�� ��������� ������ ������ ��������� <%s> ';
   SessWriteCpt     = '������ ������ � ��!';
   SessWriteErrCpt  = '������ ������ ������!';
   SessWriteErr     = '����� ��������� <%s> �� ������� � ��!';
   SessWriteBreak   = '������ ������ �������� - BREAK_TASK!';
   SessNoFile       = '� ������ <%s> ��� ������!';
   SessFileLst      = '������ ������ �� ��: ';

   SettProgRun      = '��������� ��������� ���������!';
   SettProgNoConfig = '��������� �� ���������!'; 
   SettProgRunQuery = '��������� ��������� ���������? <YES/NO>';  
   
   NumOutRangeExprt = '����� <%d> ������� �� �������� ������� �������� ��������';
   SessExportFile   = '������� ������ �������';
   SessExportBreak  = '������� ������ ������� ������� �������������!';
   SessExprtCount   = '������� <%d> ������ �������';
   ExportGridInOk   = '������� ����� <%s> � ���� <%s> �������� �������.<Ok>';
   
   SessReadOk       = '����� ������� <%s> ������� �������������� � <%s>';
   SessReadErr      = '������ �������� ������ ������� <%s> !';

   TaskName         = '��� ������� <%s>';
   TaskFileName     = '������ ��� ����� ������� <%s>';
   TaskFileNoFound  = '���� ������� <%s> �� ������!';
   TaskNameEmpt     = '��� ������� ������!';

   TotalDirFound    = '����� ������� <%d> ���������.';
   TotalFileFound   = '����� ������� <%d> ������.';

   WriteFileDir     = '������ ������ �������� : <%s>';
   
   UnRegisteredAction= '�������������������� ��������!';

 implementation

end.

