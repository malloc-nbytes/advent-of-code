module Main

import "std/list.rl";
import "std/math.rl";

fn process(@const @ref lines, @ref lst1, @ref lst2) {
    foreach line in lines {
        let parts = line.split(" ")
                        .filter(|k| { k != ""; });
        lst1.append(int(parts[0]));
        lst2.append(int(parts[1]));
    }
}

fn part2(lines) {
    let lst1, lst2 = ([], []);
    process(lines, lst1, lst2);

    let found = Dict(int);

    lst2.foreach(|k| {
        if !found[k] {
            found.insert(k, 1);
        }
        else {
            found[k].unwrap() += 1;
        }
    });

    lst1.fold(|k, acc| {
        if found[k] {
            acc + k * found[k].unwrap();
        }
        acc;
    }, 0);
}

fn part1(lines) {
    let lst1, lst2 = ([], []);
    process(lines, lst1, lst2);

    List::quicksort(lst1, List::DEFAULT_INT_ASCEND_QUICKSORT);
    List::quicksort(lst2, List::DEFAULT_INT_ASCEND_QUICKSORT);

    let res = 0;

    for i in 0 to len(lst1) {
        res += Math::abs(lst1[i] - lst2[i]);
    }

    res;
}

with release = len(argv()) > 1 && argv()[1] == "release",
     fp = case release of {
         true = "2.in";
         _ = "1.in";
     }
in

$f"cat {fp}" |> let content;
@const let lines = content
    .split("\n")
    .filter(|l| { l != ""; });

println("part1: ", part1(lines));
println("part2: ", part2(lines));
