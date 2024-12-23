open Base

type t = {
    preamble : int * int;
    formula  : Lit.t list list
  }

let to_string dimacs_cnf =
  let (nbvars, nbclauses) = dimacs_cnf.preamble in
  let formula = dimacs_cnf.formula in
  let rec clause_string = function
    | [] -> ""
    | lit :: rest ->
        let s = Lit.to_string lit in
          begin match rest with
            | [] -> s
            | _ -> s ^ " ∨ " ^ clause_string rest
          end
  in
  let rec formula_string = function
    | [] -> ""
    | clause :: rest ->
        let s = "(" ^ clause_string clause ^ ")" in
          begin match rest with
            | [] -> s
            | _ -> s ^ " ∧ " ^ formula_string rest
          end
  in
  Printf.sprintf
    "nbvars=%d nbclauses=%d %s"
    nbvars
    nbclauses
    (formula_string formula)
