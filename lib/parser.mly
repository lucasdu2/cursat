%token EOF
%token EOC
%token <int * int> DIMACS
%token <int> LIT

%start <Dimacs.t option> dimacs
%%

dimacs:
  | d = DIMACS; f = conjunction { Some {preamble = d; formula = f} }
  | EOF { None };

conjunction:
  | dj = disjunction; cj = conjunction { dj :: cj }
  | EOF { [] }

(* NOTE: We currently rely on the lexer to ensure that no literals are 0. *)
disjunction:
  | l = LIT; dj = disjunction
    { if l > 0 then
        Lit.make_t (abs l) :: dj
      else
        Lit.make_f (abs l) :: dj }
  | EOC { [] }
