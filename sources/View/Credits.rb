
require_relative 'Button'

class Credits
	def initialize(view)
		@view = view

		@credits = Button.new("Random Life Simulator 2018 - GameJam IUT2 Edition GOTY Deluxe\n" +
				"Crée par\n" +
				"DEBON Valentin - Programmeur de plomb (Lead Programmer)\n" +
				"GAISNE Anne - Graphiste (Grafayste)\n" +
				"PASDELOUP Romain - Scénariste (Writer)\n" +
				"SALMON Alexandre - Programme et Contenu additionnel\n" +
				"\nStay - Talisco\n" +
				"Do I Wanna Know - Arctic Monkeys\n" +
				"Act Like You Know - Fat Larry's Band\n" +
				"Nutcracker - Piotr Ilitch Tchaïkovsky\n" +
				"Sexual Healing - Marvin Gaye\n" +
				"Launch Music 2 - Prison Architect OST\n" +
				"YMCA - Village People\n" +
				"Gimme! Gimme! Gimme! - ABBA\n" +
				"La marche Funèbre - Frédéric Chopin\n" +
				"Wasted - GTA\n" +
				"Sad Trombone - Unknown\n" +
				"\nRemerciements spéciaux à Hervé BLANCHON pour le doublage de Hervé\n" +
				"\n" + Gosu::LICENSES,
			Proc.new { },
			0.1, 0.1, 0.8, 0.8, @view.width / 50)
	end

	def up(id)
	end

	def down(id)
		@view.returnToTitle
	end

	def update
	end

	def draw
		@credits.draw(@view.width, @view.height)
	end
end
