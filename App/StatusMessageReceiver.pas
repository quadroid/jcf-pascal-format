unit StatusMessageReceiver;

{(*}
(*------------------------------------------------------------------------------
 Delphi Code formatter source code

The Original Code is StatusMessageReceiver, released August 2008.
The Initial Developer of the Original Code is Anthony Steele.
Portions created by Anthony Steele are Copyright (C) 2008 Anthony Steele.
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

uses
  ConvertTypes;

type
  TStatusMesssageReceiver = class(TObject)
  public
    procedure OnReceiveStatusMessage(const psFile, psMessage: string;
      const peMessageType: TStatusMessageType;
      const piY, piX: integer);
  end;

implementation

uses
  SysUtils;

procedure TStatusMesssageReceiver.OnReceiveStatusMessage(const psFile, psMessage: string;
  const peMessageType: TStatusMessageType;
  const piY, piX: integer);
var
  lsPrefix: string;
  lsMessage: string;
begin
  case peMessageType of
  mtException, mtInputError, mtParseError:
    lsPrefix := 'Error';
  mtCodeWarning:
    lsPrefix := 'Warning';
  else
    lsPrefix := 'Info';
  end;

  if (piX < 0) or (piY < 0) then
    lsMessage := Format('[%s] %s: %s', [lsPrefix, psFile, psMessage]) // format with no line and col
  else
    lsMessage := Format('[%s] %s: (%s:%s) %s',
      [lsPrefix, psFile, IntToStr(piY), IntToStr(piX), psMessage]) // format with a line and col
  ;

  WriteLn(lsMessage);
end;

end.
