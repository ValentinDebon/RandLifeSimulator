require 'gosu'

require_relative 'Controller'
require_relative 'View/Title'
require_relative 'View/ActView'
require_relative 'View/SceneView'
require_relative 'View/DeathView'

class View < Gosu::Window
	attr_accessor :redraw
	attr_reader :controller

	def initialize(controller)
		super(1200, 750, false, 16.666)
		#super(Gosu::screen_width, Gosu::screen_height, true, 16.666)

		self.caption = "Random Life Simulator 2018 - GameJam IUT2 Edition GOTY Deluxe"

		@controller = controller

		self.returnToTitle
	end

	def presentScene
		@song.stop if @song != nil
		if @controller.currentScene == nil then
			self.current = DeathView.new(self)
		else
			self.current = SceneView.new(self)
		end
	end

	def presentAct
		@song.stop if @song != nil
		self.current = ActView.new(self)
	end

	def returnToTitle
		@song.stop if @song != nil
		self.current = Title.new(self)
	end

	def current=(newView)
		@currentView = newView
		@redraw = true
	end

	def playSound(filename)
		@song = Gosu::Song.new(filename)
		@song.play(looping = false)
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

