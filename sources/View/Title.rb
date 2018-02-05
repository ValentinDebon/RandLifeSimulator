
require_relative 'Button'

class Title
	def initialize(view)
		@view = view

		@titleImg = Gosu::Image.from_text("Jewish Simulator", 50)
		@backgroundImg = Gosu::Image.new("View/Assets/main_bg.png")

		@newLifeBtn = Button.new("Nouvelle Vie", Proc.new { puts "Nouvelle Vie" }, 0.33, 0.32, 0.33, 0.16)
		@creditsBtn = Button.new("Crédits", Proc.new { puts "Crédits" }, 0.33, 0.50, 0.33, 0.16)

		@view.redraw = true
	end

	def up(id)
		puts "Up"
	end

	def down(id)
		puts "Down"
	end

	def update
		puts "Update"
	end

	def draw
		@backgroundImg.draw(0, 0, -1, Float(@view.width)/Float(@backgroundImg.width),
			Float(@view.height)/Float(@backgroundImg.height))

		@newLifeBtn.draw(@view.width, @view.height)
		@creditsBtn.draw(@view.width, @view.height)

		@titleImg.draw((@view.width - @titleImg.width) / 2, @view.height / 6, 2, 1, 1, Gosu::Color::BLACK);
	end
end

