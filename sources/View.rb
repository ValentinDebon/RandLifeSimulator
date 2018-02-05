require 'gosu'

require_relative 'Controller'
require_relative 'View/ViewTitle'

class View < Gosu::Window
	attr_accessor :controller
	attr_reader :title

	def initialize(controller)
		super(800, 500)

		self.caption = "Random Life Simulator"
		#self.fullscreen = true

		@controller = controller
		@title = ViewTitle.new(@controller)

		self.current = @title
	end

	def draw
		@currentView.draw
	end


	def current=(newView)
		@currentView = newView
	end

end

