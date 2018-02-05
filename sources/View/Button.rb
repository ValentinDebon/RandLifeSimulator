
class Button

	def initialize(text, procedure, dx, dy, dw, dh, font_size = 50)
		@textImg = Gosu::Image.from_text(text, font_size)
		@procedure = procedure
		@dx = dx
		@dy = dy
		@dw = dw
		@dh = dh
	end

	def draw(w, h)
		x = @dx * w
		y = @dy * h
		width = @dw * w
		height = @dh * h
		Gosu::draw_rect(x, y, width, height, Gosu::Color::BLUE)
		@textImg.draw((width - @textImg.width) / 2 + x, (height - @textImg.height) / 2 + y, 2, 1, 1, Gosu::Color::WHITE);
	end
end
