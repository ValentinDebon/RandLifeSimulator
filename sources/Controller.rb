require_relative 'View'

class Controller
	def initialize 
		@view = View.new(self)

		@view.show
	end

	def newLife(name)
		puts "Starting a new life for " + name
		@view.newAct
	end

	def act
		"I"
	end
end

