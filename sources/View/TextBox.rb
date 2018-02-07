
require 'gosu'

class TextBox < Gosu::TextInput
	attr_reader :hovered

	def initialize(dx, dy, dw, dh, limit = 12, font_size = 50)
		super()

		@dx = dx
		@dy = dy
		@dw = dw
		@dh = dh
		@font_size = font_size
		@limit = limit

		@hovered = false
	end

	def filter(text_in)
		text_in if self.text.length <= @limit
	end

	def update(dx, dy)
		@hovered = dx >= @dx && dx <= @dw + @dx && dy >= @dy && dy <= @dh + @dy
	end

	def draw(w, h)
		x = @dx * w
		y = @dy * h
		width = @dw * w
		height = @dh * h

		Gosu::draw_rect(x, y, width, height, Gosu::Color::BLACK)
		textImg = Gosu::Image.from_text(self.text, @font_size)
		textImg.draw((width - textImg.width) / 2 + x, (height - textImg.height) / 2 + y, 2, 1, 1, Gosu::Color::WHITE)
	end
end

