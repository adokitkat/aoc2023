import std/[nre, strutils]

func check_red(x: int) : bool = x <= 12
func check_green(x: int) : bool = x <= 13
func check_blue(x: int) : bool = x <= 14

func day2(input: string, part: int): int =
    let re_split: Regex = re": |, |; "
    for line in input.splitLines():
        block loop:
            let line_split = line.split(re_split)
            let line_number = line_split[0].split(" ")[1].parseInt()
            var red, green, blue: int
            for item in line_split[1..^1]:
                let item_split = item.split(" ")
                let item_color = item_split[1]
                let item_number = item_split[0].parseInt()
                if part == 1:
                    case item_color
                    of "red":
                        if not check_red(item_number): break loop
                    of "green":
                        if not check_green(item_number): break loop
                    of "blue":
                        if not check_blue(item_number): break loop
                elif part == 2:
                    case item_color
                    of "red":
                        if item_number > red: red = item_number
                    of "green":
                        if item_number > green: green = item_number
                    of "blue":
                        if item_number > blue: blue = item_number
            if part == 1:
                result += line_number
            elif part == 2:
                result += red * green * blue

when isMainModule:
    echo "Part one: ", day2(readFile("input.txt"), 1)
    echo "Part two: ", day2(readFile("input.txt"), 2)