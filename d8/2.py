import re
import math


def read_input():
    lines = []
    while True:
        try:
            line = input()
            lines.append(line)
        except EOFError:
            break
    return lines


def main():
    instructions = input()
    input()
    map = {}
    pattern = re.compile(r"[0-9A-Z]{3}")
    lines = read_input()
    for line in lines:
        elements = []
        for el in re.findall(pattern, line):
            elements.append(el)

        map[elements[0]] = [elements[1], elements[2]]

    starting_nodes = []
    for k in map:
        if k[2] == "A":
            starting_nodes.append(k)

    cycles = []
    for el in starting_nodes:
        steps = 0
        instr_counter = 0
        while True:
            if instr_counter == len(instructions):
                instr_counter = 0
            if instructions[instr_counter] == "L":
                el = map[el][0]
            else:
                el = map[el][1]

            instr_counter += 1
            steps += 1

            if el[2] == "Z":
                cycles.append(steps)
                break


    print(math.lcm(*cycles))


main()
