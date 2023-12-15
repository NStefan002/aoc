local input_file = io.open("input.txt", "r")

local durations = input_file:read("l")
local distances = input_file:read("l")

local duration = ""
local distance = ""

for d in string.gmatch(durations, "%d+") do
	duration = duration .. d
end
for d in string.gmatch(distances, "%d+") do
	distance = distance .. d
end

local duration_val = tonumber(duration)
local distance_val = tonumber(distance)

local min_charging_time = 0
while (duration_val - min_charging_time) * min_charging_time <= distance_val do
	min_charging_time = min_charging_time + 1
end

print(duration + 1 - 2 * min_charging_time)
