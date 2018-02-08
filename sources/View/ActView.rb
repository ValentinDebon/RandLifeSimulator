
require 'gosu'
require_relative 'Depth'

class ActView
	def initialize(view)
		@view = view

		case @view.controller.act
			when "I"
				@view.playSound("View/Assets/Musics/Brittle Rille.mp3")
				@subImg = Gosu::Image.from_text("- Enfance -", 60)
			when "II"
				@view.playSound("View/Assets/Musics/Do I Wanna Know.mp3")
				@subImg = Gosu::Image.from_text("- Adolescence -", 60)
			when "III"
				@view.playSound("View/Assets/Musics/Act Like You Know.mp3")
				@subImg = Gosu::Image.from_text("- Adultescence -", 60)
			when "IV"
				@view.playSound("View/Assets/Musics/Nutcracker.mp3")
				@subImg = Gosu::Image.from_text("- La retraite -", 60)
			else
				@view.playSound(nil)
				@subImg = Gosu::Image.from_text("- ? -", 60)
		end

		@actImg = Gosu::Image.from_text("Acte " + @view.controller.act, 100)
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
		@actImg.draw((@view.width - @actImg.width) / 2, (@view.height - @actImg.height) / 2 - 30, Depth::TEXT, 1, 1,
			Gosu::Color.new(alpha * 255, 255, 255, 255))

		@subImg.draw((@view.width - @subImg.width) / 2, (@view.height - @subImg.height) / 2 + 30, Depth::TEXT, 1, 1,
			Gosu::Color.new(alpha * 255, 255, 255, 255))
	end

end

