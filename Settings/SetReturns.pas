unit SetReturns;

{(*}
(*------------------------------------------------------------------------------
 Delphi Code formatter source code

The Original Code is SetReturns.pas, released April 2000.
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

{ mostly spacing and line breaking +options }

{$I JcfGlobal.inc}

interface

uses JcfSetBase, SettingsTypes, SettingsStream;

type
  { rebreak lines has three modes:
    - off, don't rebreak lines
    - only if you can find a good spot to do it
      yes (if there is any spot to do it)
  }
  TWhenToRebreakLines = (rbOff, rbOnlyIfGood, rbUsually);

  TSetReturns = class(TSetBase)
  private
    { line breaking }
    feRebreakLines: TWhenToRebreakLines;
    fiMaxLineLength: integer;

    { return removal and adding }
    fbRemoveBadReturns: boolean;
    fbAddGoodReturns: boolean;
    fbUsesClauseOnePerLine: boolean;
    fbBreakAfterUses: boolean;

    fbRemoveExpressionReturns: boolean;
    fbRemoveVarReturns: boolean;
    fbRemovePropertyReturns: boolean;
    fbRemoveProcedureDefReturns: boolean;

    fbRemoveBlockBlankLines: boolean;
    fbRemoveVarBlankLines: boolean;
    fbRemoveProcHeaderBlankLines: boolean;

    fiNumReturnsAfterFinalEnd: integer;

    { returns on blocks }
    feBlockStyle, feBlockBeginStyle: TTriOptionStyle;
    feLabelStyle, feLabelBeginStyle: TTriOptionStyle;
    feCaseLabelStyle, feCaseBeginStyle: TTriOptionStyle;
    feCaseElseStyle, feCaseElseBeginStyle: TTriOptionStyle;
    feEndElseStyle: TTriOptionStyle;
    feElseIfStyle: TTriOptionStyle;
    feElseBeginStyle: TTriOptionStyle;

    { returns on compiler directives }
    feBeforeCompilerDirectUses: TTriOptionStyle;
    feBeforeCompilerDirectStatements: TTriOptionStyle;
    feBeforeCompilerDirectGeneral: TTriOptionStyle;
    feAfterCompilerDirectUses: TTriOptionStyle;
    feAfterCompilerDirectStatements: TTriOptionStyle;
    feAfterCompilerDirectGeneral: TTriOptionStyle;

    feReturnChars: TReturnChars;

    fbRemoveConsecutiveBlankLines: boolean;
    fiMaxConsecutiveBlankLines: integer;
    fiMaxBlankLinesInSection: integer;

    fiLinesBeforeProcedure: integer;
  public
    constructor Create;

    procedure WriteToStream(const pcOut: TSettingsOutput); override;
    procedure ReadFromStream(const pcStream: TSettingsInput); override;

    property RebreakLines: TWhenToRebreakLines read feRebreakLines write feRebreakLines;
    property MaxLineLength: integer read fiMaxLineLength write fiMaxLineLength;

    property NumReturnsAfterFinalEnd: integer
      read fiNumReturnsAfterFinalEnd write fiNumReturnsAfterFinalEnd;

    property RemoveBadReturns: boolean read fbRemoveBadReturns write fbRemoveBadReturns;
    property AddGoodReturns: boolean read fbAddGoodReturns write fbAddGoodReturns;
    property UsesClauseOnePerLine: boolean read fbUsesClauseOnePerLine
      write fbUsesClauseOnePerLine;
    property BreakAfterUses: boolean read fbBreakAfterUses write fbBreakAfterUses;

    property RemoveExpressionReturns: boolean
      read fbRemoveExpressionReturns write fbRemoveExpressionReturns;
    property RemoveVarReturns: boolean read fbRemoveVarReturns write fbRemoveVarReturns;
    property RemovePropertyReturns: boolean
      read fbRemovePropertyReturns write fbRemovePropertyReturns;
    property RemoveProcedureDefReturns: boolean
      read fbRemoveProcedureDefReturns write fbRemoveProcedureDefReturns;

    property RemoveBlockBlankLines: boolean
      read fbRemoveBlockBlankLines write fbRemoveBlockBlankLines;
    property RemoveVarBlankLines: boolean read fbRemoveVarBlankLines
      write fbRemoveVarBlankLines;
    property RemoveProcHeaderBlankLines: boolean
      read fbRemoveProcHeaderBlankLines write fbRemoveProcHeaderBlankLines;


    property BlockStyle: TTriOptionStyle read feBlockStyle write feBlockStyle;
    property BlockBeginStyle: TTriOptionStyle read feBlockBeginStyle write feBlockBeginStyle;
    property LabelStyle: TTriOptionStyle read feLabelStyle write feLabelStyle;
    property LabelBeginStyle: TTriOptionStyle read feLabelBeginStyle write feLabelBeginStyle;
    property CaseLabelStyle: TTriOptionStyle read feCaseLabelStyle write feCaseLabelStyle;
    property CaseBeginStyle: TTriOptionStyle read feCaseBeginStyle write feCaseBeginStyle;
    property CaseElseStyle: TTriOptionStyle read feCaseElseStyle write feCaseElseStyle;
    property CaseElseBeginStyle: TTriOptionStyle read feCaseElseBeginStyle write feCaseElseBeginStyle;

    property EndElseStyle: TTriOptionStyle read feEndElseStyle write feEndElseStyle;
    property ElseIfStyle: TTriOptionStyle read feElseIfStyle write feElseIfStyle;
    property ElseBeginStyle: TTriOptionStyle read feElseBeginStyle write feElseBeginStyle;

    property BeforeCompilerDirectUses: TTriOptionStyle read feBeforeCompilerDirectUses write feBeforeCompilerDirectUses;
    property BeforeCompilerDirectStatements: TTriOptionStyle read feBeforeCompilerDirectStatements write feBeforeCompilerDirectStatements;
    property BeforeCompilerDirectGeneral: TTriOptionStyle read feBeforeCompilerDirectGeneral write feBeforeCompilerDirectGeneral;
    property AfterCompilerDirectUses: TTriOptionStyle read feAfterCompilerDirectUses write feAfterCompilerDirectUses;
    property AfterCompilerDirectStatements: TTriOptionStyle read feAfterCompilerDirectStatements write feAfterCompilerDirectStatements;
    property AfterCompilerDirectGeneral: TTriOptionStyle read feAfterCompilerDirectGeneral write feAfterCompilerDirectGeneral;

    property ReturnChars: TReturnChars read feReturnChars write feReturnChars;

    property RemoveConsecutiveBlankLines: boolean
      read fbRemoveConsecutiveBlankLines write fbRemoveConsecutiveBlankLines;
    property MaxConsecutiveBlankLines: integer
      read fiMaxConsecutiveBlankLines write fiMaxConsecutiveBlankLines;
    property MaxBlankLinesInSection: integer
      read fiMaxBlankLinesInSection write fiMaxBlankLinesInSection;

    property LinesBeforeProcedure: integer read fiLinesBeforeProcedure write fiLinesBeforeProcedure;
  end;

implementation

const
  REG_WHEN_REBREAK_LINES = 'WhenRebreakLines';
  REG_MAX_LINE_LENGTH    = 'MaxLineLength';

  REG_NUM_RETURNS_AFTER_FINAL_END = 'NumReturnsAfterFinalEnd';

  //REG_ALIGN_ASSIGN = 'AlignAssign';

  REG_REMOVE_BAD_RETURNS = 'RemoveBadReturns';
  REG_ADD_GOOD_RETURNS   = 'AddGoodReturns';
  REG_USES_ONE_PER_LINE  = 'UsesOnePerLine';
  REG_BREAK_AFTER_USES   = 'BreakAfterUses';

  REG_REMOVE_EXPRESSION_RETURNS = 'RemoveExpressionReturns';
  REG_REMOVE_VAR_RETURNS      = 'RemoveVarReturns';
  REG_REMOVE_PROC_HEADER_BLANK_LINES = 'RemoveProcHeaderBlankLines';
  REG_REMOVE_PROPERTY_RETURNS = 'NoReturnsInProperty';
  REG_REMOVE_PROCEDURE_DEF_RETURNS = 'RemoveProcedureDefReturns';

  REG_REMOVE_BLOCK_BLANK_LINES = 'RemoveReturns';
  REG_REMOVE_VAR_BLANK_LINES   = 'RemoveVarBlankLines';

  { block line breaking styles }
  REG_BLOCK_STYLE      = 'Block';
  REG_BLOCK_BEGIN_STYLE = 'BlockBegin';
  REG_LABEL_STYLE      = 'Label';
  REG_LABEL_BEGIN_STYLE = 'LabelBegin';
  REG_CASE_LABEL_STYLE = 'CaseLabel';
  REG_CASE_BEGIN_STYLE = 'CaseBegin';
  REG_CASE_ELSE_STYLE  = 'CaseElse';
  REG_CASE_ELSE_BEGIN_STYLE  = 'CaseElseBegin';
  REG_END_ELSE_STYLE   = 'EndElse';
  REG_ELSE_IF_STYLE    = 'ElseIf';
  REG_ELSE_BEGIN_STYLE    = 'ElseBegin';

  REG_BEFORE_COMPILER_DIRECT_USES_STYLE = 'BeforeCompilerDirectUses';
  REG_BEFORE_COMPILER_DIRECT_STATEMENTS_STYLE = 'BeforeCompilerDirectStatements';
  REG_BEFORE_COMPILER_DIRECT_GENERAL_STYLE = 'BeforeCompilerDirectGeneral';
  REG_AFTER_COMPILER_DIRECT_USES_STYLE = 'AfterCompilerDirectUses';
  REG_AFTER_COMPILER_DIRECT_STATEMENTS_STYLE = 'AfterCompilerDirectStatements';
  REG_AFTER_COMPILER_DIRECT_GENERAL_STYLE = 'AfterCompilerDirectGeneral';

  REG_RETURN_CHARS = 'ReturnChars';

  REG_REMOVE_CONSECUTIVE_BLANK_LINES = 'RemoveConsecutiveBlankLines';
  REG_MAX_CONSECUTIVE_BLANK_LINES    = 'MaxConsecutiveBlankLines';
  REG_MAX_BLANK_LINES_IN_SECTION = 'MaxBlankLinesInSection';
  REG_LINES_BEFORE_PROCEDURE = 'LinesBeforeProcedure';

constructor TSetReturns.Create;
begin
  inherited;
  SetSection('Returns');
end;

procedure TSetReturns.ReadFromStream(const pcStream: TSettingsInput);
begin
  Assert(pcStream <> nil);

  feRebreakLines  := TWhenToRebreakLines(pcStream.Read(REG_WHEN_REBREAK_LINES,
    Ord(rbOnlyIfGood)));
  fiMaxLineLength := pcStream.Read(REG_MAX_LINE_LENGTH, 90);

  fiNumReturnsAfterFinalEnd := pcStream.Read(REG_NUM_RETURNS_AFTER_FINAL_END, 1);

  fbRemoveBadReturns := pcStream.Read(REG_REMOVE_BAD_RETURNS, True);
  fbAddGoodReturns   := pcStream.Read(REG_ADD_GOOD_RETURNS, True);
  fbUsesClauseOnePerLine := pcStream.Read(REG_USES_ONE_PER_LINE, False);
  fbBreakAfterUses := pcStream.Read(REG_BREAK_AFTER_USES, False);

  fbRemoveExpressionReturns := pcStream.Read(REG_REMOVE_EXPRESSION_RETURNS, False);
  fbRemoveVarReturns      := pcStream.Read(REG_REMOVE_VAR_RETURNS, True);
  fbRemovePropertyReturns := pcStream.Read(REG_REMOVE_PROPERTY_RETURNS, True);
  fbRemoveProcedureDefReturns := pcStream.Read(REG_REMOVE_PROCEDURE_DEF_RETURNS, False);

  fbRemoveBlockBlankLines := pcStream.Read(REG_REMOVE_BLOCK_BLANK_LINES, True);
  fbRemoveVarBlankLines   := pcStream.Read(REG_REMOVE_VAR_BLANK_LINES, False);
  fbRemoveProcHeaderBlankLines :=
    pcStream.Read(REG_REMOVE_PROC_HEADER_BLANK_LINES, True);

  feBlockStyle      := TTriOptionStyle(pcStream.Read(REG_BLOCK_STYLE, Ord(eLeave)));
  feBlockBeginStyle := TTriOptionStyle(pcStream.Read(REG_BLOCK_BEGIN_STYLE, Ord(eLeave)));
  feLabelStyle      := TTriOptionStyle(pcStream.Read(REG_LABEL_STYLE, Ord(eLeave)));
  feLabelBeginStyle := TTriOptionStyle(pcStream.Read(REG_LABEL_BEGIN_STYLE, Ord(eLeave)));
  feCaseLabelStyle  := TTriOptionStyle(pcStream.Read(REG_CASE_LABEL_STYLE, Ord(eLeave)));
  feCaseBeginStyle  := TTriOptionStyle(pcStream.Read(REG_CASE_BEGIN_STYLE, Ord(eLeave)));
  feCaseElseStyle   := TTriOptionStyle(pcStream.Read(REG_CASE_ELSE_STYLE, Ord(eLeave)));
  feCaseElseBeginStyle := TTriOptionStyle(pcStream.Read(REG_CASE_ELSE_BEGIN_STYLE, Ord(eLeave)));

  feEndElseStyle    := TTriOptionStyle(pcStream.Read(REG_END_ELSE_STYLE, Ord(eLeave)));
  feElseIfStyle     := TTriOptionStyle(pcStream.Read(REG_ELSE_IF_STYLE, Ord(eNever)));
  feElseBeginStyle  := TTriOptionStyle(pcStream.Read(REG_ELSE_BEGIN_STYLE, Ord(eNever)));

  feBeforeCompilerDirectUses := TTriOptionStyle(pcStream.Read(REG_BEFORE_COMPILER_DIRECT_USES_STYLE, Ord(eLeave)));
  feBeforeCompilerDirectStatements := TTriOptionStyle(pcStream.Read(REG_BEFORE_COMPILER_DIRECT_STATEMENTS_STYLE, Ord(eAlways)));
  feBeforeCompilerDirectGeneral := TTriOptionStyle(pcStream.Read(REG_BEFORE_COMPILER_DIRECT_GENERAL_STYLE, Ord(eLeave)));
  feAfterCompilerDirectUses := TTriOptionStyle(pcStream.Read(REG_AFTER_COMPILER_DIRECT_USES_STYLE, Ord(eLeave)));
  feAfterCompilerDirectStatements := TTriOptionStyle(pcStream.Read(REG_AFTER_COMPILER_DIRECT_STATEMENTS_STYLE, Ord(eAlways)));
  feAfterCompilerDirectGeneral := TTriOptionStyle(pcStream.Read(REG_AFTER_COMPILER_DIRECT_GENERAL_STYLE, Ord(eLeave)));

  feReturnChars := TReturnChars(pcStream.Read(REG_RETURN_CHARS, Ord(rcLeaveAsIs)));

  fbRemoveConsecutiveBlankLines := pcStream.Read(REG_REMOVE_CONSECUTIVE_BLANK_LINES, True);
  fiMaxConsecutiveBlankLines    := pcStream.Read(REG_MAX_CONSECUTIVE_BLANK_LINES, 4);
  fiMaxBlankLinesInSection := pcStream.Read(REG_MAX_BLANK_LINES_IN_SECTION, 1);
  fiLinesBeforeProcedure   := pcStream.Read(REG_LINES_BEFORE_PROCEDURE, 1);

end;

procedure TSetReturns.WriteToStream(const pcOut: TSettingsOutput);
begin
  Assert(pcOut <> nil);

  pcOut.Write(REG_WHEN_REBREAK_LINES, Ord(feRebreakLines));
  pcOut.Write(REG_MAX_LINE_LENGTH, fiMaxLineLength);

  pcOut.Write(REG_NUM_RETURNS_AFTER_FINAL_END, fiNumReturnsAfterFinalEnd);

  pcOut.Write(REG_REMOVE_BAD_RETURNS, fbRemoveBadReturns);
  pcOut.Write(REG_ADD_GOOD_RETURNS, fbAddGoodReturns);
  pcOut.Write(REG_USES_ONE_PER_LINE, UsesClauseOnePerLine);
  pcOut.Write(REG_BREAK_AFTER_USES, BreakAfterUses);

  pcOut.Write(REG_REMOVE_EXPRESSION_RETURNS, fbRemoveExpressionReturns);
  pcOut.Write(REG_REMOVE_VAR_RETURNS, fbRemoveVarReturns);
  pcOut.Write(REG_REMOVE_PROPERTY_RETURNS, fbRemovePropertyReturns);
  pcOut.Write(REG_REMOVE_PROCEDURE_DEF_RETURNS, fbRemoveProcedureDefReturns);

  pcOut.Write(REG_REMOVE_BLOCK_BLANK_LINES, fbRemoveBlockBlankLines);
  pcOut.Write(REG_REMOVE_VAR_BLANK_LINES, fbRemoveVarBlankLines);
  pcOut.Write(REG_REMOVE_PROC_HEADER_BLANK_LINES, fbRemoveProcHeaderBlankLines);

  pcOut.Write(REG_BLOCK_STYLE, Ord(feBlockStyle));
  pcOut.Write(REG_BLOCK_BEGIN_STYLE, Ord(feBlockBeginStyle));
  pcOut.Write(REG_LABEL_STYLE, Ord(feLabelStyle));
  pcOut.Write(REG_LABEL_BEGIN_STYLE, Ord(feLabelBeginStyle));
  pcOut.Write(REG_CASE_LABEL_STYLE, Ord(feCaseLabelStyle));
  pcOut.Write(REG_CASE_BEGIN_STYLE, Ord(feCaseBeginStyle));
  pcOut.Write(REG_CASE_ELSE_STYLE, Ord(feCaseElseStyle));
  pcOut.Write(REG_CASE_ELSE_BEGIN_STYLE, Ord(feCaseElseBeginStyle));

  pcOut.Write(REG_END_ELSE_STYLE, Ord(feEndElseStyle));
  pcOut.Write(REG_ELSE_IF_STYLE, Ord(feElseIfStyle));
  pcOut.Write(REG_ELSE_BEGIN_STYLE, Ord(feElseBeginStyle));

  pcOut.Write(REG_BEFORE_COMPILER_DIRECT_USES_STYLE, Ord(feBeforeCompilerDirectUses));
  pcOut.Write(REG_BEFORE_COMPILER_DIRECT_STATEMENTS_STYLE, Ord(feBeforeCompilerDirectStatements));
  pcOut.Write(REG_BEFORE_COMPILER_DIRECT_GENERAL_STYLE, Ord(feBeforeCompilerDirectGeneral));
  pcOut.Write(REG_AFTER_COMPILER_DIRECT_USES_STYLE, Ord(feAfterCompilerDirectUses));
  pcOut.Write(REG_AFTER_COMPILER_DIRECT_STATEMENTS_STYLE, Ord(feAfterCompilerDirectStatements));
  pcOut.Write(REG_AFTER_COMPILER_DIRECT_GENERAL_STYLE, Ord(feAfterCompilerDirectGeneral));

  pcOut.Write(REG_RETURN_CHARS, Ord(feReturnChars));

  pcOut.Write(REG_REMOVE_CONSECUTIVE_BLANK_LINES, fbRemoveConsecutiveBlankLines);
  pcOut.Write(REG_MAX_CONSECUTIVE_BLANK_LINES, fiMaxConsecutiveBlankLines);
  pcOut.Write(REG_MAX_BLANK_LINES_IN_SECTION, fiMaxBlankLinesInSection);

  pcOut.Write(REG_LINES_BEFORE_PROCEDURE, fiLinesBeforeProcedure);
end;

end.
