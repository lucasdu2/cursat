%token EOF (* end of file *)
%token EOC (* end of clause *)
%token <int * int> DIMACS (* number of variables * number of clauses *)
%token <int> LIT (* int representation of literals *)

(* NOTE: Cnf.t is of type int * int * Lit.t list list *)
%start <Cnf.t option> dimacs
%%

dimacs:
  | (nbvars, nbclauses) = DIMACS; cj = conjunction { (nbvars, nbclauses, cj) }

conjunction:
  | dj = disjunction; cj = conjunction { dj :: cj }
  | EOF { [] }

(* TODO: Try to figure out how error handling works in Menhir; then try to
disallow 0 LITs within this parser (instead of depending on lexer) *)
disjunction:
  | l = LIT; disjunction
    { if l > 0 then
        Lit.make_t (abs l) :: disjunction
      else
        Lit.make_f (abs l) :: disjunction }
  | EOC { [] }
