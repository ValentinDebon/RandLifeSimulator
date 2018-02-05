require 'gosu'

require_relative 'Controller'

class View < Gosu::Window

	def initialize(controller)
		super(800, 500)

		@controller = controller

		self.caption = "Random Life Simulator"
		#self.fullscreen = true
	end

	def draw
		puts @controller.text
		sleep 1
	end

end

