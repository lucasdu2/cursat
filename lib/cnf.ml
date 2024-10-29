open Base

type t = (int * int * Lit.t list list)

let to_string cnf : t -> string =
  let nbvars = List.hd cnf in
  let nbclauses = List.nth cnf 2 in
  let rec clause_string = function
    | [] -> ""
    | lit :: rest ->
        let s = Lit.to_string lit in
          if rest = [] then s else s ^ " ∨ " ^ clause_string rest
  in
  let rec cnf_string = function
    | [] -> ""
    | clause :: rest ->
        let s = "(" ^ clause_string clause ^ ")" in
          if rest = [] then s else s ^ " ∧ " ^ cnf_string rest
  in
    Printf.sprintf "nbvars=%s nbclauses=%s %s" nbvars nbclauses (cnf_string cnf)
