unit hash;

interface

uses
  System.Classes;

type
  PHashedItem = ^THashedItem;
  THashedItem = packed record
    hiNext: PHashedItem;
    Key: string;
  end;

// hash table with closed addressing
  THashTable = class
  private
    // array with simple numbers
    FSimpleNumbers: TBits;
    FList: TList;
    FCount: Integer;
    // calc simple numbers
    procedure CalcByEstrogen(Size: Integer);
    procedure DeleteList;
    // get nearest simple number
    function GetNearestSimple(Index: Integer): Integer;
    function GetCount: Integer;
  protected
  public
    constructor Create;
    destructor Destroy; override;

    function Init(Size: Integer): Boolean;
    function Add(Key: string): Boolean;
    function IsIdentical(const S1: string; const S2: string): Boolean;
    property Count: Integer read GetCount;
  end;

implementation

function TDPJWHash(const aKey       : string;
                         aTableSize : integer) : integer;
var
  G : longint;
  i : integer;
  Hash : longint;
begin
  Hash := 0;
  for i := 1 to length(aKey) do begin
    Hash := (Hash shl 4) + ord(aKey[i]);
    G := Hash and $F0000000;
    if (G <> 0) then
      Hash := (Hash xor (G shr 24)) xor G;
  end;
  Result := Hash mod aTableSize;
end;

{ THashTable }

function THashTable.Add(Key: string): Boolean;
var
  hashIndex: Integer;
  head, item: PHashedItem;
begin
  Result := False;
  hashIndex := TDPJWHash(Key, FList.Count);
  if FList[hashIndex] = nil then
  begin
    New(item);
    item.Key := Key;
    item.hiNext := nil;
    FList[hashIndex] := item;
    Result := True;
  end
  else
  begin
    head := PHashedItem(FList[hashIndex]);
    while head <> nil do
    begin
      if IsIdentical(head.Key, Key) then
      begin
        Result := False;
        Break;
      end
      else
      begin
        if head.hiNext = nil then
        begin
          New(item);
          item.Key := Key;
          item.hiNext := nil;
          head.hiNext := item;
          Result := True;
          Break;
        end
        else
          head := head.hiNext;
      end;
    end;
  end;
end;

procedure THashTable.CalcByEstrogen(Size: Integer);
var
  index: Integer;
  delta: Integer;
  curNumber: Integer;
begin
  FSimpleNumbers.Size := Size;

  curNumber := 2;
  while curNumber <= Trunc(Sqrt(Size)) do
  begin
    delta := 2;
    index := curNumber*delta;
    while index <= Size - 1 do
    begin
      FSimpleNumbers[index] := True;
      Inc(delta);
      index := curNumber*delta;
    end;
    Inc(curNumber);
  end;
end;

constructor THashTable.Create;
begin
  FSimpleNumbers := TBits.Create;
  FList := TList.Create;
  FCount := -1;
end;

procedure THashTable.DeleteList;
var
  i: Integer;
  item, nextItem: PHashedItem;
begin
  for i := 0 to FList.Count - 1 do
    if FList[i] <> nil then
    begin
      item := PHashedItem(FList[i]);
      nextItem := item.hiNext;
      while item <> nil do
      begin
        Dispose(item);
        if nextItem <> nil then
        begin
          item := nextItem;
          nextItem := item.hiNext;
        end
        else
          Break;
      end;
    end;
  FList.Free;
end;

destructor THashTable.Destroy;
begin
  FSimpleNumbers.Free;
  DeleteList;
  inherited;
end;

function THashTable.GetCount: Integer;
var
  i: Integer;
  item, nextItem: PHashedItem;
begin
  Result := 0;
  for i := 0 to FList.Count - 1 do
    if FList[i] <> nil then
    begin
      item := PHashedItem(FList[i]);
      nextItem := item.hiNext;
      Inc(Result);
      while item <> nil do
      begin
        if nextItem <> nil then
        begin
          item := nextItem;
          nextItem := item.hiNext;
          Inc(Result);
        end
        else
          Break;
      end;
    end;
end;

function THashTable.GetNearestSimple(Index: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  if Index < FSimpleNumbers.Size then
  for i := index to FSimpleNumbers.Size - 1 do
    if not FSimpleNumbers[i] then
    begin
      Result := i;
      Break;
    end;
end;

function THashTable.Init(Size: Integer): Boolean;
begin
  // calc simple numbers
  CalcByEstrogen(Trunc(Size*1.5));
  FCount := GetNearestSimple(Size);
  Result := FCount > -1;

  if FCount > -1 then
  begin
    FList.Count := FCount;
  end;
end;

function THashTable.IsIdentical(const S1, S2: string): Boolean;
var
  i: Integer;
begin
  Result := Length(S1) = Length(S2);
  if Result then
    for i := 0 to Length(S1) - 1 do
      if S1[i] <> S2[i] then
      begin
        Result := False;
        Break;
      end;
end;

end.
