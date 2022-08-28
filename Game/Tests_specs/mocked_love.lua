_G.error = function(message, levels) return true end
_G.love = {
	window = {
		close = function() return "close()" end
	},
	graphics = {
		print = function(text, x, y) end,
		rectangle = function(type, x,y,w,h)
			return type,x,y,w,h
		end,
		setColor = function (r,g,b,a) end
	},
	keypressed = function(key) return key end
}