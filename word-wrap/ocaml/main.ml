open Base

let word_wrap size content =
  let must_wrap row word =
    1
    + String.length word
    + List.length row
    + List.fold row ~init:0 ~f:(fun a b -> a + String.length b)
    > size
  in
  let f accum word =
    match accum with
    | [] ->
        [ [ word ] ]
    | row :: rows ->
        if must_wrap row word
        then [ word ] :: row :: rows
        else (word :: row) :: rows
  in
  String.split content ~on:(Char.of_string " ")
  |> List.fold ~init:[] ~f
  |> List.map ~f:List.rev
  |> List.map ~f:(String.concat ~sep:" ")
  |> List.rev
  |> String.concat ~sep:"\n"
