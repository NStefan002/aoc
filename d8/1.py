import re


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
    pattern = re.compile(r"[A-Z]+")
    lines = read_input()
    for line in lines:
        elements = []
        for el in re.findall(pattern, line):
            elements.append(el)

        map[elements[0]] = [elements[1], elements[2]]

    steps = 0
    instr_counter = 0
    current_element = "AAA"
    while True:
        if instr_counter == len(instructions):
            instr_counter = 0
            if current_element == "ZZZ":
                break

        if instructions[instr_counter] == "L":
            current_element = map[current_element][0]
        else:
            current_element = map[current_element][1]

        instr_counter += 1
        steps += 1

    print(steps)


main()
