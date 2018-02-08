
require_relative 'Persona'

class Life
	attr_reader :name, :characters
	attr_accessor :age

	def initialize(name)
		@name = name
		@age = 0

		listIdentities = ['Hervé', 'Cthulhu',
			'Emmanuel', 'Mekayak', 'Sandrine',
			'Sauron', 'Sphinx', 'Gayel']
		listCharacters = ['ado', 'adulte',
			'dealer', 'enfant', 'maitresse',
			'mamie', 'mariee', 'pervers',
			'professeur', 'proviseur']

		@characters = Array.new(listCharacters).map {
			|characters|
			Persona.new(characters, listIdentities.sample)
		}

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
