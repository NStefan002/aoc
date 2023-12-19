def predict(history):
    diff = []
    last_nums = []
    end = False
    while not end:
        last_nums.append(history[-1])

        for i in range(1, len(history)):
            diff.append(history[i] - history[i - 1])

        end = True
        for i in range(1, len(diff)):
            if diff[i] != 0:
                end = False
                break
        history = diff
        diff = []

    last_nums.append(0)
    last_nums.reverse()
    for i in range(1, len(last_nums)):
        last_nums[i] += last_nums[i - 1]

    return last_nums[-1]


sum = 0
while True:
    try:
        history = input().split()
        history = [int(x) for x in history]
        sum += predict(history)
    except EOFError:
        break

print(sum)
