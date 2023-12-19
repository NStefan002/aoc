def predict(history):
    diff = []
    first_nums = []
    end = False
    while not end:
        first_nums.append(history[0])

        for i in range(1, len(history)):
            diff.append(history[i] - history[i - 1])

        end = True
        for i in range(1, len(diff)):
            if diff[i] != 0:
                end = False
                break
        history = diff
        diff = []

    first_nums.append(0)
    first_nums.reverse()
    for i in range(1, len(first_nums)):
        first_nums[i] -= first_nums[i - 1]

    return first_nums[-1]


sum = 0
while True:
    try:
        history = input().split()
        history = [int(x) for x in history]
        sum += predict(history)
    except EOFError:
        break

print(sum)
