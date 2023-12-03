import strutils, sequtils

type SymbolType = enum
    numberType, symbolType, dotType, newLineType

func charToSymbolType(c: char): SymbolType =
    if c == '.': dotType
    elif c == '\n': newLineType
    elif c in '0'..'9': numberType
    else: symbolType

proc getNumber(input: string, pos: int): int =
    var curr_pos = pos
    var pos_start: int
    while charToSymbolType(input[curr_pos]) == numberType:
        if curr_pos-1 < 0 or charToSymbolType(input[curr_pos-1]) != numberType: break
        curr_pos -= 1
    pos_start = curr_pos
    while charToSymbolType(input[curr_pos]) == numberType:
        if curr_pos+1 > input.len or charToSymbolType(input[curr_pos+1]) != numberType: break
        curr_pos += 1
    return parseInt(input[pos_start..curr_pos])

func findNumber(input: string, pos: int, line_len: int): seq[int] =
    if pos-1 >= 0:
        if charToSymbolType(input[pos-1]) == numberType:
            result.add(pos-1)
    if pos+1 < input.len:
        if charToSymbolType(input[pos+1]) == numberType:
            result.add(pos+1)
    for off in [-1, 0, 1]:
        if pos-line_len+off >= 0:
            if charToSymbolType(input[pos-line_len+off]) == numberType:
                result.add(pos-line_len+off)
        if pos+line_len+off < input.len:
            if charToSymbolType(input[pos+line_len+off]) == numberType:
                result.add(pos+line_len+off)

proc day3(input: string, part: int): int =
    let line_len = input.find('\n') + 1
    var c_pos = 0
    for c in input:
        case charToSymbolType(c)
        of symbolType:
            let num_positions = findNumber(input, c_pos, line_len)
            let numbers = num_positions.mapIt(getNumber(input, it)).deduplicate()
            if part == 1:
                result += numbers.foldl(a+b)
            elif part == 2:
                if c == '*' and numbers.len == 2:
                    result += numbers.foldl(a*b)
        else: discard
        c_pos += 1

when isMainModule:
    echo "Part one: ", day3(readFile("input.txt"), 1)
    echo "Part two: ", day3(readFile("input.txt"), 2)