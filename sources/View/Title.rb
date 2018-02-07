
require_relative 'Button'
require_relative 'Birth'
require_relative 'Depth'

class Title
	def initialize(view)
		@view = view

		@birth = Birth.new(@view)

		backgrounds = ["View/Assets/birth.jpg"]
		@titleImg = Gosu::Image.from_text("Random Life Simulator 2018", 50)
		@backgroundImg = Gosu::Image.new(backgrounds.sample)

		@newLifeBtn = Button.new("Nouvelle Vie", Proc.new { @view.current = @birth }, 0.33, 0.32, 0.33, 0.16)
		@creditsBtn = Button.new("Crédits", Proc.new { puts "Crédits" }, 0.33, 0.50, 0.33, 0.16)
	end

	def up(id)
	end

	def down(id)
		if id == Gosu::MS_LEFT then
			@newLifeBtn.trigger if @newLifeBtn.hovered
			@creditsBtn.trigger if @creditsBtn.hovered
		end
	end

	def update
		mx = @view.mouse_x / @view.width
		my = @view.mouse_y / @view.height

		if mx >= 0.30 && mx <= 0.7 && my >= 0.3 && my <= 0.7 then
			@newLifeBtn.update(mx, my)
			@creditsBtn.update(mx, my)
			@view.redraw = true
		end
	end

	def draw
		@backgroundImg.draw(0, 0, Depth::BACKGROUND, Float(@view.width)/Float(@backgroundImg.width),
			Float(@view.height)/Float(@backgroundImg.height))

		@newLifeBtn.draw(@view.width, @view.height)
		@creditsBtn.draw(@view.width, @view.height)

		@titleImg.draw((@view.width - @titleImg.width) / 2, @view.height / 6, Depth::TEXT, 1, 1, Gosu::Color::BLACK)
	end

end

