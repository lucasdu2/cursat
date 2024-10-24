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

type var_id = int

type literal = {
    sign : Sign.t;
    id   : varid
  }

type value = (int * int * literal list list)
