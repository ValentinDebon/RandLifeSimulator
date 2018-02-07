
require 'gosu'

class Button
	module Color
		Normal = Gosu::Color.new(192, 0, 0, 0)
		Hovered = Gosu::Color::BLACK
	end
	attr_reader :hovered

	def initialize(text, procedure, dx, dy, dw, dh, font_size = 50)
		@textImg = Gosu::Image.from_text(text, font_size)
		@procedure = procedure
		@dx = dx
		@dy = dy
		@dw = dw
		@dh = dh

		@hovered = false
	end

	def trigger
		@procedure.call
	end

	def update(dx, dy)
		@hovered = dx >= @dx && dx <= @dw + @dx && dy >= @dy && dy <= @dh + @dy
	end

	def draw(w, h)
		x = @dx * w
		y = @dy * h
		width = @dw * w
		height = @dh * h

		if @hovered then
			color = Color::Hovered
		else
			color = Color::Normal
		end

		Gosu::draw_rect(x, y, width, height, color)
		@textImg.draw((width - @textImg.width) / 2 + x, (height - @textImg.height) / 2 + y, 2, 1, 1, Gosu::Color::WHITE)
	end
end
