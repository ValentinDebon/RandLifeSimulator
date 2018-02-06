require 'gosu'

require_relative 'Controller'
require_relative 'View/Title'
require_relative 'View/ActView'
require_relative 'View/SceneView'

class View < Gosu::Window
	attr_accessor :redraw
	attr_reader :controller

	def initialize(controller)
		super(1200, 750, false, 16.666)
		#super(Gosu::screen_width, Gosu::screen_height, true, 16.666)

		self.caption = "Random Life Simulator 2018 - GameJam IUT2 Edition GOTY Deluxe"

		@controller = controller
		@title = Title.new(self)

		self.returnToTitle
	end

	def presentDeath
		self.returnToTitle
	end

	def presentScene
		if @controller.currentScene == nil then
			self.presentDeath
		else
			self.current = SceneView.new(self)
		end
	end

	def returnToTitle
		self.current = @title
	end

	def current=(newView)
		@currentView = newView
		@redraw = true
	end

	def button_up(id)
		@currentView.up(id)
	end

	def button_down(id)
		@currentView.down(id)
	end

	def update
		@currentView.update
	end

	def draw
		@currentView.draw
		@redraw = false
	end

	def needs_cursor?
		true
	end

	def needs_redraw?
		# So that we do not redraw when not needed
		@redraw
	end
end

