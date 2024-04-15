unit ResStr_ClientKard;

interface

const
   CmdMax = 10; //МАХ число команд КАРДа
   InpCmd: array[1..CmdMax] of PChar = ('KARD.WRITE_DATA',   //запись сеанса
                                        'KARD.READ_DATA',    //чтение сеанса
                                        'KARD.REPLACE_DATA', //перезапись сеанса
                                        'STATE_CONTR',       //контроль состояния
                                        'BREAK_TASK',        //аварийное прерывание
                                        'KARD.SUMM_TABLE',   //суммарная инф. о сеансе(-ах)
                                        'KARD.DETAL_TABLE',  //детальная инф. осеансе(-ах)
                                        'KARD.WRITE_REFER',  //запись сеанса(пишим файлы короче заданных)
                                        'KARD.REPLACE_REFER',//перезапись сеанса(пишим файлы короче заданных)
                                        'KARD.OUT_DATA'      //перезапись сеанса(пишим файлы короче заданных)
                                                             //и передать эти же файлы в каталог OUT_PATH                       
                                        ); //масив зарегистрированных команд
                                      
   fDataInfo = '__DATA_INFO.TXT';//имя файла записи параметров в БД

   fDspInt = '### ### ### ### ##0';//формат-строка вывода на дисплей целых размеров

   MaxSmes = 2;//МАХ число команд Smes_Xp
   CmdSmes: array[1..MaxSmes] of string = ('RELOAD_IMG=%s', //команда перегрузить изображения
                                           'OPENFILE=%s'    //команда открыть изображения
                                          );
   RsltSmes = 'CANCEL';                                   //ответ отказ из SMES_XP
   
resourcestring

