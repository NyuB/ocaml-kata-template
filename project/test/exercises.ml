open OUnit2
open Lib.Exercises

let rec string_list_printer_body n: string = match n with 
  | [] -> ""
  | h::t -> h ^ (if t != [] then ", " else "") ^ string_list_printer_body t

let string_list_printer l = "[ " ^ (string_list_printer_body l) ^" ]"

let string_list_tuple_printer (la, lb) = "( " ^ (string_list_printer la) ^ "," ^ (string_list_printer lb) ^" )"

let rec string_list_list_printer_body l: string = match l with 
  | [] -> ""
  | h::t -> "[" ^ (string_list_printer_body h) ^ "]" ^ (if t != [] then ", " else "") ^ string_list_list_printer_body t

let string_list_list_printer l = "[ " ^ (string_list_list_printer_body l) ^" ]"

let tests_last = "test last" >::: [
  "last [] is None" >:: (fun _ -> assert_equal None (last []));
  "last [a;b;c;d] is d" >:: (fun _ -> assert_equal (Some "d") (last ["a";"b";"c";"d"]));
  "last [a] is a" >:: (fun _ -> assert_equal (Some "a") (last ["a"]));
]

let tests_last_two = "test last_two" >::: [
  "last_two [] is None" >:: (fun _ -> assert_equal None (last_two []));
  "last_two [a;b;c;d] is (c, d)" >:: (fun _ -> assert_equal (Some ("c", "d")) (last_two ["a";"b";"c";"d"]));
  "last_two [c;d] is (c, d)" >:: (fun _ -> assert_equal (Some ("c", "d")) (last_two ["c";"d"]));
  "last_two [a] is None" >:: (fun _ -> assert_equal None (last_two ["a"]));
]

let tests_nth = "test nth" >::: [
  "nth [] 0 is None" >:: (fun _ -> assert_equal None (nth [] 0));
  "nth [] -1 is None" >:: (fun _ -> assert_equal None (nth [] (-1)));
  "nth [a] 1 is None" >:: (fun _ -> assert_equal None (nth ["a"] 1));
  "nth [a] 0 is a" >:: (fun _ -> assert_equal (Some "a") (nth ["a"] 0));
  "nth [a;b;c;d] 0 is a" >:: (fun _ -> assert_equal (Some "a") (nth ["a";"b";"c";"d"] 0));
  "nth [a;b;c;d] 1 is b" >:: (fun _ -> assert_equal (Some "b") (nth ["a";"b";"c";"d"] 1));
  "nth [a;b;c;d] 2 is c" >:: (fun _ -> assert_equal (Some "c") (nth ["a";"b";"c";"d"] 2));
  "nth [a;b;c;d] 3 is d" >:: (fun _ -> assert_equal (Some "d") (nth ["a";"b";"c";"d"] 3));
]

let tests_length = "test length" >::: [
  "length [] is 0" >:: (fun _ -> assert_equal 0 (length []));
  "length [a;b;c;d] is 4" >:: (fun _ -> assert_equal 4 (length ["a";"b";"c";"d"]));
  "length [a] is 1" >:: (fun _ -> assert_equal 1 (length ["a"]));
]

let tests_rev = "test rev" >::: [
  "rev [] is []" >:: (fun _ -> assert_equal [] (rev []));
  "rev [a] is [a]" >:: (fun _ -> assert_equal ["a"] (rev ["a"]));
  "rev [a;b;c;d] is [d;c;b;a]" >:: (fun _ -> assert_equal ["d";"c";"b";"a"] (rev ["a";"b";"c";"d"]));
]

let tests_is_palindrome = "test is_palindrome" >::: [
  "is_palindrome [] is true" >:: (fun _ -> assert_equal true (is_palindrome []));
  "is_palindrome [a] is true" >:: (fun _ -> assert_equal true (is_palindrome ["a"]));
  "is_palindrome [a;b;c;d] is false" >:: (fun _ -> assert_equal false (is_palindrome ["a";"b";"c";"d"]));
  "is_palindrome [a;b;a] is true" >:: (fun _ -> assert_equal true (is_palindrome ["a";"b";"a"]));
  "is_palindrome [a;b;b;a] is true" >:: (fun _ -> assert_equal true (is_palindrome ["a";"b";"b";"a"]));
]

let tests_flatten = let printer = string_list_printer in "test flatten" >::: [
  "flatten [] is []" >:: (fun ctxt -> assert_equal ~ctxt ~printer [] (flatten []));
  "flatten [a] is [a]" >:: (fun ctxt -> assert_equal ~ctxt ~printer ["a"] (flatten [One "a"]));
  "flatten [a;b;c;d] is [a;b;c;d]" >:: (fun ctxt -> assert_equal ~ctxt ~printer ["a"; "b"; "c"; "d"] (flatten [One "a"; One "b"; One "c"; One "d"]));
  (* "flatten [a;[]] is [a]" >:: (fun _ -> assert_equal ["a"] (flatten [One "a", Many []])); *)
  "flatten [[a]] is [a]" >:: (fun ctxt -> assert_equal ~ctxt ~printer ["a"] (flatten [Many [One "a"]]));
  "flatten [a;[b]] is [a;b]" >:: (fun ctxt -> assert_equal ~ctxt ~printer ["a";"b"] (flatten [One "a";Many [One "b"]]));
  "flatten [a;[b;[c;d]];e] is [a;b;c;d;e]" >:: (fun ctxt -> assert_equal ~ctxt ~printer ["a";"b";"c";"d";"e"] (flatten [One "a"; Many [One "b"; Many [One "c"; One "d"]];One "e"]));
]

