unit SpaceBeforeColon;

{ AFS 6 March 2003
  spaces (or not) before colon
}

{(*}
(*------------------------------------------------------------------------------
 Delphi Code formatter source code 

The Original Code is SpaceBeforeColon, released May 2003.
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

uses SwitchableVisitor;

type
  TSpaceBeforeColon = class(TSwitchableVisitor)
  protected
    function EnabledVisitSourceToken(const pcNode: TObject): boolean; override;
  public
    constructor Create; override;

    function IsIncludedInSettings: boolean; override;
  end;

implementation

uses
  { local }
  JcfStringUtils,
  JcfSettings, SetSpaces, SourceToken, Tokens, ParseTreeNodeType,
  FormatFlags, TokenUtils;

function SpacesBefore(const pt: TSourceToken): integer;
var
  lcSpaces: TSetSpaces;
begin
  Assert(pt.TokenType = ttColon);

  lcSpaces := FormatSettings.Spaces;

  if pt.HasParentNode(nFormalParams) and InRoundBrackets(pt) then
    Result := lcSpaces.SpacesBeforeColonParam{ in procedure params }
  else if pt.HasParentNode(nFunctionHeading) and not
    (pt.HasParentNode(nFormalParams)) then
    Result := lcSpaces.SpacesBeforeColonFn// function result type

  else if pt.HasParentNode(nVarSection) then
    Result := lcSpaces.SpacesBeforeColonVar// variable decl


  else if pt.HasParentNode(nConstSection) then
    Result := lcSpaces.SpacesBeforeColonConst// variable/const/type decl


  else if pt.HasParentNode(nTypeSection) then
  begin
    // type decl uses =, but there are colons in the fields of record defs and object types
    if pt.HasParentNode(ObjectTypes) then
      Result := lcSpaces.SpacesBeforeColonClassVar
    else if pt.HasParentNode(nRecordType) then
      Result := lcSpaces.SpacesBeforeColonRecordField
    else
    if pt.HasParentNode(nGeneric) then
      Result := lcSpaces.SpacesBeforeColonInGeneric
    else
    begin
      Result := 0;
      Assert(False, 'No context for colon ' + pt.DescribePosition);
    end;
  end
  else if pt.HasParentNode(nLabelDeclSection) then
    Result := lcSpaces.SpacesBeforeColonLabel
  else if InStatements(pt) then
  begin
    if IsCaseColon(pt) then
      Result := lcSpaces.SpacesBeforeColonCaseLabel
    else if IsLabelColon(pt) then
      Result := lcSpaces.SpacesBeforeColonLabel
    else
      Result := lcSpaces.SpacesBeforeColonLabel;
  end
  else if pt.HasParentNode(nAsm) then
    Result := 0// !!!

  else if pt.HasParentNode(nAttribute) then
    Result := 0// Delphi.Net attribute

  else
  begin
    Result := 0;
    // assertion failure brings the house down
    Assert(False, 'No context for colon ' + pt.DescribePosition);
  end;
end;


constructor TSpaceBeforeColon.Create;
begin
  inherited;
  FormatFlags := FormatFlags + [eAddSpace, eRemoveSpace];
end;

function TSpaceBeforeColon.EnabledVisitSourceToken(const pcNode: TObject): Boolean;
var
  lcSourceToken, lcPrev: TSourceToken;
  liSpaces: integer;
begin
  Result := False;
  if pcNode = nil then
    exit;

  lcSourceToken := TSourceToken(pcNode);

  if lcSourceToken.TokenType <> ttColon then
    exit;

  lcPrev := lcSourceToken.PriorToken;
  if lcPrev = nil then
    exit;

  liSpaces := SpacesBefore(lcSourceToken);

  if liSpaces > 0 then
  begin
    { modify the existing previous space, or make a new one? }
    if (lcPrev.TokenType = ttWhiteSpace) then
      lcPrev.SourceCode := StrRepeat(NativeSpace, liSpaces)
    else
    begin
      Result := True;
      InsertTokenBefore(lcSourceToken, NewSpace(liSpaces));
    end;
  end
  else
  if (lcPrev.TokenType = ttWhiteSpace) then
    lcPrev.SourceCode := ''{ remove the space }{ else we are already right };

end;

function TSpaceBeforeColon.IsIncludedInSettings: boolean;
begin
  Result := FormatSettings.Spaces.FixSpacing;
end;

end.
