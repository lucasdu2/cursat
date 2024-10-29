(lang dune 3.16)

(name cursat)

(generate_opam_files true)

(source
 (github lucasdu2/cursat))

(authors "Lucas Du")

(maintainers "Lucas Du")

(using menhir 3.0)

(package
 (name cursat)
 (synopsis "A toy CDCL SAT solver")
 (description "A toy CDCL SAT solver in OCaml, based on MiniSAT")
 (depends ocaml dune)

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
