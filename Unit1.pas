unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, ComCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    TrackBar1: TTrackBar;
    XPManifest1: TXPManifest;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SetBrightness(brightness:byte);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  
function CM_Get_Device_Interface_List_SizeW(var ulLen: ULONG; InterfaceClassGuid: PGUID; pDeviceID: PWideChar; ulFlags: ULONG): DWORD; stdcall;               external 'SetupApi.dll' name 'CM_Get_Device_Interface_List_SizeW';
function CM_Get_Device_Interface_ListW(InterfaceClassGuid: PGUID; pDeviceID: PWideChar; Buffer: PWideChar; BufferLen: ULONG; ulFlags: ULONG): DWORD; stdcall; external 'SetupApi.dll' name 'CM_Get_Device_Interface_ListW';


var
  Form1: TForm1;
  DevName: string = '';
implementation

{$R *.dfm}


procedure TForm1.SetBrightness(brightness:byte);
var DevHandle: THandle;
    ov: OVERLAPPED;
    bw: DWORD;
    data_out: array [0..63] of byte;
begin
  DevHandle := CreateFile( PChar(devName), GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
  If DevHandle <> INVALID_HANDLE_VALUE then begin
    ZeroMemory(@ov, SizeOf(OVERLAPPED));
    ZeroMemory(@data_out,Length(data_out));
    data_out[0]:=$04;
    data_out[1]:=$AA;
    data_out[2]:=$01;
    data_out[6]:=byte(brightness); 
    WriteFile(DevHandle,data_out,Length(data_out),bw,@ov);
    CloseHandle(DevHandle);
  end;
end;


procedure TForm1.TrackBar1Change(Sender: TObject);
begin
SetBrightness(TrackBar1.Position);
end;

procedure TForm1.FormCreate(Sender: TObject);
var DevsListSize,i    : DWORD;
    pszDeviceInterface: pWideChar;
    HID_GUIid         : TGUID;
begin
  HID_GUIid:=StringToGUID('{4D1E55B2-F16F-11CF-88CB-001111000030}');
  CM_Get_Device_Interface_List_SizeW(&DevsListSize, @HID_GUIid, nil, 0);
  GetMem(pszDeviceInterface,DevsListSize);
  CM_Get_Device_Interface_ListW(@HID_GUIid,nil,pszDeviceInterface,DevsListSize,0);

  i:=0;
  while i<DevsListSize-1 do begin
    devName:= WideCharToString(pszDeviceInterface+i);
    i:=i+1+Length(devName);
    if Pos(UpperCase('HID#VID_0EEF&PID_0005&Col02'), UpperCase(DevName))>0 then break else DevName:='';
  end;
  if DevName='' then begin
    TrackBar1.Visible:=false;
    Label1.Visible:=True;
  end;
end;

end.
