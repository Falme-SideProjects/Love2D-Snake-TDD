_G.error = function(message, levels) return true end
_G.love = {
	graphics = {
		print = function(text, x, y) end,
		rectangle = function(type, x,y,w,h)
			return type,x,y,w,h
		end
	},
	keypressed = function(key) return key end
}