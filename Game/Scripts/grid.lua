return function()
	local Grid = {
		width = 0,
		height = 0,
		scale = 0
	}
	
	function Grid:GetPositionAt(x,y)

		local ResultX, ResultY
		
		if self.width == 0 or
		self.height == 0 or
		self.scale == 0 then
			return {x=0,y=0}
		end 
		
		
		local blockWidthSize = (self.width/self.scale)
		local blockHeightSize = (self.height/self.scale)
		ResultX = blockWidthSize*x
		ResultY = blockHeightSize*y

		if ResultX < 0 then ResultX = 0 end
		if ResultY < 0 then ResultY = 0 end
		
		if ResultX > (self.width-blockWidthSize) then 
			ResultX = (self.width-blockWidthSize) end
			
		if ResultY > (self.height-blockHeightSize) then 
			ResultY = (self.height-blockHeightSize) end

		return {
			x=ResultX,
			y=ResultY
		}
	end

	return Grid
end