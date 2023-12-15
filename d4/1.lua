local function contains(table, number)
	for _, n in pairs(table) do
		if n == number then
			return true
		end
	end
	return false
end

local input_file = io.open("input.txt", "r")
local sum = 0

while true do
	local matching_nums = 0

	local line = input_file:read()
	if line == nil then
		break
	end
	line = string.sub(line, string.find(line, ":") + 1, string.len(line))
	local winning = string.sub(line, 1, string.find(line, "|") - 1)
	local other = string.sub(line, string.find(line, "|") + 1, string.len(line))

	local winning_nums = {}
	local nums = {}

	for n in string.gmatch(winning, "%d+") do
		table.insert(winning_nums, n)
	end
	for n in string.gmatch(other, "%d+") do
		table.insert(nums, n)
	end

	for _, n in pairs(nums) do
		if contains(winning_nums, n) then
			matching_nums = matching_nums + 1
		end
	end
	if matching_nums > 0 then
		sum = sum + 2 ^ (matching_nums - 1)
	end
end
print(sum)
