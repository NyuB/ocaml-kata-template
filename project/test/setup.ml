(* Simple tests to test project setup *)

open OUnit2
let tests_setup = "test project setup" >::: [
  "true is true" >:: (fun _ -> assert_equal true true);
  "1 < 2" >:: (fun _ -> assert_bool "Expected 1 to be lower than 2" (1 < 2));
  (* Uncomment the next test to demostrate test failure *)
  (* "[] = [42]" >:: (fun _ -> assert_bool "Expected [] to equal [42]" ([] = [42])); *)
]

let () =  run_test_tt_main tests_setup