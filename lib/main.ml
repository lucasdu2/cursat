open Base
open Lexer
open Lexing

(* lexing and parsing for DIMACS CNF input files *)
let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_with_error lexbuf =
  try Parser.dimacs Lexer.read lexbuf with
  | SyntaxError msg ->
    fprintf stderr "%a: %s\n" print_position lexbuf msg;
    None
  | Parser.Error ->
    fprintf stderr "%a: syntax error\n" print_position lexbuf;
    exit (-1)

let rec parse_and_print lexbuf =
  match parse_with_error lexbuf with
  | Some value ->
    printf "%s\n" (Cnf.to_string value)
    parse_and_print lexbuf
  | None -> ()

let loop filename () =
  let inx = In_channel.create filename in
  let lexbuf = Lexing.from_channel inx in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
  parse_and_print lexbuf;
  In_channel.close inx

(* command-line parsing and printing *)
let gen_speclist () = [] (* NOTE: For now, no named arguments *)

let gen_banner () =
  "cursat (◕ᴥ◕ʋ)\n" ^
  "[written at the Recurse Center, Fall 2 2024, by Lucas Du]\n" ^
  (Printf.sprintf "--usage: %s  [options] input.cnf\n" Sys.argv.(0))

(* TODO: Figure out difference between Printf.printf and simply printf *)
let handle_filepath fpath =
  if fpath = "" then
    begin
      Arg.usage speclist banner;
      exit 1;
    end;
  if not (Sys.file_exists fpath) then
  begin
    Printf.eprintf "ERROR: file \"%s\" does not exist\n" fpath;
    exit 1;
  end;
  (* TODO: Eventually we'll need to call 'solve' on this file --- currently, we
     we just print it out to test the lexing/parsing *)
  loop fpath

let () =
  let speclist = gen_speclist () in
  let banner = gen_banner () in
  Arg.parse speclist (fun fpath -> handle_filepath fpath) banner
