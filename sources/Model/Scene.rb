
class Scene
	attr_reader :text, :bg

	def initialize(text, bg, responses)
		@text = text
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
