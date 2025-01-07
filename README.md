# cursat
A minimal, (re)cursed CDCL SAT solver in OCaml.

## An incremental approach
1. Get minimal DPLL implementation for clause constraints working. This entails:
   a) getting basic data structures set up
   b) getting DIMACS parsing/lexing working
   c) setting up propagation logic as described in MiniSAT paper (a scalable propagation method)
   d) using simple first-available logic for variable order in DPLL search
2. Get watcher lists/two watched literals strategy working.
3. Get clause-learning (as described in the MiniSAT paper) working.
4. Add basic logic for activity heuristics. This entails:
   a) setting up the increment/decay factor logic
   b) using activity values to sort variable order for DPLL search
5. Add basic pruning heuristics. This entails:
   a) setting up periodic constraint removal
       i) using activity values as a prioritization guide
       ii) implementing "locked" clause logic
       iii) and making sure we avoid removing such locked clauses
   b) implementing search restarts after a certain number of conflicts in a search path
6. Generalize the constraint interface beyond clauses (following guidance in MiniSAT paper).
7. Modify solver to support incremental SAT (again, following MiniSAT guidance).
