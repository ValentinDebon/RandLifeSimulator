
class Response
	attr_reader :text, :proc

	def initialize(text, _proc)
		@text = text
		@proc = _proc
	end
end

