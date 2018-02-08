
require 'gosu'
require_relative 'Depth'

class ActView
	def initialize(view)
		@view = view

		case @view.controller.act
			when "I"
				@view.playSound("View/Assets/Musics/Brittle Rille.mp3")
				@subtitle = "\n- Enfance -"
			when "II"
				@view.playSound("View/Assets/Musics/Do I Wanna Know.mp3")
				@subtitle = "\n- Adolescence -"
			when "III"
				@view.playSound("View/Assets/Musics/Act Like You Know.mp3")
				@subtitle = "\n- Adultescence -"
			when "IV"
				@view.playSound("View/Assets/Musics/Nutcracker.mp3")
				@subtitle = "\n- La retraite -"
			else
				@view.playSound(nil)
				@subtitle = "\n- ? -"
		end

		@actImg = Gosu::Image.from_text("Acte " + @view.controller.act + @subtitle, 100)
		@animStart = Gosu::milliseconds
		@duration = 5000
	end

	def up(id)
	end

	def down(id)
	end

	def update
		if Gosu::milliseconds >= @animStart + @duration then
			@view.controller.nextScene
		else
			@view.redraw = true
		end
	end

	def draw
		alpha = Float(Gosu::milliseconds - @animStart) / @duration
		@actImg.draw((@view.width - @actImg.width) / 2, (@view.height - @actImg.height) / 2, Depth::TEXT, 1, 1,
			Gosu::Color.new(alpha * 255, 255, 255, 255))
	end

end

