﻿unit ReturnChars;

{(*}
(*------------------------------------------------------------------------------
 Delphi Code formatter source code 

The Original Code is ReturnChars, released May 2003.
The Initial Developer of the Original Code is Anthony Steele. 
Portions created by Anthony Steele are Copyright (C) 1999-2008 Anthony Steele.
All Rights Reserved. 
Contributor(s): Anthony Steele. 

The contents of this file are subject to the Mozilla Public License Version 1.1
(the "License"). you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.mozilla.org/NPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied.
See the License for the specific language governing rights and limitations 
under the License.

Alternatively, the contents of this file may be used under the terms of
the GNU General Public License Version 2 or later (the "GPL") 
See http://www.gnu.org/licenses/gpl.html
------------------------------------------------------------------------------*)
{*)}

{$I JcfGlobal.inc}

interface

uses SourceToken, SwitchableVisitor;

type
  TReturnChars = class(TSwitchableVisitor)
  protected
    function EnabledVisitSourceToken(const pcNode: TObject): Boolean; override;

  public
    constructor Create; override;

    function IsIncludedInSettings: boolean; override;
  end;

implementation

uses
  { local }
  JcfStringUtils,
  Tokens, SettingsTypes,
  SysUtils, JcfSettings;

{ TReturnChars }

constructor TReturnChars.Create;
begin
  inherited;

end;

function TReturnChars.EnabledVisitSourceToken(const pcNode: TObject): Boolean;
const
  strLf: string = NativeLineFeed;
  strCr: string = NativeCarriageReturn;
var
  lcSourceToken: TSourceToken;
begin
  Result := False;
  lcSourceToken := TSourceToken(pcNode);

  if lcSourceToken.TokenType <> ttReturn then
    // FIX: line breaks inside comments
    if lcSourceToken.TokenType = ttComment then
    begin
      // normalize
      lcSourceToken.SourceCode := StringReplace(lcSourceToken.SourceCode, NativeCrLf, strLf, [rfReplaceAll]);
{$if false}
      // is this really needed?..
      lcSourceToken.SourceCode := StringReplace(lcSourceToken.SourceCode, strCr, strLf, [rfReplaceAll]);
{$endif}
      case FormatSettings.Returns.ReturnChars of
      rcLeaveAsIs:;
      rcLinefeed:; // already done
      rcCrLf: lcSourceToken.SourceCode := StringReplace(lcSourceToken.SourceCode, strLf, NativeCrLf, [rfReplaceAll]);
      rcPlatform: lcSourceToken.SourceCode := StringReplace(lcSourceToken.SourceCode, strLf, NativeLineBreak, [rfReplaceAll]);
      end;
      exit;
    end else
      exit;

  case FormatSettings.Returns.ReturnChars of
  rcLeaveAsIs:;
  rcLinefeed: lcSourceToken.SourceCode := strLf;
  rcCrLf: lcSourceToken.SourceCode := NativeCrLf;
  rcPlatform: lcSourceToken.SourceCode := NativeLineBreak;
  end;
end;

function TReturnChars.IsIncludedInSettings: boolean;
begin
  Result := (FormatSettings.Returns.ReturnChars <> rcLeaveAsIs);
end;

end.
