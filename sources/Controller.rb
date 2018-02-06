require_relative 'View'
require_relative 'Model'

class Controller
	attr_accessor :currentScene, :response

	def initialize 
		@view = View.new(self)
		@model = Model.new(self)

		@currentScene = nil
		@response = nil

		@view.show
	end

	def newLife(name)
		@currentScene = @model.first

		@view.presentScene
	end

	def death(type)
		puts type
		currentScene = nil
	end

	def act
		"I"
	end
end

