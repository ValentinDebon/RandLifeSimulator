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
		if @controller.currentScene == nil then
			self.current = DeathView.new(self)
		else
			self.current = SceneView.new(self)
		end
	end

	def presentAct
		self.playSound(nil)
		self.current = ActView.new(self)
	end

	def returnToTitle
		if @song == nil then
			@song = Gosu::Song.new(["View/Assets/Musics/Act Like You Know.mp3",
				"View/Assets/Musics/Gimme! Gimme! Gimme!.mp3",
				"View/Assets/Musics/Sexual Healing.mp3",
				"View/Assets/Musics/Do I Wanna Know.mp3",
				"View/Assets/Musics/Prison Architect.mp3"].sample)
			@song.play(looping = false)
		end

		self.current = Title.new(self)
	end

	def current=(newView)
		@currentView = newView
		@redraw = true
	end

	def playSound(filename)
		if filename != nil then
			@song = Gosu::Song.new(filename)
			@song.play(looping = false)
		else
			@song = nil
		end
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
