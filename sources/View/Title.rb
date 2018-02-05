
require_relative 'Button'

class Title
	def initialize(view)
		@view = view

		@titleImg = Gosu::Image.from_text("Jewish Simulator", 50)
		@backgroundImg = Gosu::Image.new("View/Assets/main_bg.png")

		@newLifeBtn = Button.new("Nouvelle Vie", Proc.new { @view.controller.newLife }, 0.33, 0.32, 0.33, 0.16)
		@creditsBtn = Button.new("Crédits", Proc.new { puts "Crédits" }, 0.33, 0.50, 0.33, 0.16)

		@view.redraw = true
	end

	def up(id)
		if @newLifeBtn.hovered then
			@newLifeBtn.trigger
		elsif @creditsBtn.hovered then
			@creditsBtn.trigger
		end
	end

	def down(id)
		puts "Down"
	end

	def update
		mx = @view.mouse_x / @view.width
		my = @view.mouse_y / @view.height

		@newLifeBtn.update(mx, my)
		@creditsBtn.update(mx, my)
	end

	def draw
		@backgroundImg.draw(0, 0, -1, Float(@view.width)/Float(@backgroundImg.width),
			Float(@view.height)/Float(@backgroundImg.height))

		@newLifeBtn.draw(@view.width, @view.height)
		@creditsBtn.draw(@view.width, @view.height)

		@titleImg.draw((@view.width - @titleImg.width) / 2, @view.height / 6, 2, 1, 1, Gosu::Color::BLACK);
	end
end

