import re

num_pattern = re.compile(r"\d+")
nums_pattern = r"(\d+)\s+(\d+)\s+(\d+)"
input_file = open("input.txt", "r")
sections = input_file.read().split(":")

seeds = []
for s in re.findall(num_pattern, sections[1]):
    seeds.append(int(s))

maps = []

for i in range(2, len(sections)):
    map = []
    for destination, source, length in re.findall(nums_pattern, sections[i]):
        map.append((int(destination), int(source), int(length)))

    maps.append(map)

for i in range(0, len(seeds)):
    for map in maps:
        for m in map:
            if seeds[i] >= m[1] and seeds[i] <= m[1] + m[2]:
                seeds[i] = m[0] + seeds[i] - m[1]
                break

print(min(seeds))
