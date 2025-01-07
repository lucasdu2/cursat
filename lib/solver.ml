open Base

module Poly = struct
  type 'a t = {
    constraints : 'a Vector.Poly.t;
    learned     : 'a Vector.Poly.t;
  }
  (* constructors *)
  (* TODO *)
  (* functions for learning *)
  let analyze = ()
  let record = ()
  let undo_one = ()
  let assume = ()
  let cancel = ()
  let cancel_until = ()
end

module type Constraint = sig
  type t
  val remove : t Poly.t -> unit
  val propagate : t Poly.t -> Lit.t -> unit
  val simplify : t Poly.t -> unit
  val undo : t Poly.t -> Lit.t -> unit
  val calc_reason : t Poly.t -> Lit.t -> Lit.t Vector.Poly.t -> unit
end

module Make (C : Constraint) = struct

end
