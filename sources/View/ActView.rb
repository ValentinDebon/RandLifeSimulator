
require 'gosu'

class ActView
	def initialize(view)
		@view = view

		@actImg = Gosu::Image.from_text("Acte " + @view.controller.act, 100)
		@animStart = Gosu::milliseconds
		#@duration = 5000
		@duration = 1000
	end

	def up(id)
	end

	def down(id)
	end

	def update
		if Gosu::milliseconds >= @animStart + @duration then
			@view.presentScene
		else
			@view.redraw = true
		end
	end

	def draw
		alpha = Float(Gosu::milliseconds - @animStart) / @duration
		@actImg.draw((@view.width - @actImg.width) / 2, (@view.height - @actImg.height) / 2, 0, 1, 1,
			Gosu::Color.new(alpha * 255, 255, 255, 255))
	end

end

