require 'gosu'

require_relative 'Controller'
require_relative 'View/Title'

class View < Gosu::Window
	attr_accessor :redraw
	attr_reader :controller, :title

	def initialize(controller)
		super(800, 500, true, 500)#16.666)

		self.caption = "Random Life Simulator 2018 - GameJam IUT2 Edition GOTY Deluxe"

		@controller = controller
		@title = Title.new(self)
		@redraw = true

		self.current = @title
	end

	def button_up(id)
		@currentView.up(id)
		@redraw = true
	end

	def button_down(id)
		@currentView.down(id)
	end

	def update
		@currentView.update
	end

	def draw
		puts "Redrawing"
		@currentView.draw
		@redraw = false
	end

	def needs_cursor?
		true
	end

	def needs_redraw?
		@redraw
	end

	def current=(newView)
		@currentView = newView
	end
end

