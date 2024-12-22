{
  open Parser
  exception SyntaxError of string
}

(* general regex definitions *)
let digit = ['0' - '9']
let newline = '\r' | '\n' | "\r\n"
let white = [' ' '\t']+

(* DIMACS CNF-specific regex *)
let c = 'c'
let p = 'p' white "cnf" white digit+ white digit+

rule read =
    parse
    | white { read lexbuf }
    | newline+ { read lexbuf }
    | c { comment lexbuf; read lexbuf }
    | p { Scanf.sscanf (Lexing.lexeme lexbuf) "p cnf %d %d"
          (fun nvars nclauses -> DIMACS(nvars, nclauses)) }
    | '0' { EOC }
    | '-'? ['1'-'9']['0'-'9']* { LIT (int_of_string (Lexing.lexeme lexbuf)) }
    | eof { EOF }
    | _ { raise (SyntaxError (Printf.sprintf "no match for token %s (%d-%d)"
                                             (Lexing.lexeme lexbuf)
                                             (Lexing.lexeme_start lexbuf)
                                             (Lexing.lexeme_end lexbuf))) }
and comment = parse
    | eof { () }
    | newline { () }
    | _ { comment lexbuf }
