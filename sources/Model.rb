
require_relative 'Controller'
require_relative 'Model/Life'
require_relative 'Model/Scene'
require_relative 'Model/Response'

class Model
	attr_accessor :life
	attr_reader :controller, :scenes

	def first
		@scenes[0..3].sample
	end

	def newLife(name)
		@life = Life.new(name)
	end

	def endLife
		@life = nil
	end

	def initialize(controller)
		@controller = controller

		@life = nil
		@scenes = [
			Scene.new("Vous voyez un caillou.",
				"View/Assets/Caillou.jpg", [
					Response.new("Manger le caillou.",
						Proc.new {
							if Random.rand() > 0.3 then
								@controller.response = "Cela n'a aucun goût, vous êtes un peu déçu."
							else
								@controller.response = "Vous vous étouffez avec."
							end

							@controller.currentScene = @scenes[1]
						}
					),
					Response.new("Jeter le caillou sur petit <enfant>.",
						Proc.new {
							@controller.response = "Tel un lanceur de baseball professionnel,\nvous lancez la balle à toute vitesse.\n" +
								"Cette dernière heurte violemment petit <enfant>, il se met à pleurer."

							@controller.currentScene = @scenes[2]
						}
					),
					Response.new("Cacher le caillou.",
						Proc.new {
							@controller.response = "Ce caillou vous semble être très précieux.\n" +
								"Vous décidez de le cacher afin que personne ne vous le vole."

							@controller.currentScene = @scenes[3]
						}
					),
					Response.new("Ignorer le caillou.",
						Proc.new {
							@controller.response = "C’est un simple caillou, pourquoi lui porter de l’attention?"

							@controller.currentScene = @scenes[2]
						}
					)
				]
			),
			Scene.new("Vous vous trouvez sur le magnifique tapis oriental de mamie <mamie>.",
				"View/Assets/Tapis.jpg", [
					Response.new("Déféquer dessus.",
						Proc.new {
							if Random.rand() > 0.4 then
								@controller.response = "La diarrhée a été plus forte que vous."
							else
								@controller.response = "Votre Mamie est revenue,\n vous avez le droit à une belle engueulade."
							end

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("Rouler dessus.",
						Proc.new {
							@controller.response = "Ce tapis est le parfait terrain de jeu !\n" +
								"Vous décidez donc de vous rouler dedans tel un petit sushi.\n" +
								"Néanmoins, une fois enroulé, la poussière vous fait éternuer à foison."

							@controller.currentScene = @scenes[2]
						}
					),
					Response.new("Dormir.",
						Proc.new {
							@controller.response = "La douceur du tapis est apaisante,\n" +
								"lentement vous vous sentez partir vers le pays des rêves."

							@controller.currentScene = @scenes[3]
						}
					)
				]
			),
			Scene.new("Vous le sentez au plus profond de votre être, vous êtes prêt !\n" +
				" Vous allez dire votre premier mot !",
				"View/Assets/PremierMot.jpg", [
					Response.new("Manger",
						Proc.new {
							@controller.response = "Tel l’estomac sur patte que vous êtes,\n" +
							"vous avez choisi votre premier mot afin de réclamer trois fois\n" +
							"plus de nourriture à vos esclaves nommés parents. "

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("Ah!",
						Proc.new {
							@controller.response = "Vous ne savez pas pourquoi vous avez dit ça,\n" +
							"c’est comme si ce nom vous parlait."

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("Caca",
						Proc.new {
							@controller.response = "Ah bah bonjour la maturité,  " +
							"vos parents ont un peu honte de vous.\n" +
							"Mais bon ça finira par passer avec le temps."

							@controller.currentScene = @scenes[3]
						}
					),
					Response.new("Papa",
						Proc.new {
							@controller.response = "Vous avez choisi votre camp," +
							"votre papa est votre champion,\n" +
							"votre modèle !\n" +
							"Maman est un peu jalouse mais vous vous en fichez un peu."

							@controller.currentScene = @scenes[2]
						}
					),
					Response.new("Maman",
						Proc.new {
							@controller.response = "Vous avez choisi votre camp, " +
							"votre maman est votre reine,\n" +
							"votre inspiration !\n" +
							"Papa est un peu jaloux mais vous vous en fichez un peu."

							@controller.currentScene = @scenes[3]
						}
					)
				]
			),
			Scene.new("En partant travailler, maman a oublié de fermer le fameux placard interdit.",
				"View/Assets/Placard.jpg", [
					Response.new("Boire de l’eau de javel",
						Proc.new {
							if Random.rand() > 0.3 then
								@controller.response = "Ce n'était peut-être pas une si bonne idée."
							else
								@controller.response = "Le goût est attroce et vous met K.O pour un certain temps."
							end

							@controller.currentScene = @scenes[1]
						}
					),
					Response.new("Jouer avec les éponges",
						Proc.new {
							@controller.response = "Les petits rectangles jaunes et verts " +
							"vous supplient de les utiliser.\n" +
							"Vous les prenez en main et une vision vous envahi.\n" +
							"Vous vous voyez peindre de grands tableaux et essuyer\n " +
							"les taches de peinture avec les éponges."

							@controller.currentScene = @scenes[1]
						}
					),
					Response.new("Se cacher",
						Proc.new {
							@controller.response = "Personne ne pensera à vous chercher là dedans,\n " +
							"vous décidez donc d’entrer dans ce fort imprenable.\n " +
							"Vos parents ont mis deux jours à vous retrouver."

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("Nyarnya",
						Proc.new {
							@controller.response = "Ce placard n’est pas comme les autres, vous le sentez.\n" +
							"En entrant à l’intérieur vous vous retrouvez dans un autre monde…\n " + " le monde de Nyarnya."

							@controller.currentScene = @scenes[1]
						}
					)
				]
			)

		]
	end
end
