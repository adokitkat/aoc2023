import std/[nre, strtabs, strutils]

let wordToDigit = {
        "one":   "1",
        "two":   "2",
        "three": "3",
        "four":  "4",
        "five":  "5",
        "six":   "6",
        "seven": "7",
        "eight": "8",
        "nine":  "9"
    }.newStringTable

proc day1_match(input: string, r1: Regex, r2: Regex): int =
    for line in input.splitLines():
        let match1 = line.match(r1)
        if match1.isSome:
            let x = if len(match1.get.captures[0]) == 1: match1.get.captures[0]
                    else: wordToDigit[match1.get.captures[0]]
            let y = if len(match1.get.captures[1]) == 1: match1.get.captures[1]
                    else: wordToDigit[match1.get.captures[1]]
            result += parseInt(x & y)
        else:
            let match2 = line.match(r2)
            let x = if len(match2.get.captures[0]) == 1: match2.get.captures[0]
                    else: wordToDigit[match2.get.captures[0]]
            result += parseInt(x & x)

proc day1_part1(input: string): int =
    let re_2_decimals = re"(?U)^.*(\d).*?(\d).*$"
    let re_1_decimal = re"(?U)^.*(\d).*$"
    day1_match(input, re_2_decimals, re_1_decimal)

proc day1_part2(input: string): int =
    let re_2_decimals = re"(?U)^.*(\d|one|two|three|four|five|six|seven|eight|nine).*?(\d|one|two|three|four|five|six|seven|eight|nine).*$"
    let re_1_decimal = re"(?U)^.*(\d|one|two|three|four|five|six|seven|eight|nine).*$"
    day1_match(input, re_2_decimals, re_1_decimal)

when isMainModule:
    echo "Part one: ", day1_part1(readFile("input.txt"))
    echo "Part two: ", day1_part2(readFile("input.txt"))
