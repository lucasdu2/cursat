open Base
open Stdio

(* polymorphic Vector data type *)
module Poly = struct
  type 'a t = {
    mutable elements : 'a array;
    mutable size : int;
    mutable capacity: int
  }

  (* constructors *)
  let empty () =
    { elements = [||];
    size = 0;
    capacity = 0 }

  let make size pad =
    if size < 0 then
      raise (Invalid_argument "Index out of range")
    else
      { elements = Array.make size pad;
      size = size;
      capacity = size }

  (* operations *)
  let size vec = vec.size

  let shrink vec shrink_by =
    let new_size = vec.size - shrink_by in
      if new_size < 0 then
        raise (Invalid_argument ("Cannot shrink by " ^ (string_of_int shrink_by)));
      vec.elements <- Array.sub vec.elements 0 new_size;
      vec.size <- new_size

  let grow vec grow_by pad =
    vec.elements <- Array.append vec.elements (Array.make grow_by pad);
    vec.capacity <- vec.capacity + grow_by


 (* TODO: Use Result type instead of exceptions *)
  let pop vec =
    if vec.size <= 0 then
      raise (Invalid_argument "Stack underflow");
    vec.size <- vec.size - 1;
    vec.elements.(vec.size)

  let push vec element =
    let new_size = vec.size + 1 in
    let grow_by = 32 in
      while new_size > vec.capacity do
        grow vec grow_by element
      done;
      vec.elements.(vec.size) <- element;
      vec.size <- new_size

  let nth n vec =
    if n < 0 || n >= vec.size then
      raise (Invalid_argument "Index out of bounds");
    vec.elements.(n)

  let clear vec = vec.size <- 0
end

(* elements of Vector --- can be of arbitrary type *)
module type Element = sig
  type t
end

(* Make functor to construct polymorphic Vector *)
(* module Make (e : Element) = struct *)

(* end *)
