
require_relative 'Button'

class DeathView
	module State
		Animating = 0
		Displaying = 1
	end

	def initialize(view)
		@view = view

		case @view.controller.death
			when "Darwin"
				@backgroundImg = Gosu::Image.new("View/Assets/Deaths/darwin.jpg")
				@view.playSound(["View/Assets/Musics/C'est Darwin.mp3",
						"View/Assets/Musics/C'est la sélection naturelle.mp3"].sample)
			when "Javel"
				@backgroundImg = Gosu::Image.new("View/Assets/Deaths/javel.jpg")
				@view.playSound("View/Assets/Musics/Sad Trombone.mp3")
			when "Camionette"
				@backgroundImg = Gosu::Image.new("View/Assets/Deaths/camionette.jpg")
				@view.playSound("View/Assets/Musics/Marche Funèbre.mp3")
			when "Ciseau"
				@backgroundImg = Gosu::Image.new("View/Assets/Deaths/ciseaux.jpg")
				@view.playSound("View/Assets/Musics/Marche Funèbre.mp3")
			when "Caillou"
				@backgroundImg = Gosu::Image.new("View/Assets/Deaths/faucheuse2.gif")
				@view.playSound("View/Assets/Musics/Marche Funèbre.mp3")
			else
				@backgroundImg = Gosu::Image.new("View/Assets/Deaths/faucheuse2.gif")
				@view.playSound("View/Assets/Musics/Wasted.mp3")
		end

		@animStart = Gosu::milliseconds
		@duration = 3000
		@stats = Button.new(@view.controller.stats,
			Proc.new { },
			0.1, 0.1, 0.8, 0.8, @view.height / 20)

		@state = State::Animating
	end

	def up(id)
	end

	def down(id)
		if @state == State::Animating then
			@state = State::Displaying
			@view.redraw = true
		elsif @state == State::Displaying then
			@view.controller.endLife
		end
	end

	def update
		if @state == State::Animating then
			if Gosu::milliseconds >= @animStart + @duration then
				@state = State::Displaying
			end
			@view.redraw = true
		end
	end

	def draw
		if @state == State::Animating then
			step = Float(Gosu::milliseconds - @animStart) / @duration
		elsif @state == State::Displaying then
			step = 1
			@stats.draw(@view.width, @view.height)
		end

		@backgroundImg.draw(0, 0, Depth::BACKGROUND, Float(@view.width)/Float(@backgroundImg.width),
			Float(@view.height)/Float(@backgroundImg.height),
			Gosu::Color.new(step * 255, 255, step * 255, step * 255))
	end
end

