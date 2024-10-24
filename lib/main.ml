let gen_banner () =
  "cursat (written at RC Fall2 2024 by Lucas Du)\n" ^
  (Printf.sprintf "--usage: %s  [options] input.cnf\n" Sys.argv.(0))

let () =
  let banner = gen_banner () in
  let filepath = ref "" in
  Arg.parse (fun v -> filepath := v) banner;
  if !filepath = "" then
    begin Arg.usage banner;
      exit 1
    end;

  if not (Sys.file_exists !filepath) then
    begin Printf.eprintf "ERROR: file \"%s\" does not exist\n" !filepath;
      exit 1
    end;
  let channel = open_in !filepath in

  try
    let (nvars, nclauses, clauses) = Parser.dimacs Lexer.token (Lexing.from_channel channel) in
    ignore (solve [] nvars nclauses clauses);
    close_in channel
  with
    e -> close_in channel; raise e