{+++++++++++ Алиас БД +++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
// Алиасы БД указаны в ResStr_SetServer.pas
// Local_Alias = 'Local_Kard' ;//алиас для файлов локальной БД
// Server_Alias= 'Server_Kard';//алиас для файлов серверной БД

{+++++++++++ Секции и переменные командного INI- файла ++++++++++++++++++++++++}
 sCMD   = 'COMMAND'; //секция команд
// sInpDt = 'INP_DATA';//секция входных данных
 sOptn  = 'OPTIONS'; //секция опций запроса
 sFltr  = 'FILTERS'; //секция фильтров для запроса
 sRslt  = 'RESULT';  //секция результата выполнения команд
 sRprt  = 'REPORT';  //секция ОТЧЕТА о результатах работы
 sOutDt = 'OUT_DATA';//секция выходных данных
 sImgInf= 'IMG_INF'; //секция выходной информации об изображении
 
{+++++++++++ Ключи командного INI- файла ++++++++++++++++++++++++++++++++++++++}
 pCMD1     = 'COMMAND1' ;//команда-параметр для исполнения
 pDataName = 'DATA_NAME';//параметр Имя сеанса архивирования
 pDataPath = 'DATA_PATH';//параметр путь к базовому каталогу
 pOutPath  = 'OUT_PATH' ;//параметр путь к каталогу назначению
 pSizeMax  = 'FILE_MAX_SIZE';//Задать МАХ размер файлов при операциях записи/копировании
 
{+++++++++++ Параметры командного INI- файла ++++++++++++++++++++++++++++++++++}
 pRslt     = 'RESULT'   ;//параметр результата
 pERROR    = 'ERROR';    //параметр результата
 pRprt     = 'REPORT';   //параметр результата
 pFldLst   = 'FIELD_LIST';//параметр список полей запроса

 vOK       = 'OK'   ;      //значение параметра - ОК
 vErr      = 'ERR';        //значение параметра - ERROR
 vStCntr   = 'STATE_CONTR';//значение параметра - STATE_CONTR - 
                           //проверка работы программы ClientKARDa

//+++++++ Наименования команд в INI-файле ++++++++++++++++++++++++++++++++++++++
{} 
 pWrite    = 'KARD.WRITE_DATA';   //параметр команды 'KARD.Write_DATA' 
 pWrtRefer = 'KARD.WRITE_REFER';  //параметр команды KARD.WRITE_REFER
 pRead     = 'KARD.READ_DATA';    //параметр команды 'KARD.READ_DATA'
 pReplace  = 'KARD.REPLACE_DATA'; //параметр команды 'KARD.REPLACE_DATA' 
 pRplcRefer= 'KARD.REPLACE_REFER';//параметр команды KARD.REPLACE_REFER 
 pSummTbl  = 'KARD.SUMM_TABLE';   //параметр команды KARD.SUMM_TABLE
 pDetalTbl = 'KARD.DETAL_TABLE';  //параметр команды KARD.DETAL_TABLE
 pOutData  = 'KARD.OUT_DATA';     //параметр команды KARD.OUT_DATA
 pStateCntr= 'KARD.STATE_CONTR';  //параметр команды KARD.STATE_CONTR
 pBreak    = 'KARD.BREAK_TASK';   //параметр команды KARD.BREAK_TASK

                           
{+++++++++++ Значения для командного INI- файла +++++++++++++++++++++++++++++++}
 ZS        = '_ZS';        //подстрока в имени файла проверки работы программы ClientKARDa
 sSubRefer = '_REFER';     //подстрока в имени файла 
 sSubData  = 'OUT_DATA';   //подстрока в имени файла 

{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}  

{+++++++++++ Расширение командного файла ++++++++++++++++++++++++++++++++++++++}
 Ext  = '.TSК'; //расширение командного файла

{+++++++++++ файл с текущими полями паспортных ИД сеанса ++++++++++++++++++++++}
 fLstField = 'ListField.txt';//имя файла списка текущих полей БД

{+++++++++++ настройки ФОРМ и КОМПОНЕНТОВ в них +++++++++++++++++++++++++++++++}
 iClientKard = 'Form_ClientKard.Ini';//имя IniFile-файла формы ClientKard.EXE
 HlpFile     = 'KARD_hlp.chm';       //имя файла помощи и справки
 
{+++++++++++ Имена LOG-файлов +++++++++++++++++++++++++++++++++++++++++++++++++}
 fLogClientDb= 'ClientKard' ;//имя файла записи лога работы ClientKard
 fLogCmnd    = 'CommandKard' ;//имя файла записи лога приема команд

{+++++++++++ Строки диалогов и сообщений ++++++++++++++++++++++++++++++++++++++}
   CmdCpt         = 'Обработка принятого файла';
   CmdBeg         = 'Начало обработки принятого файла задания <%s>';
   CmdEnd         = 'Конец обработки принятого файла задания <%s>';
   CmdTxt         = 'Принята команда <%s>. <OK> ';
   CmdErr         = 'Принятая команда <%s> не распознана';
   CmdRunExcept   = 'Обработка файла <%s> вызвало исключение!';
   CmdFileAccept  = 'Принят файл <%s> - командный файл КАРДа. <OK>';
   CmdFile        = 'Принятый файл <%s> является командным файлом КАРДа.<OK>';
   CmdNoFile      = 'Принятый файл <%s> не является командным файлом КАРДа!';
   CmdKeyYes      = 'Ключ <%s>> %s> есть в командном файле <%s>.<OK>';
   CmdKeyEmpt     = 'Ключ <%s>> %s> в командном файле <%s> пустой!';
   CmdKeyNo       = 'Ключа <%s>> %s> нет в командном файле <%s>!';
   CmdKeyTest     = 'Проверка наличии параметра в командном файле';
   CmdSectionNo   = 'Секции <%s> нет в командном файле!';
   CmdSectionTest = 'Проверка наличии секции в командном файле';
   CmdPrmYes      = 'Параметр <%s> есть в командном файле.<OK>';
   CmdPrmNo       = 'Параметра <%s> НЕТ в командном файле!';
   CmdKeyValue    = 'Секция <%s> |Ключ <%s> |Значение ключа <%s> |';
   
   DelSessCapt    = 'Удаление сеанса!';
   DelFileCapt    = 'Удаление файла сеанса!';
   DelSess        = 'Удаление всего сеанса ID = %s';
   DelSessYes     = 'Удален сеанс ID = %s';

   CancelUser     = 'Отменено пользователем!';
   ExitFromScan   = 'Выход из сканирования каталога <%s> !';
   ErrScanDir     = 'Ошибка сканирования каталога <%s> !';
   ErrTaskRange   = 'Ошибка задания диапазона!';
   
{---------- Сообщения об ошибках  ---------------------------------------------}

   FileAccessErr     = 'Ошибка доступа к файлу <%s>!';
   FileAccessOk      = 'Доступа к файлу <%s> разрешен. <OK>';
   FileAccessCpt     = 'Проверка доступа к файлу ';
   FileAcceptCpt     = 'Процедура приема командного файла';
   FileAddCpt        = 'Добавление файла';
   FileChangeAttr    = 'Изменение атрибутов файла';
   FileCopyCpt       = 'Копирование файла';
   FileCreateCpt     = 'Создание файла';
   FileDel           = 'Удаление файла <%s> сеанса <%s> успешно. <OK>';
   FileDelAll        = 'Удаление всех файлов сеанса <%s> успешно. <OK>';
   FileDelAllQstn    = 'Удалить ВСЕ файлы сеанса <%s> ?';
   FileDelCancel     = 'Удаление файла <%s> отменено пользователем! <OK>';
   FileDelCapt       = 'Удаление файла-(ов)!';
   FileDelCpt        = 'Удаление файла';
   FileDelErr        = 'Ошибка удаление файла <%s> сеанса - <%s>';
   FileDelErrCapt    = 'Ошибка удаление файла-(ов)!';
   FileDelErrSess    = 'Ошибка удаление ВСЕХ файлов сеанса - <%s>';
   FileDelNoSlct     = 'Нет выделенных файлов для удаления!'#13 + 'Сначало необходимо выбрать файлы!';
   FileDelQstn       = 'Удалить файл <%s> сеанса <%s> ?';
   FileFindCount     = 'В каталоге <%s> найдено <%d> файлов. <OK>';
   FoundDir          = 'Найдено каталогов - %d ';
   FindDirOnly       = 'Поиск каталоге <%s> ';
   FileFindDir       = 'Поиск файлов в каталоге <%s> ';
   FileListCpt       = 'Список файлов';
   FileListEmpty     = 'Список файлов пустой!';
   FileListFind      = 'Список файлов для поиска контекста ';
   FileListCount     = 'Всего задано %d файлов.';
   FileFindProcErr   = 'Ошибка в процедуре поиска файлов - <%s>!';
   FileFindZero      = 'В каталоге <%s> не найдено файлов!';
   FileIniWrite      = 'Файл <%s> записан на <%s> успешно.<OK>';
   FileNameNew       = 'Новое имя';
   FileNameOld       = 'Старое имя';
   FileNoSlctCapt    = 'Нет выделенных файлов!';
   FileNotFound      = 'Файл <%s> не найден!';
   FileRemoved       = 'Перемещение файла';
   FileRename        = 'Переименование файла';
   FileSaveExcept    = 'Сохранение файла <%s> вызвало исключение!';
   FilesNoWrite      = 'Файлы не записаны в БД!';
   FilesSlctFirst    = 'Сначало необходимо выбрать файлы!';
   FileTransmitInDb  = 'Послано <%d> файлов.';
   FileWriteCpt      = 'Запись файла Сеанса в БД';
   FileWrite         = 'Запись файла сеанса в БД <%s> .<OK>';
   FileWriteCptErr   = 'Ошибка записи файла!';
   FileWriteErrInDb  = '№%0.2d Файл <%s>> не записан в БД!';
   FileWriteInDb     = '№%0.2d Файл <%s>> Id = <%s> записан в БД успешно.<OK>';
   FileWriteResult   = 'Записано успешно в БД <%d> файлов.';
   FileWriteWait     = 'Выполняется запись файлов сеанса в БД! Ждите завершение операции!';
   FileWriteCptFromDb    = 'Запись файла сеанса на КЛИЕНТА!';
   FileWriteErrFromDb    = 'Ошибка записи файла <%s> на клиента в каталог <%s> !';
   FileWriteFromDb       = 'Файл <%s> записан на КЛИЕНТА успешно.<OK>';
   FileWriteResultFromDb = 'Записано успешно на КЛИЕНТА <%d> файлов.';
   
   IdPspNoWrite   = 'ИД паспорта сеанса НЕ записаны';
   IdPspWrite     = 'ИД паспорта сеанса записаны';
   PspWriteCpt    = 'Запись Паспорта сеанса';
   PspNoWrite     = 'Паспорт сеанса НЕ записан';
   PspWrite       = 'Паспорт сеанса записан';
   
   LstFieldInput = 'Лист полей входного задания';
   LstFieldDb    = 'Лист полей БД';

   MonitorNotAnswer    = 'Монитор не отвечает!';
   MonitorStarted      = 'Монитор каталога <%s> запущен';
   MonitorStoped       = 'Монитор каталога <%s> остановлен';
   MonitorStopedForced = 'Монитор каталога <%s> остановлен принудительно';
   MonitorInitialState = 'Исходное состояние: монитор каталога <%s> не работает';
   MonitorError        = 'При работе монитора каталога <%s> возникла ошибка. Код: %d, сообщение: %s';
   MonitorCreatError   = 'При создании потока монитора каталога <%s> возникла ошибка <%s> !';
   MonitorPreViewRun   = 'Выполнен предпросмотр входного каталога <%s>';
   
   SearchDirInDirDb = 'Поиск каталогов в каталоге БД <%s>';
   SessBreakTask    = 'Получена команда прерывания - BREAK_TASK!';
   SessBreakUser    = 'Получена команда прерывания <BREAK_TASK> от пользователя!';
   SessDelErrCapt   = 'Ошибка удаление сеанса!';
   SessDelErr       = 'Ошибка удаление сеанса архивации - <%s>';
   SessExist        = 'Сеанс архивации <%s> уже есть в БД!';
   SessNoExist      = 'Сеанс архивации <%s> нет в БД!';
   SessReadBreak    = 'Чтение сеанса прервана - BREAK_TASK!';
   SessRewrite      = 'Перезапись сеанса: %s';
   SessRewriteOk    = 'Перезапись сеанса %s прошла успешно <OK>';
   SessRewriteErr   = 'При перезаписи сеанса произошла ошибка!';
   SessYesRewrite   = 'Перезапись сеанса разрешена!';
   SessNoRewrite    = 'Перезапись сеанса запрещена!';
   SessRewriteQuery = 'Сеанс перезаписать?';
   SessRewriteBreak = 'ПереЗапись сеанса прервана - BREAK_TASK!';
   SessWrite        = 'Сеанс архивации <%s> записан в БД <OK>';
   SessWriteOk      = 'записан в БД <OK>';
   SessWriteNo      = 'не записан в БД!';
   SessWritePsp     = 'Паспорт сеанса архивации <%s> ';
   SessWriteAdd     = 'Доп.ИД сеанса архивации <%s> ';
   SessWriteObsrv   = 'ИД съемки сеанса архивации <%s> ';
   SessWriteDwn     = 'ИД витка сброса сеанса архивации <%s> ';
   SessWritePos     = 'ИД координат съемки сеанса архивации <%s> ';
   SessWriteCpt     = 'Запись сеанса в БД!';
   SessWriteErrCpt  = 'Ошибка записи сеанса!';
   SessWriteErr     = 'Сеанс архивации <%s> не записан в БД!';
   SessWriteBreak   = 'Запись сеанса прервана - BREAK_TASK!';
   SessNoFile       = 'В сеансе <%s> нет файлов!';
   SessFileLst      = 'Список файлов из БД: ';

   SettProgRun      = 'Выполните настройку программы!';
   SettProgNoConfig = 'Программа не настроена!'; 
   SettProgRunQuery = 'Выполнить настройку программы? <YES/NO>';  
   
   NumOutRangeExprt = 'Номер <%d> выходит за диапазон массива форматов экспорта';
   SessExportFile   = 'Экспорт файлов сеансов';
   SessExportBreak  = 'Экспорт файлов сеансов прерван пользователем!';
   SessExprtCount   = 'Экспорт <%d> файлов сеансов';
   ExportGridInOk   = 'Экспорт сетки <%s> в файл <%s> завершен успешно.<Ok>';
   
   SessReadOk       = 'Файлы задания <%s> успешно экспортированы в <%s>';
   SessReadErr      = 'Ошибка экспорта файлов задания <%s> !';

   TaskName         = 'Имя задания <%s>';
   TaskFileName     = 'Полное имя файла задания <%s>';
   TaskFileNoFound  = 'Файл задания <%s> не найден!';
   TaskNameEmpt     = 'Имя задания пустое!';

   TotalDirFound    = 'Всего найдено <%d> каталогов.';
   TotalFileFound   = 'Всего найдено <%d> файлов.';

   WriteFileDir     = 'Запись файлов каталога : <%s>';
   
   UnRegisteredAction= 'Незарегистрированное действие!';

 implementation

end.

