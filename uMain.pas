unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Generics.Collections, hash,
  Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    bnDictionary: TButton;
    bnStringList: TButton;
    bnMyhashTable: TButton;
    lbHashTable: TLabel;
    bnInitArray: TButton;
    seSize: TSpinEdit;
    lbDictionary: TLabel;
    lbInitArray: TLabel;
    lbStringList: TLabel;
    procedure bnDictionaryClick(Sender: TObject);
    procedure bnStringListClick(Sender: TObject);
    procedure bnMyhashTableClick(Sender: TObject);
    procedure bnInitArrayClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FDataArray: TStringList;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

function RandomName(aLen : integer) : string;
var
  i : integer;
begin
  SetLength(Result, aLen);
  Result[1] := char(Random(26) + ord('A'));
  for i := 2 to aLen do
    Result[i] := char(Random(26) + ord('a'));
end;

{$R *.dfm}

procedure TForm1.bnInitArrayClick(Sender: TObject);
var
  i: Integer;
begin
  lbInitArray.Caption := 'Initialization...';
  Application.ProcessMessages;
  FDataArray.Clear;
  for i := 0 to seSize.Value - 1 do
    FDataArray.Add(RandomName(Random(19) + 1));
  lbInitArray.Caption := 'Is initialized';
  Application.ProcessMessages;
end;

procedure TForm1.bnDictionaryClick(Sender: TObject);
var
  i:Integer;
  dict: TDictionary<string, string>;
  bt, et: Integer;
  value: string;
begin
  dict := TDictionary<string, string>.Create;
  try
    bt := GetTickCount;
    for i := 0 to FDataArray.Count - 1 do
      if not dict.TryGetValue(FDataArray[i], value) then
        dict.Add(FDataArray[i], FDataArray[i]);
    et := GetTickCount;
    lbDictionary.Caption := Format('Time: %d, count records: %d', [et-bt, dict.Count]);
  finally
    dict.Free;
  end;
end;

procedure TForm1.bnStringListClick(Sender: TObject);
var
  sl: TStringList;
  i: Integer;
  bt, et: Integer;
begin
  sl := TStringList.Create;
  try
    bt := GetTickCount;
    for i := 0 to FDataArray.Count -1 do
      if sl.IndexOf(FDataArray[i]) = - 1 then
        sl.Add(FDataArray[i]);
    et := GetTickCount;
    lbStringList.Caption := Format('Time: %d, count records: %d', [et-bt, sl.Count]);
  finally
    sl.Free;
  end;
end;

procedure TForm1.bnMyhashTableClick(Sender: TObject);
var
  hash: THashTable;
  bt, et: Integer;
  i: Integer;
  sl: TStringList;
begin
  hash := THashTable.Create;
  sl := TStringList.Create;
  try
    bt := GetTickCount;
    hash.Init(FDataArray.Count);
    for i := 0 to FDataArray.Count -1 do
    begin
      hash.Add(FDataArray[i]);
      if hash.Add(FDataArray[i]) then
        sl.Add(FDataArray[i]);
    end;
    et := GetTickCount;
    lbHashTable.Caption := Format('Time: %d, count records: %d', [et-bt, hash.Count]);
  finally
    hash.Free;
    sl.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FDataArray := TStringList.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FDataArray.Free;
end;

end.
