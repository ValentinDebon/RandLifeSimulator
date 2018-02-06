require_relative 'View'

class Controller
	def initialize 
		@view = View.new(self)

		@view.show
	end

	def newLife(name)
		@view.newAct
	end

	def nextScene
		@view.newScene
	end

	def scene
		"Pute"
	end

	def act
		"I"
	end
end

