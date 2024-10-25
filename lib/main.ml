let gen_banner () =
  "cursat (written at RC Fall2 2024 by Lucas Du)\n" ^
  (Printf.sprintf "--usage: %s  [options] input.cnf\n" Sys.argv.(0))
