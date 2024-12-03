module Main

import "std/datatypes/char.rl";

fn get_nums(@const @ref entry) {
    let aux = |@const @ref s| {
        let iter = 0;
        while Char::isnum(s[iter]) { iter += 1; }
        (int(s.substr(0, iter)), iter);
    };

    let n1, i = aux(entry);
    if entry[i] != ',' { none; }

    let n2, j = aux(entry.substr(i+1, len(entry)));
    if entry[i+j+1] != ')' { none; }

    some(n1*n2);
}

fn part2(@const @ref line) {
    let res, do = (0, true);

    foreach entry in line.split("mul(").filter(|k| { k != ""; }) {
        if do && Char::isnum(entry[0]) {
            res += get_nums(entry).unwrap_or(0);
        }

        entry.split("do")[1:].foreach(|p| {
            if len(p) >= 5 && p.substr(0, 5) == "n't()" {
                do = false;
            }
            else if len(p) >= 2 && p.substr(0, 2) == "()" {
                do = true;
            }
        });
    }

    res;
}

fn part1(@const @ref line) {
    line.split("mul(").filter(|k| { k != ""; }).fold(|entry, acc| {
        case Char::isnum(entry[0]) of {
            true = acc + get_nums(entry).unwrap_or(0);
            _ = acc;
        };
    }, 0);
}

# Boilerplate
with release = len(argv()) > 1 && argv()[1] == "release",
     fp = case release of {
         true = "2.in";
         _ = "1.in";
     }
in

@const $f"cat {fp}" |> let line;
println("part1: ", part1(line));
println("part2: ", part2(line));
