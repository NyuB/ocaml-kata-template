(* Samples from https://ocaml.org/problems *)
val last : 'a list -> 'a option
val last_two : 'a list -> ('a * 'a) option
val nth : 'a list -> int -> 'a option
val length : 'a list -> int
val rev: 'a list -> 'a list
val is_palindrome : 'a list -> bool
type 'a list_node = 
    | One of 'a
    | Many of 'a list_node list
val flatten : 'a list_node list -> 'a list
val compress: 'a list -> 'a list
val pack: 'a list -> 'a list list
val encode: 'a list -> (int * 'a) list
val split: 'a list -> int -> 'a list * 'a list
val extract: int -> 'a list -> 'a list list