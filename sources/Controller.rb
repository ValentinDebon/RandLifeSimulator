require_relative 'View'

class Controller
	def initialize 
		@view = View.new(self)

		@view.show
	end

	def newLife(name)
		puts "Starting a new life for " + name
	end
end

