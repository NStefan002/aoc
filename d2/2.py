def power_of_cubes(game):
    red = 0
    green = 0
    blue = 0
    for g in game:
        g = g.strip()
        g = g.split(" ")
        for i in range(0, len(g), 2):
            g[i] = int(g[i].strip())
            g[i + 1] = g[i + 1].strip()
            g[i + 1] = g[i + 1].strip(",")
            match g[i + 1]:
                case "red":
                    red = max(red, g[i])
                case "green":
                    green = max(green, g[i])
                case "blue":
                    blue = max(blue, g[i])
    return red * green * blue


def main():
    try:
        with open("./input.txt") as input_file:
            games = input_file.readlines()
    except IOError:
        exit()

    sum = 0
    for game in games:
        game = game[game.find(":") + 1 :]
        game = game.split(";")
        sum += power_of_cubes(game)

    print(sum)


main()
