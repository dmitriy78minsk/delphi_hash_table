object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'CompareSpeed'
  ClientHeight = 186
  ClientWidth = 343
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbHashTable: TLabel
    Left = 97
    Top = 106
    Width = 58
    Height = 13
    Caption = 'lbHashTable'
  end
  object lbDictionary: TLabel
    Left = 97
    Top = 46
    Width = 56
    Height = 13
    Caption = 'lbDictionary'
  end
  object lbInitArray: TLabel
    Left = 168
    Top = 16
    Width = 4
    Height = 13
    Caption = '-'
  end
  object lbStringList: TLabel
    Left = 97
    Top = 75
    Width = 52
    Height = 13
    Caption = 'lbStringList'
  end
  object bnDictionary: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 25
    Caption = 'TDictionary'
    TabOrder = 0
    OnClick = bnDictionaryClick
  end
  object bnStringList: TButton
    Left = 8
    Top = 70
    Width = 75
    Height = 25
    Caption = 'TStringList'
    TabOrder = 1
    OnClick = bnStringListClick
  end
  object bnMyhashTable: TButton
    Left = 8
    Top = 101
    Width = 75
    Height = 25
    Caption = 'MyHashTable'
    TabOrder = 2
    OnClick = bnMyhashTableClick
  end
  object bnInitArray: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Init Array'
    TabOrder = 3
    OnClick = bnInitArrayClick
  end
  object seSize: TSpinEdit
    Left = 89
    Top = 10
    Width = 73
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 100000
  end
end
