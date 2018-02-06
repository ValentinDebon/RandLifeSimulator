
require_relative 'Button'

class SceneView
	def initialize(view)
		@view = view
		@textImg = Gosu::Image.from_text(@view.controller.scene, 50)
	end

	def up(id)
	end

	def down(id)
		@view.returnToTitle
	end

	def update
		@view.redraw = true
	end

	def draw
		@textImg.draw((@view.width - @textImg.width) / 2, (@view.height - @textImg.height) / 2, 0, 1, 1, Gosu::Color::WHITE);
	end
end

