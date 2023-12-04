import std/[strutils, sequtils]

func day4(input: string, part: int): int =
    for line in input.splitLines():
        let line_split = line.split("|")
        let winning_numbers = line_split[0].split(": ")[1].splitWhitespace().mapIt(it.parseInt())
        let actual_numbers = line_split[1].splitWhitespace().mapIt(it.parseInt())
        let found_numbers = actual_numbers.filterIt(it in winning_numbers)
        var points = 0
        for num in found_numbers:
            if points == 0: points = 1
            else: points *= 2
        result += points

when isMainModule:
    echo "Part one: ", day4(readFile("input.txt"), 1)
    #echo "Part two: ", day4(readFile("input.txt"), 2)