local input_file = io.open("input.txt", "r")

local durations = input_file:read("l")
local distances = input_file:read("l")

local duration_vals = {}
local distance_vals = {}

for d in string.gmatch(durations, "%d+") do
	table.insert(duration_vals, tonumber(d))
end
for d in string.gmatch(distances, "%d+") do
	table.insert(distance_vals, tonumber(d))
end

local result = 1
for i = 1, #duration_vals do
	local min_charging_time = 0
	while (duration_vals[i] - min_charging_time) * min_charging_time <= distance_vals[i] do
		min_charging_time = min_charging_time + 1
	end
	result = result * (duration_vals[i] + 1 - 2 * min_charging_time)
end

print(result)
