%token <string> COMMENT
%token EOF (* end of file *)
%token EOC (* end of clause *)
%token <int * int> DIMACS
%token <int> LIT

(* TODO: will need to define a Cnf type *)
%start <Cnf.value option> dimacs
%%

dimacs:
  | COMMENT { None }
  | (nbvars, nbclauses) = DIMACS; cj = conjunction
    { (nbvars, nbclauses, cj) }

conjunction:

disjunction:
