class Response
	attr_accessor :text, :procSuite, :reactions, :nextScenes
	def initialize(text, procSuite, reactions)
		@text = text
		@reactions = reactions
		@scenes = []
		@procSuite = procSuite
		@destinyId
	end

	def findDestiny
		@destinyId = @procSuite.call #returns int

	end

	def reaction
		@reactions[@destinyId]
	end

	def scene
		@scenes[@destinyId]
	end
end
