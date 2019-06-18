let evaluate = (guess, solution) => {
  let black =
    List.map2((a, b) => a == b ? 1 : 0, guess, solution)
    |> List.fold_left((a, b) => a + b, 0);
  let white = {
    let count = (l, item) =>
      List.fold_left((a, b) => b == item ? a + 1 : a, 0, l);
    let f = (a, b) => a + min(count(guess, b), count(solution, b));
    List.sort_uniq(Pervasives.compare, guess) |> List.fold_left(f, - black);
  };
  (black, white);
};

Js.log(evaluate([1, 2, 3], [2, 3, 1]));
Js.log(evaluate([1, 2, 3], [1, 3, 5]));
Js.log(evaluate([1, 2], [1, 2]));