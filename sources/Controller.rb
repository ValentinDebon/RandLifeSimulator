require_relative 'View'

class Controller
	def initialize 
		@view = View.new(self)

		@view.show
	end

	def newLife
		puts "Starting a new life from scratch"
	end
end

