
class Life
	attr_reader :name
	attr_accessor :age

	def initialize(name)
		@name = name
		@age = 0

		@art = 0
		@doubt = 0
		@intelligence = 0
		@sport = 0
		@cleanliness = 0
		@instabity = 0
		@wealth = 0
		@violence = 0
		@drugs = 0
		@love = 0
		@blackSheep = 0
		@flemme = 0

		@prison = false
		@hospital = false
		@dog = false
		@university = false
		@employment = false

		@car = nil
		@child = nil
		@marriedTo = nil
	end
end
