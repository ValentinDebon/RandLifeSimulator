require_relative 'View'

class Controller
	def initialize 
		@view = View.new(self)

		@view.show
	end

	def text
		"Oui"
	end
end

