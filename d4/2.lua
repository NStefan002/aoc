local function contains(table, number)
	for _, n in pairs(table) do
		if n == number then
			return true
		end
	end
	return false
end

local input_file = io.open("input.txt", "r")
local lines = {}
for l in input_file:lines("l") do
	table.insert(lines, l)
end

local cards = {}
for i = 1, #lines do
	cards[i] = 1
end

for card_id, line in ipairs(lines) do
	local matching_nums = 0

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

	for i = card_id + 1, card_id + matching_nums do
		cards[i] = cards[i] + cards[card_id]
	end
end

local sum = 0
for _, x in pairs(cards) do
	sum = sum + x
end

print(sum)
