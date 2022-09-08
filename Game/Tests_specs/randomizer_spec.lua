local Randomizer = require("Scripts.randomizer")

describe('Randomizer => GetRandom => #ignore', function()
	
	local randomizer
	before_each(function()
		randomizer = Randomizer()
	end)
	
	it("Randomizer returns a number", function()
		assert.is_equal("number", type(randomizer:GetRandom()))
	end)

	it("Randomizer returns different numbers", function()
		
		local responseA, responseB

		while responseA == responseB do
			responseA = randomizer:GetRandom()
			responseB = randomizer:GetRandom()
		end


		assert.is_not_equal(responseA, responseB)
	end)

	it("Randomizer number do not return the same pattern", function()

		local hash = ""
		for i = 1, 12, 1 do
			hash = hash .. randomizer:GetRandom()
		end

		assert.is_not_equal("81024836574610", hash)
	end)

	it("Randomizer with only one argument goes through 0->N-1", function()
		
		local list = {}

		for i=1, 200, 1 do
			local n = randomizer:GetRandom(12)
			list[n] = 1
			if i % 12 == 0 then
				local sum = 0
				for a=1, 12, 1 do
					if list[a] ~= nil then
						sum = sum+1
					end
				end
				if sum >= 12 then
					break
				end
			end
		end

		for a=1, 12, 1 do
			assert.is_equal(true, (list[a] == 1))
		end
	end)

	it("Randomizer do call the N value input one argument", function()
		
		local called = false
		for a=1, 50, 1 do
			local n = randomizer:GetRandom(3)
			if n == 3 then called = true end
		end
		
		assert.is_equal(true, called)
	end)

	it("Randomizer with only one argument should call 0 as well", function()
		
		local called = false
		for a=1, 50, 1 do
			local n = randomizer:GetRandom(3)
			if n == 0 then called = true end
		end
		
		assert.is_equal(true, called)
	end)

	it("If there's two arguments, call in reach of those (both inclusive)", function()
		
		local list = {}

		for i=1, 50, 1 do
			local n = randomizer:GetRandom(7,12)
			list[n] = (list[n] or 0)+1
		end

		for a=1, 6, 1 do
			assert.is_equal(nil, list[a])
		end
		for a=7, 12, 1 do
			assert.is_equal(true, (list[a] >= 1))
		end
	end)
end)