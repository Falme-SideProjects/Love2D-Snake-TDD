return function ()
	local Randomizer = {
		hasSeed = false
	}

	function Randomizer:GetRandom(min, max)

		if min == nil and max == nil then
			min = 0
			max = 10 
		end
		if min ~= nil and max == nil then
			max = min
			min = 0
		end


		if not self.hasSeed then
			math.randomseed(os.time())
			self.hasSeed = true
		end
		return math.random(min,max)
	end
	
	return Randomizer
end