let tests_compress = "test compress" >::: [
  "compress [] is []" >:: (fun _ -> assert_equal [] (compress []));
  "compress [a] is [a]" >:: (fun _ -> assert_equal ["a"] (compress ["a"]));
  "compress [a;b;c;d] is [a;b;c;d]" >:: (fun _ -> assert_equal ["a";"b";"c";"d"] (compress ["a";"b";"c";"d"]));
  "compress [a;a] is [a]" >:: (fun _ -> assert_equal ["a"] (compress ["a";"a"]));
  "compress [a;b;b;a] is [a;b;a]" >:: (fun _ -> assert_equal ["a";"b";"a"] (compress ["a";"b";"b";"a"]));
]

let tests_pack = let printer = string_list_list_printer in "test pack" >::: [
  "pack [] is []" >:: (fun ctxt -> assert_equal ~ctxt ~printer [] (pack []));
  "pack [a] is [a]" >:: (fun ctxt -> assert_equal ~ctxt ~printer [["a"]] (pack ["a"]));
  "pack [a;b;c;d] is [[a];[b];[c];d]" >:: (fun ctxt -> assert_equal ~ctxt ~printer [["a"];["b"];["c"];["d"]] (pack ["a";"b";"c";"d"]));
  "pack [a;a] is [a]" >:: (fun ctxt -> assert_equal ~ctxt ~printer [["a"; "a"]] (pack ["a";"a"]));
  "pack [a;b;b;a] is [a;b;a]" >:: (fun ctxt -> assert_equal ~ctxt ~printer [["a"]; ["b"; "b"]; ["a"]] (pack ["a";"b";"b";"a"]));
]

let tests_encode = "test encode" >::: [
  "encode [] is []" >:: (fun _ -> assert_equal [] (encode []));
  "encode [a] is [a]" >:: (fun _ -> assert_equal [(1, "a")] (encode ["a"]));
  "encode [a;b;c;d] is [(1, a);(1, b);(1, c);(1, d)]" >:: (fun _ -> assert_equal [(1, "a"); (1, "b"); (1, "c"); (1, "d")] (encode ["a";"b";"c";"d"]));
  "encode [a;a] is [(2, a)]" >:: (fun _ -> assert_equal [(2, "a")] (encode ["a";"a"]));
  "encode [a;b;b;a] is [(1, a);(2, b);(1, a)]" >:: (fun _ -> assert_equal [(1, "a"); (2, "b"); (1, "a")] (encode ["a";"b";"b";"a"]));
]

let tests_split = let printer = string_list_tuple_printer in "test split" >::: [
  "split [] 1 is ([], [])" >:: (fun ctxt -> assert_equal ~ctxt ~printer ([], []) (split [] 1));
  "split [a] 0 is ([], [a])" >:: (fun ctxt -> assert_equal ~ctxt ~printer ([], ["a"]) (split ["a"] 0));
  "split [a] -1 is ([], [a])" >:: (fun ctxt -> assert_equal ~ctxt ~printer ([], ["a"]) (split ["a"] (-1)));
  "split [a] 1 is ([a], [])" >:: (fun ctxt -> assert_equal ~ctxt ~printer (["a"], []) (split ["a"] 1));
  "split [a;b;c;d] 2 is ([a;b], [c;d])" >:: (fun ctxt -> assert_equal ~ctxt ~printer (["a"; "b"], ["c"; "d"]) (split ["a"; "b"; "c"; "d"] 2));
]

let tests_extract = let printer = string_list_list_printer in "test k_in_n" >::: [
  "extract 1 [] is []" >:: (fun ctxt -> assert_equal ~ctxt ~printer [] (extract 1 []));
  "extract 1 [a] is [[a]]" >:: (fun ctxt -> assert_equal ~ctxt ~printer [["a"]] (extract 1 ["a"]));
  "extract 2 [a] is []" >:: (fun ctxt -> assert_equal ~ctxt ~printer [] (extract 2 ["a"]));
  "extract 2 [a;b;c;d] is [[a;b]; [a;c]; [a;d]; [b;c]; [b;d]; [c;d])" >:: 
  (fun ctxt -> assert_equal ~ctxt ~printer [["a"; "b"]; ["a"; "c"]; ["a"; "d"]; ["b"; "c"]; ["b"; "d"]; ["c"; "d"]] (extract 2 ["a"; "b"; "c"; "d"]));
]

let () = 
  List.iter (fun test_suite -> run_test_tt_main test_suite) [
    tests_last; 
    tests_last_two; 
    tests_nth; 
    tests_length;
    tests_rev;
    tests_is_palindrome;
    tests_flatten;
    tests_compress;
    tests_pack;
    tests_encode;
    tests_split;
    tests_extract;
  ]