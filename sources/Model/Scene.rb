
class Scene
	attr_reader :text, :character, :bg

	def initialize(text, character, bg, responses)
		@text = text
		@character = character
		@bg = bg
		@responses = responses
	end

	def responsesText
		Array.new(@responses).map { |response| response.text }
	end

	def respond(index)
		@responses[index].proc.call
	end
end
