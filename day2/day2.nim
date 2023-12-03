import std/[nre, strutils]

func check_red(x: int) : bool = x <= 12
func check_green(x: int) : bool = x <= 13
func check_blue(x: int) : bool = x <= 14

func day2_part1(input: string): int =
    let re_split: Regex = re": |, |; "
    for line in input.splitLines():
        block loop:
            let line_split = line.split(re_split)
            let line_number = line_split[0].split(" ")[1].parseInt()
            for item in line_split[1..^1]:
                let item_split = item.split(" ")
                let item_color = item_split[1]
                let item_number = item_split[0].parseInt()
                case item_color
                of "red":
                    if not check_red(item_number): break loop
                of "green":
                    if not check_green(item_number): break loop
                of "blue":
                    if not check_blue(item_number): break loop
                
            result += line_number

when isMainModule:
    echo "Part one: ", day2_part1(readFile("input.txt"))