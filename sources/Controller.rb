require_relative 'View'
require_relative 'Model'

class Controller
	attr_accessor :currentScene

	def initialize
		@view = View.new(self)
		@model = Model.new(self)

		@view.show
	end

	def nextScene
		if Random.rand() <= 0.02 then
			self.death = "Darwin"
		end

		if @oldAct != self.act then
			@oldAct = self.act
			@view.presentAct
		else
			@view.presentScene
		end
	end

	def sceneCharacter
		character = nil

		for c in @model.life.characters do
			character = c if c.character == @currentScene.character
		end

		character
	end

	def formatText(text)
		@model.life.characters.map {
			|persona|
			text = text.gsub(/<#{persona.character}>/, persona.identity)
		}

		text
	end

	def sceneText
		self.formatText(@currentScene.text)
	end

	def responsesText
		@currentScene.responsesText.map {
			|text|
			self.formatText(text)
		}
	end

	def death=(value)
		@_death = value
		@currentScene = nil
	end

	def death
		@_death
	end

	def playSound(filename)
		@view.playSound(filename)
	end

	def response=(value)
		@_response = self.formatText(value)
	end

	def response
		@_response
	end

	def stats
		realisations = false
		money = @model.life.wealth * 10000 * Random.rand()
		if @model.life.age == 0 then
			stat = @model.life.name + " est mort prématurément\n"
		else
			stat = @model.life.name + " est mort à " + @model.life.age.to_s + " ans\n"
		end
		stat += "Cause du décès: " + @_death + "\n" +
		"Votre fortune s'élève à : " + Integer(money).to_s + "€\n\n" +
		"Vos réalisations:\n"

		if @model.life.marriedTo != nil then
			stat = stat + "\tVous avez épousé: " + @model.life.marriedTo + "\n"
			realisations = true
		end

		if @model.life.child != nil then
			stat = stat + "\tVous avez eut pour enfant: " + @model.life.child + "\n"
			realisations = true
		end

		if @model.life.car != nil then
			stat = stat + "\tVous avez eut pour voiture: " + @model.life.car + "\n"
			realisations = true
		end

		if !realisations then
			stat = stat + "\tQue Dalle."
		end

		stat
	end

	def endLife
		@model.endLife

		@view.playSound(nil)
		@view.returnToTitle
	end

	def newLife(name)
		@currentScene = nil
		@_response = nil
		@_death = nil
		@oldAct = nil

		@model.newLife(name)
		@currentScene = @model.first

		self.nextScene
	end

	def act
		case @model.life.age
			when 0..14 then "I"
			when 15..25 then "II"
			when 26..60 then "III"
			else "IV"
		end
	end
end
