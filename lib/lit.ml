module Sign = struct
  type t = T | F

  let neg sign =
    match sign with
    | T -> F
    | F -> T

  let of_bool v =
    match v with
    | true -> T
    | false -> F

  let to_bool sign =
    match sign with
    | T -> true
    | F -> false
end

module VarId = struct
  type t = int
end

type t = {
    sign : Sign.t;
    id   : VarId.t
  }

let make sign varid =
  { sign = sign;
    id = varid }

let make_t = make Sign.T
let make_f = make Sign.F

let sign lit = lit.sign
let id lit = lit.id

let neg lit = { lit with sign = Sign.neg lit.sign }

let to_string lit =
  match lit.sign with
  | Sign.T -> Printf.sprintf "T.%d" (lit.id)
  | Sign.F -> Printf.sprintf "F.%d" (lit.id)
