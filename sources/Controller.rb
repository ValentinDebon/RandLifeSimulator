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

	def nextScene
		@view.presentScene
	end

	def sceneText
		@currentScene.text
	end

	def responsesText
		@currentScene.responsesText
	end

	def stats
		@model.life.name + " est mort à " + @model.life.age.to_s + " ans\n"
	end

	def endLife
		@model.endLife
		@currentScene = nil
		@response = nil

		@view.returnToTitle
	end

	def newLife(name)
		@model.newLife(name)
		@currentScene = @model.first

		@view.presentAct
	end

	def death(type)
		puts type
		currentScene = nil
	end

	def act
		"I"
	end
end

