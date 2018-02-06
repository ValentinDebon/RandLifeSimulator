require_relative 'Response'

class Scene
	attr_accessor :responses
	def initialize(act, background, situationText)
		@act = act
		@background = background
		@situationText = situationText
		@responses = []
		@selectedId = nil
	end

	def select(id) #returns nothing
		@selectedId = id
		@response[id].findDestiny
	end

	def responses #return array full of strings
		text = []
		for response in @responses
			text.push(response.text)
		end
		text
	end

	def reaction #return string
		@response[@selectedId].reaction
	end

	def nextScene #return Scene
		@response[@selectedId].scene
	end
end
