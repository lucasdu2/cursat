open Core
open Lexing
open Cursat

let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_with_error lexbuf =
  try Parser.dimacs Lexer.read lexbuf with
  | Lexer.SyntaxError msg ->
     fprintf stderr "%a: %s\n" print_position lexbuf msg;
     None
  | Parser.Error ->
     fprintf stderr "%a: syntax error\n" print_position lexbuf;
     exit (-1)

let rec parse_and_print lexbuf =
  match parse_with_error lexbuf with
  | Some value ->
     print_endline (Dimacs.to_string value);
     parse_and_print lexbuf
  | None -> ()

let loop filename () =
  let inx = In_channel.create filename in
  let lexbuf = Lexing.from_channel inx in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
  parse_and_print lexbuf;
  In_channel.close inx

let gen_banner () =
  "cursat (◕ᴥ◕ʋ)\n" ^
    "[written at the Recurse Center, Fall 2 2024, by Lucas Du]\n" ^
    "a minimal CDCL SAT solver for DIMACS inputs"

let () =
  let banner = gen_banner () in
  Command.basic_spec ~summary:banner
    Command.Spec.(empty +> anon ("filename" %: string))
    loop
  |> Command_unix.run
