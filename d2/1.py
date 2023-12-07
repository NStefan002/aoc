R = 12
G = 13
B = 14


def game_is_valid(game):
    for g in game:
        g = g.strip()
        g = g.split(" ")
        for i in range(0, len(g), 2):
            g[i] = int(g[i].strip())
            g[i + 1] = g[i + 1].strip()
            g[i + 1] = g[i + 1].strip(",")
            match g[i + 1]:
                case "red":
                    if g[i] > R:
                        # print("r: " + str(g[i]))
                        return False
                case "green":
                    if g[i] > G:
                        # print("g: " + str(g[i]))
                        return False
                case "blue":
                    if g[i] > B:
                        # print("b: " + str(g[i]))
                        return False
    return True


def main():
    try:
        with open("./input.txt") as input_file:
            games = input_file.readlines()
    except IOError:
        exit()

    sum = 0
    game_number = 1
    for game in games:
        game = game[game.find(":") + 1 :]
        game = game.split(";")
        if game_is_valid(game):
            sum += game_number

        game_number += 1

    print(sum)


main()
