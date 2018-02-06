require_relative 'Response'

class Scene
	attr_accessor :responses
	attr_reader :situationText, :nextScene, :reactionText

	def initialize(background, text)
		@background = background
		@situationText = situationText
		@responses = []
		@nextScene = nil
		@reactionText = ""
	end

	def select(id) #returns nothing
		@responses[id].findDestiny
		@nextScene = @responses[id].scene
		@reactionText = @responses[id].reaction
	end

	def responsesText #return array full of strings
		Array.new(@responses).map { |response| response.text }
	end
end
