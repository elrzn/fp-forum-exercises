open Base

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
  black * white
