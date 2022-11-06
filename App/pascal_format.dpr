program pascal_format;

(*------------------------------------------------------------------------------
 Delphi Code formatter source code

The Original Code is JCF, released May 2003.
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

{
  FPC complete options to compile this project from command line:
  fpc pascal_format.dpr -Mobjfpc -Scghi -Px86_64 -B -CX -O3 -XXs -v
  -Fi../Include -Fu../lazutils -FU../Output -FE..
}

{$I JcfGlobal.inc}

uses
  SysUtils,
  {$ifdef UNIX}{$ifdef UseCThreads}cthreads,{$endif}{$endif}
  {$ifdef FPC}CustApp,{$endif}
  JcfStringUtils in '..\Utils\JcfStringUtils.pas',
  JcfFileUtils in '..\Utils\JcfFileUtils.pas',
  JcfSystemUtils in '..\Utils\JcfSystemUtils.pas',
  Converter in '..\ReadWrite\Converter.pas',
  FileConverter in '..\ReadWrite\FileConverter.pas',
  ConvertTypes in '..\ReadWrite\ConvertTypes.pas',
  BuildParseTree in '..\Parse\BuildParseTree.pas',
  BuildTokenList in '..\Parse\BuildTokenList.pas',
  ParseError in '..\Parse\ParseError.pas',
  ParseTreeNode in '..\Parse\ParseTreeNode.pas',
  ParseTreeNodeType in '..\Parse\ParseTreeNodeType.pas',
  SourceToken in '..\Parse\SourceToken.pas',
  SourceTokenList in '..\Parse\SourceTokenList.pas',
  VisitSetXY in '..\Process\VisitSetXY.pas',
  BaseVisitor in '..\Process\BaseVisitor.pas',
  JcfMiscFunctions in '..\Utils\JcfMiscFunctions.pas',
  SetUses in '..\Settings\SetUses.pas',
  JcfSetBase in '..\Settings\JcfSetBase.pas',
  JcfSettings in '..\Settings\JcfSettings.pas',
  SetAlign in '..\Settings\SetAlign.pas',
  SetCaps in '..\Settings\SetCaps.pas',
  SetClarify in '..\Settings\SetClarify.pas',
  SetFile in '..\Settings\SetFile.pas',
  SetIndent in '..\Settings\SetIndent.pas',
  SetObfuscate in '..\Settings\SetObfuscate.pas',
  SetReplace in '..\Settings\SetReplace.pas',
  SetReturns in '..\Settings\SetReturns.pas',
  SetSpaces in '..\Settings\SetSpaces.pas',
  SettingsStream in '..\Settings\Streams\SettingsStream.pas',
  RemoveUnneededWhiteSpace in '..\Process\Obfuscate\RemoveUnneededWhiteSpace.pas',
  FixCase in '..\Process\Obfuscate\FixCase.pas',
  RebreakLines in '..\Process\Obfuscate\RebreakLines.pas',
  ReduceWhiteSpace in '..\Process\Obfuscate\ReduceWhiteSpace.pas',
  RemoveComment in '..\Process\Obfuscate\RemoveComment.pas',
  RemoveConsecutiveWhiteSpace in '..\Process\Obfuscate\RemoveConsecutiveWhiteSpace.pas',
  RemoveReturn in '..\Process\Obfuscate\RemoveReturn.pas',
  WarnRealType in '..\Process\Warnings\WarnRealType.pas',
  WarnAssignToFunctionName in '..\Process\Warnings\WarnAssignToFunctionName.pas',
  WarnCaseNoElse in '..\Process\Warnings\WarnCaseNoElse.pas',
  WarnDestroy in '..\Process\Warnings\WarnDestroy.pas',
  WarnEmptyBlock in '..\Process\Warnings\WarnEmptyBlock.pas',
  Warning in '..\Process\Warnings\Warning.pas',
  TokenUtils in '..\Parse\TokenUtils.pas',
  NoSpaceBefore in '..\Process\Spacing\NoSpaceBefore.pas',
  NoSpaceAfter in '..\Process\Spacing\NoSpaceAfter.pas',
  SingleSpaceAfter in '..\Process\Spacing\SingleSpaceAfter.pas',
  SingleSpaceBefore in '..\Process\Spacing\SingleSpaceBefore.pas',
  ReturnAfter in '..\Process\Returns\ReturnAfter.pas',
  Nesting in '..\Process\Nesting.pas',
  VisitSetNesting in '..\Process\VisitSetNesting.pas',
  ReturnBefore in '..\Process\Returns\ReturnBefore.pas',
  NoReturnAfter in '..\Process\Returns\NoReturnAfter.pas',
  NoReturnBefore in '..\Process\Returns\NoReturnBefore.pas',
  AllProcesses in '..\Process\AllProcesses.pas',
  RemoveBlankLine in '..\Process\Obfuscate\RemoveBlankLine.pas',
  BlockStyles in '..\Process\Returns\BlockStyles.pas',
  SwitchableVisitor in '..\Process\SwitchableVisitor.pas',
  FormatFlags in '..\Process\FormatFlags.pas',
  TabToSpace in '..\Process\Spacing\TabToSpace.pas',
  SpaceToTab in '..\Process\Spacing\SpaceToTab.pas',
  SpecificWordCaps in '..\Process\Capitalisation\SpecificWordCaps.pas',
  Capitalisation in '..\Process\Capitalisation\Capitalisation.pas',
  Indenter in '..\Process\Indent\Indenter.pas',
  PropertyOnOneLine in '..\Process\Returns\PropertyOnOneLine.pas',
  SpaceBeforeColon in '..\Process\Spacing\SpaceBeforeColon.pas',
  VisitStripEmptySpace in '..\Process\VisitStripEmptySpace.pas',
  RemoveBlankLinesAfterProcHeader in '..\Process\Returns\RemoveBlankLinesAfterProcHeader.pas',
  RemoveBlankLinesInVars in '..\Process\Returns\RemoveBlankLinesInVars.pas',
  ReturnChars in '..\Process\Returns\ReturnChars.pas',
  RemoveReturnsBeforeEnd in '..\Process\Returns\RemoveReturnsBeforeEnd.pas',
  RemoveReturnsAfterBegin in '..\Process\Returns\RemoveReturnsAfterBegin.pas',
  LongLineBreaker in '..\Process\Returns\LongLineBreaker.pas',
  IntList in '..\Utils\IntList.pas',
  BasicStats in '..\Process\Info\BasicStats.pas',
  AlignConst in '..\Process\Align\AlignConst.pas',
  AlignBase in '..\Process\Align\AlignBase.pas',
  AlignAssign in '..\Process\Align\AlignAssign.pas',
  AlignVars in '..\Process\Align\AlignVars.pas',
  AlignTypedef in '..\Process\Align\AlignTypedef.pas',
  AlignComment in '..\Process\Align\AlignComment.pas',
  Tokens in '..\Parse\Tokens.pas',
  SetWordList in '..\Settings\SetWordList.pas',
  PreProcessorExpressionTokens in '..\Parse\PreProcessor\PreProcessorExpressionTokens.pas',
  PreProcessorExpressionParser in '..\Parse\PreProcessor\PreProcessorExpressionParser.pas',
  PreProcessorExpressionTokenise in '..\Parse\PreProcessor\PreProcessorExpressionTokenise.pas',
  JcfHelp in '..\Utils\JcfHelp.pas',
  SettingsTypes in '..\Settings\SettingsTypes.pas',
  SetPreProcessor in '..\Settings\SetPreProcessor.pas',
  UnitNameCaps in '..\Process\Capitalisation\UnitNameCaps.pas',
  RemoveSpaceAtLineEnd in '..\Process\Spacing\RemoveSpaceAtLineEnd.pas',
  FindReplace in '..\Process\Transform\FindReplace.pas',
  ReturnsAfterFinalEnd in '..\Process\Returns\ReturnsAfterFinalEnd.pas',
  PreProcessorParseTree in '..\Parse\PreProcessor\PreProcessorParseTree.pas',
  RemoveEmptyComment in '..\Process\RemoveEmptyComment.pas',
  RemoveConsecutiveReturns in '..\Process\Returns\RemoveConsecutiveReturns.pas',
  UsesClauseFindReplace in '..\Process\Transform\UsesClauseFindReplace.pas',
  UsesClauseInsert in '..\Process\Transform\UsesClauseInsert.pas',
  UsesClauseRemove in '..\Process\Transform\UsesClauseRemove.pas',
  MaxSpaces in '..\Process\Spacing\MaxSpaces.pas',
  SetComments in '..\Settings\SetComments.pas',
  TreeWalker in '..\Process\TreeWalker.pas',
  AddBlockEndSemicolon in '..\Process\Transform\AddBlockEndSemicolon.pas',
  AddBeginEnd in '..\Process\Transform\AddBeginEnd.pas',
  SetTransform in '..\Settings\SetTransform.pas',
  AlignField in '..\Process\Align\AlignField.pas',
  SortUses in '..\Process\Transform\SortUses.pas',
  SortUsesData in '..\Process\Transform\SortUsesData.pas',
  IdentifierCaps in '..\Process\Capitalisation\IdentifierCaps.pas',
  WarnUnusedParam in '..\Process\Warnings\WarnUnusedParam.pas',
  MoveSpaceToBeforeColon in '..\Process\Spacing\MoveSpaceToBeforeColon.pas',
  SetAsm in '..\Settings\SetAsm.pas',
  RemoveReturnsAfter in '..\Process\Returns\RemoveReturnsAfter.pas',
  IndentAsmParam in '..\Process\Indent\IndentAsmParam.pas',
  AsmKeywords in '..\Parse\AsmKeywords.pas',
  JcfUnicodeFiles in '..\Utils\JcfUnicodeFiles.pas',
  CommandLineReturnCode in 'CommandLineReturnCode.pas',
  CommandLineConstants in 'CommandLineConstants.pas',
  StatusMessageReceiver in 'StatusMessageReceiver.pas',
  JcfVersionConsts in 'JcfVersionConsts.pas';

var
  feReturnCode: TJcfCommandLineReturnCode;

  fbCmdLineShowHelp: boolean;
  fbQuietFail: boolean;
  fbCmdLineObfuscate: boolean;

  fbHasSourceMode:     boolean;
  feCmdLineSourceMode: TSourceMode;

  fbHasBackupMode:     boolean;
  feCmdLineBackupMode: TBackupMode;

  fbHasNamedConfigFile: boolean;
  fsConfigFileName:     string;

  fbYesAll: boolean;
  lsPath: string;
  lsPathOut: string;

  lcStatus: TStatusMesssageReceiver;

function StripParamPrefix(const ps: string): string;
begin
  Result := ps;
  if StrLeft(Result, 1) = '/' then
    Result := StrRestOf(Result, 2);
  if StrLeft(ps, 1) = '\' then
    Result := StrRestOf(Result, 2);
  if StrLeft(Result, 1) = '-' then
    Result := StrRestOf(Result, 2);
end;

procedure ParseCommandLine;
var
  liLoop: integer;
  lsOpt:  string;
  mbOutFilePath: boolean;
begin
  fbCmdLineShowHelp := (ParamCount = 0);
  fbQuietFail := False;
  fbCmdLineObfuscate := False;
  fbHasSourceMode := False;
  fbHasBackupMode := False;
  fbYesAll := False;
  fbHasNamedConfigFile := False;
  fsConfigFileName := '';

  for liLoop := 1 to ParamCount do
  begin
    { look for something that is not a -/\ param }
    lsOpt := ParamStr(liLoop);

    if (StrLeft(lsOpt, 1) <> '-') and {$ifndef UNIX} (StrLeft(lsOpt, 1) <> '/') and {$endif}
      (StrLeft(lsOpt, 1) <> '\') and (StrLeft(lsOpt, 1) <> '?') then
    begin
      // must be a path
      lsPath := StrTrimQuotes(lsOpt);
      if mbOutFilePath then
      begin
        mbOutFilePath := False;
        lsPathOut := lsPath;
        lsPath := '';
      end;
      continue;
    end;

    lsOpt := StripParamPrefix(lsOpt);
    mbOutFilePath := False;

    if lsOpt = '?' then
    begin
      fbCmdLineShowHelp := True;
      break;
    end else if AnsiSameText(lsOpt, 'obfuscate') then
      fbCmdLineObfuscate := True
    else if AnsiSameText(lsOpt, 'clarify') then
      fbCmdLineObfuscate := False
    else if AnsiSameText(lsOpt, 'inplace') then
    begin
      fbHasBackupMode     := True;
      feCmdLineBackupMode := cmInPlace;
    end else if AnsiSameText(lsOpt, 'out') then
    begin
      fbHasBackupMode     := True;
      feCmdLineBackupMode := cmSeparateOutput;
      mbOutFilePath := True;
    end else if AnsiSameText(lsOpt, 'backup') then
    begin
      fbHasBackupMode     := True;
      feCmdLineBackupMode := cmInPlaceWithBackup;
    end else if AnsiSameText(lsOpt, 'f') then
    begin
      fbHasSourceMode     := True;
      feCmdLineSourceMode := fmSingleFile;
    end else if AnsiSameText(lsOpt, 'd') then
    begin
      fbHasSourceMode     := True;
      feCmdLineSourceMode := fmDirectory;
    end else if AnsiSameText(lsOpt, 'r') then
    begin
      fbHasSourceMode     := True;
      feCmdLineSourceMode := fmDirectoryRecursive;
    end else if AnsiSameText(lsOpt, 'y') then
      fbYesAll := True
    else if StrFind('config', lsOpt) = 1 then
    begin
      fbHasNamedConfigFile := True;
      fsConfigFileName     := StrAfter('=', lsOpt);
    end else
    begin
      WriteLn('Unknown option ' + StrDoubleQuote(lsOpt));
      WriteLn;
      fbCmdLineShowHelp := True;
      break;
    end;
  end;

  if (lsPath = '') and not fbCmdLineShowHelp then
  begin
    WriteLn('No path found');
    WriteLn;
    fbCmdLineShowHelp := True;
    feReturnCode := rcNoPathFound;
  end;

  { read settings from file? }
  if fbHasNamedConfigFile and (fsConfigFileName <> '') then
    if FileExists(fsConfigFileName) then
      FormatSettingsFromFile(fsConfigFileName)
    else
    begin
      WriteLn('Named config file ' + fsConfigFileName + ' was not found');
      WriteLn;
      fbQuietFail := True;
      feReturnCode := rcConfigFileNotFound;
    end;

  { must have read from registry or file }
  if (not FormatSettings.HasRead) and (not fbQuietFail) then
  begin
    WriteLn('No settings to read');
    WriteLn;
    fbQuietFail := True;
    if feReturnCode = rcSuccess then
      feReturnCode := rcSettingsNotRead;
  end;

  { write to settings }
  FormatSettings.Obfuscate.Enabled := fbCmdLineObfuscate;
end;

procedure ConvertFiles;
var
  lcConvert: TFileConverter;
begin
  lcConvert := TFileConverter.Create;
  try
    lcConvert.OnStatusMessage := lcStatus.OnReceiveStatusMessage;
    // use command line settings
    lcConvert.YesAll := fbYesAll;
    lcConvert.GuiMessages := False;
    lcConvert.SourceMode := feCmdLineSourceMode;
    lcConvert.BackupMode := feCmdLineBackupMode;
    lcConvert.Input := lsPath;
    lcConvert.Output := lsPathOut;
    // do it!
    lcConvert.Convert;

    if lcConvert.ConvertError then
      feReturnCode := rcConvertError;

  finally
    lcConvert.Free;
  end;
end;

begin
{$ifdef FPC}
  CustomApplication := TCustomApplication.Create(nil);
  CustomApplication.Initialize;
{$endif}

  feReturnCode := rcSuccess;
  lcStatus := TStatusMesssageReceiver.Create;
  ParseCommandLine;

  { Format setttings will be altered by the command line.
    Do not persist these changes: do this after parsing the command line. }
  FormatSettings.WriteOnExit := False;

  if fbQuietFail then
     // do nothing
  else if fbCmdLineShowHelp then
    WriteLn(ABOUT_COMMANDLINE)
  else
    ConvertFiles;

  FreeAndNil(lcStatus);
  HaltOnError(feReturnCode);
end.
