unit CommandLineConstants;

{(*}
(*------------------------------------------------------------------------------
 Delphi Code formatter source code

The Original Code is CommandLineConstants, released August 2008.
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
  JcfStringUtils,
  JcfVersionConsts;

const
  ABOUT_COMMANDLINE =
    'Pascal Code Format ' + PROGRAM_VERSION + NativeLineBreak +
    NativeLineBreak +
    'Object-Pascal source code formatter.' + NativeLineBreak +
    'Latest version at ' + PROGRAM_HOME_PAGE + NativeLineBreak +
    NativeLineBreak +
    'Usage: pascal-format [options] directory/file' + NativeLineBreak +
    NativeLineBreak +
    'Mode of operation:' + NativeLineBreak +
    '  -obfuscate: obfuscate mode or' + NativeLineBreak +
    '  -clarify: clarify mode.' + NativeLineBreak +
    '  -debug: print parsed token tree.' + NativeLineBreak +
    '   Default: clarify.' + NativeLineBreak +
    NativeLineBreak +
    'Mode of source:' + NativeLineBreak +
    '  -f Format a file: the file path must be specified.' + NativeLineBreak +
    '  -d Format a directory: the directory path must be specified.' + NativeLineBreak +
    '  -r Format a directory tree.' + NativeLineBreak +
    NativeLineBreak +
    'Mode of output:' + NativeLineBreak +
    '  -inplace: change the source file without backup.' + NativeLineBreak +
    '  -out: output to a separate file.' + NativeLineBreak +
    '  -backup: change the source file and leave a backup copy.' + NativeLineBreak +
    '   Default: inplace.' + NativeLineBreak +
    NativeLineBreak +
    'Other options:' + NativeLineBreak +
    '  -config=<path>: specify a configuration file.' + NativeLineBreak +
    '  -y: overwrite files without confirmation.' + NativeLineBreak +
    '  -?: display this help.';

implementation

end.
