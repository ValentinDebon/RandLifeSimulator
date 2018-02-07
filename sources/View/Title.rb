
require_relative 'Button'
require_relative 'Birth'
require_relative 'Credits'
require_relative 'Depth'

class Title
	def initialize(view)
		@view = view

		backgrounds = ["View/Assets/ArtsPlastiques.jpg",
				"View/Assets/Concert.jpg",
				"View/Assets/Pop.jpg",
				"View/Assets/Bedroom.jpg",
				"View/Assets/Crush.jpg",
				"View/Assets/PremierMot.jpg",
				"View/Assets/Birth.jpg",
				"View/Assets/Diplome.jpg",
				"View/Assets/Rue.jpg",
				"View/Assets/Caillou.jpg",
				"View/Assets/HeadMasterOffice.jpg",
				"View/Assets/Tapis.jpg",
				"View/Assets/Camionette.jpg",
				"View/Assets/Lessive.jpg",
				"View/Assets/ClassRoom.jpg",
				"View/Assets/Placard.jpg"]
		@titleImg = Gosu::Image.new("View/Assets/logo.png")
		@titleScale = Float(@view.width / @titleImg.width) / 2.0
		@backgroundImg = Gosu::Image.new(backgrounds.sample)

		@newLifeBtn = Button.new("Nouvelle Vie", Proc.new { @view.current = Birth.new(@view) }, 0.33, 0.50, 0.33, 0.16)
		@creditsBtn = Button.new("Crédits", Proc.new { @view.current = Credits.new(@view) }, 0.33, 0.68, 0.33, 0.16)
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

		@newLifeBtn.update(mx, my)
		@creditsBtn.update(mx, my)
		@view.redraw = true
	end

	def draw
		@backgroundImg.draw(0, 0, Depth::BACKGROUND, Float(@view.width)/Float(@backgroundImg.width),
			Float(@view.height)/Float(@backgroundImg.height))

		@newLifeBtn.draw(@view.width, @view.height)
		@creditsBtn.draw(@view.width, @view.height)

		@titleImg.draw((@view.width - @titleImg.width * @titleScale) / 2, @view.height / 6, Depth::TEXT, @titleScale, @titleScale)
	end

end

