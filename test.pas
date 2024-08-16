unit test;

(* JCF CLI test file *)

interface

uses CRT;

type
  IFace = interface
    ['{5E3C2BCA-56C8-46DE-959F-338AF5F69C1A}']
    procedure proc;
  end;
  
type TMyType = class
  [Subscribe]
  protected procedure proce(var params: TParams);
end;  

implementation

procedure myProcedure;
var s: String;
begin
  s := 'this is a string';
  writeln(s);
end;

function myFunction(aParam: string
; aParam2: real): boolean;
var i: integer;
begin
  var inline_var_decl := 777;

  // case for fix: inline list of variables
     var inline_var_decl2,         inline_var_decl3: string;
           var inline_var_decl5,             inline_var_decl6 := 888;
var inline_var_decl2_string,         inline_var_decl3_string: string :=    'this is a string';		   

  for i := 1 to 10 do
    if i < 10 then write(i, ',')
      else writeln(i);

  i := 1;
  repeat
    case i of
      1..9:
        for i := 1 to i do write(i, ',');
      10: begin
        writeln;
        writeln;
      end;
      else
        myProcedure;
    end;
  until i >= 10;

  result := true;
end;

//# main program
var
  c, r: Integer;
  s: String;
  a: Array of Integer;

BEGIN
  //! clear first
  ClrScr;

  SetLength(a, 10);
  FOR c := 0 TO High(a) DO
    a[c] := c;
  FOR c := 0 TO High(a) DO
    IF i < High(a) THEN write(a[c], ',')
      ELSE writeln;

  c := ScreenWidth; //* screen size
  r := ScreenHeight;
  s := 'Screen size: ';
  writeln(s, c, '×', r);

  write('Enter your name: '); //? input
  readln(s);
  writeln('Hello, ', s, '!'); //+ forgotten

  //-readln; // unnecessary
  // TODO: to-do next
END.
