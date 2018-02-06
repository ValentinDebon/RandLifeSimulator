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

	def sceneText
		"Je suis un caillou bordel de merde"
	end

	def sceneResponses
		[ "Vrai", "Faux" , "Peut être", "Chat de shrodinger", "Pute", "Sodomie fraiche"]
	end

	def sceneChose(index)
		puts "Selected " + index.to_s
	end

	def death(type)
		puts "Died with Pas de bol"
	end

	def act
		"I"
	end
end

