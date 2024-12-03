module Main

import "std/io.rl";
import "std/math.rl";

fn test(report) {
    let ok = true;

    with last = report[0],
         asc = last < report[1] in

    foreach num in report[1:] {
        if (last <= num && !asc)
            || (last >= num && asc)
            || (Math::abs(last - num) > 3) {
            ok = false;
            break;
        }
        last = num;
    }

    ok;
}

fn part2(@const @ref lines) {
    let safe = 0;

    with reports = lines.map(|line| {
        line
            .split(" ")
            .map(|k| { int(k); });
    }) in

    foreach report in reports {
        for i in 0 to len(report) {
            if test(report[0:i] + report[i+1:len(report)]) {
                safe += 1;
                break;
            }
        }
    }

    safe;
}

fn part1(@const @ref lines) {
    with reports = lines.map(|line| {
        line
            .split(" ")
            .map(|k| { int(k); });
    }) in

    reports.fold(|report, acc| {
        case test(report) of {
            true = acc+1;
            _ = acc;
        };
    }, 0);
}

with release = len(argv()) > 1 && argv()[1] == "release",
     fp = case release of {
         true = "2.in";
         _ = "1.in";
     }
in

# Boilerplate
@const let lines = IO::file_to_str(fp)
    .split("\n")
    .filter(|l| { l != ""; });

println("part1: ", part1(lines));
println("part2: ", part2(lines));
