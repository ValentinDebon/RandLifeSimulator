
require 'gosu'
require_relative 'Depth'

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
		@active = false
	end

	def activate(view, active = true)
		@active = active
		if @active then
			view.text_input = self
		else
			view.text_input = nil
		end
		view.redraw = true
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

		Gosu::draw_rect(x, y, width, height, Gosu::Color::BLACK, Depth::RECTANGLE)
		textImg = Gosu::Image.from_text(self.text, @font_size)
		textImg.draw((width - textImg.width) / 2 + x, (height - textImg.height) / 2 + y, Depth::TEXT, 1, 1, Gosu::Color::WHITE)

		if @active  && ((Gosu::milliseconds / 500) % 2 == 0) then
			if self.caret_pos != 0 then
				caretImg = Gosu::Image.from_text(self.text[0..self.caret_pos - 1], @font_size)
				rectOffset = caretImg.width
			else
				rectOffset = 0
			end

			Gosu::draw_rect((width - textImg.width) / 2 + x + rectOffset,
				(height - textImg.height) / 2 + y,
				2, @font_size * 0.8, Gosu::Color::WHITE, Depth::TEXT)
		end
	end
end

