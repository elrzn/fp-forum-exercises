open Base
open OUnit

(* https://mschoebel.info/2012/03/15/analyzing-guess-aka-mastermind/ *)

let evaluate guess solution =
  let black =
    let f a b = if a = b then 1 else 0 in
    List.map2_exn guess solution ~f |> List.fold ~init:0 ~f:( + )
  in
  let white =
    let f a b =
      let cnt = List.count ~f:(fun x -> x = b) in
      a + min (cnt guess) (cnt solution)
    in
    Set.of_list (module Int) guess |> Set.fold ~init:(-black) ~f
  in
  (black, white)


let suite =
  "Mastermind evaluate"
  >::: [ ( "100% solution"
         >:: fun _ ->
         evaluate [ 1; 2; 3; 4 ] [ 1; 2; 3; 4 ] |> assert_equal (4, 0) )
       ; ( "partial solution with ordering failures"
         >:: fun _ -> evaluate [ 1; 3; 2 ] [ 1; 2; 3 ] |> assert_equal (1, 2)
         )
       ; ( "all wrong"
         >:: fun _ -> evaluate [ 1; 2; 3 ] [ 4; 5; 6 ] |> assert_equal (0, 0)
         )
       ]


let _ = run_test_tt_main suite
