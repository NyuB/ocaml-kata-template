(* Samples from https://ocaml.org/problems *)

let rec last l =  match l with
  | [] -> None
  | [t] -> (Some t)
  | _::t -> last t

let rec last_two l = match l with
  | [] -> None
  | [_] -> None
  | a::[b] -> Some (a, b)
  | _::b::t -> last_two (b::t)

let rec nth l n = match (l,n) with
  | ([], _) -> None
  | (h::_, 0) -> Some h
  | (_::t, _) -> nth t (n-1)

let rec length_acc acc l = match l with
  | [] -> acc
  | _::t -> length_acc (acc + 1) t

let length l = length_acc 0 l

let rec rev_acc acc l = match l with
  | [] -> acc
  | h::t -> rev_acc (h::acc) t

let rev l = rev_acc [] l

let is_palindrome l = l = rev l

type 'a list_node =
  | One of 'a
  | Many of 'a list_node list

let rec flatten_acc_rev acc l = match l with
  | [] -> acc
  | (One e)::t -> flatten_acc_rev (e::acc) t
  | (Many le)::t -> flatten_acc_rev (flatten_acc_rev  acc le) t

let flatten l = rev (flatten_acc_rev [] l)

let rec compress_acc_rev acc l = match (acc, l) with
  | (_, []) -> acc
  | ([], h::t) -> compress_acc_rev [h] t
  | (a::_, b::t) -> if a = b then compress_acc_rev acc t else compress_acc_rev (b::acc) t

let compress l = rev (compress_acc_rev [] l)

let rec pack_acc_rev acc l = match (acc, l) with
  | (_, []) -> acc
  | ([], h::t) -> pack_acc_rev [[h]] t
  | ([]::at, h::t) -> pack_acc_rev ([h]::at) t (* Should not happen *)
  | ((current::_ as current_list)::at, h::t) -> if current = h then pack_acc_rev ((current::current_list)::at) t else pack_acc_rev ([h]::acc) t
let pack l = rev (pack_acc_rev [] l)

(* Reimplement head for error example *)
let head l = match l with
  | [] -> raise (Invalid_argument "Unexpected empty list")
  | h::_ -> h

let tuple_count_of_pack l = (length l, head l)

let encode l = l |> pack |> List.map tuple_count_of_pack
let rec split_acc acc index l = match l with
  | [] -> (rev acc, [])
  | h::t -> if index <= 0 then (rev acc, l) else split_acc (h::acc) (index-1) t
let split l index = split_acc [] index l



(* Non tail-recursive solution
let rec extract_acc acc k l = match (l, k) with
  | (_, 0) -> [List.rev acc]
  | ([], _) -> []
  | (h::t, n) -> 
      let pick_acc = h::acc and skip_acc = acc
      in let rec_pick = extract_acc pick_acc (n-1) t
      and rec_skip = extract_acc skip_acc n t
      in rec_pick@rec_skip

let extract k l = extract_acc []
*)

type 'a extract_item = {
  to_pick_count: int;
  available: 'a list;
  picked: 'a list;
}

let rec extract_tailrec_acc acc queue = match queue with
  | [] -> List.rev acc
  
  | { to_pick_count = 0; picked; _ }::t -> 
    let next_acc = (List.rev picked)::acc
    in extract_tailrec_acc next_acc t
  
  | { available = []; _}::t -> extract_tailrec_acc acc t
  
  | { to_pick_count; available = fork_item::next_available; picked }::t -> 
    let pick = { to_pick_count = to_pick_count - 1; available = next_available; picked = fork_item::picked }
    and skip = { to_pick_count; available = next_available; picked }
    in extract_tailrec_acc acc (pick::skip::t)
    
let extract k l = extract_tailrec_acc [] [{ to_pick_count = k; available = l; picked = [] }]