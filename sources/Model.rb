
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
				"enfant",
				"View/Assets/Caillou.jpg", [
					Response.new("Manger le caillou.",
						Proc.new {
							if Random.rand() > 0.3 then
								@controller.response = "Cela n'a aucun goût, vous êtes un peu déçu."
							else
								@controller.response = "Vous vous étouffez avec."
							end

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					),
					Response.new("Jeter le caillou sur petit <enfant>.",
						Proc.new {
							@controller.response = "Tel un lanceur de baseball professionnel,\nvous lancez la balle à toute vitesse.\n" +
								"Cette dernière heurte violemment petit <enfant>, il se met à pleurer."

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					),
					Response.new("Cacher le caillou.",
						Proc.new {
							@controller.response = "Ce caillou vous semble être très précieux.\n" +
								"Vous décidez de le cacher afin que personne ne vous le vole."

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					),
					Response.new("Ignorer le caillou.",
						Proc.new {
							@controller.response = "C’est un simple caillou, pourquoi lui porter de l’attention?"

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					)
				]
			),
			Scene.new("Vous vous trouvez sur le magnifique tapis oriental de mamie <mamie>.",
				nil,
				"View/Assets/Tapis.jpg", [
					Response.new("Déféquer dessus.",
						Proc.new {
							if Random.rand() > 0.4 then
								@controller.response = "La diarrhée a été plus forte que vous."
							else
								@controller.response = "Votre Mamie est revenue,\n vous avez le droit à une belle engueulade."
							end

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					),
					Response.new("Rouler dessus.",
						Proc.new {
							@controller.response = "Ce tapis est le parfait terrain de jeu !\n" +
								"Vous décidez donc de vous rouler dedans tel un petit sushi.\n" +
								"Néanmoins, une fois enroulé, la poussière vous fait éternuer à foison."

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					),
					Response.new("Dormir.",
						Proc.new {
							@controller.response = "La douceur du tapis est apaisante,\n" +
								"lentement vous vous sentez partir vers le pays des rêves."

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					)
				]
			),
			Scene.new("Vous le sentez au plus profond de votre être, vous êtes prêt !\nVous allez dire votre premier mot !",
				nil,
				"View/Assets/PremierMot.jpg", [
					Response.new("Manger",
						Proc.new {
							@controller.response = "Tel l’estomac sur patte que vous êtes,\n" +
								"vous avez choisi votre premier mot afin de réclamer trois fois\n" +
								"plus de nourriture à vos esclaves nommés parents. "

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					),
					Response.new("Ah!",
						Proc.new {
							@controller.response = "Vous ne savez pas pourquoi vous avez dit ça,\n" +
								"c’est comme si ce nom vous parlait."

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					),
					Response.new("Caca",
						Proc.new {
							@controller.response = "Ah bah bonjour la maturité,  " +
								"vos parents ont un peu honte de vous.\n" +
								"Mais bon ça finira par passer avec le temps."

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					),
					Response.new("Papa",
						Proc.new {
							@controller.response = "Vous avez choisi votre camp," +
								"votre papa est votre champion,\n" +
								"votre modèle !\n" +
								"Maman est un peu jalouse mais vous vous en fichez un peu."

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					),
					Response.new("Maman",
						Proc.new {
							@controller.response = "Vous avez choisi votre camp," +
								"votre maman est votre reine,\n" +
								"votre inspiration !\n" +
								"Papa est un peu jaloux mais vous vous en fichez un peu."

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					)
				]
			),
			Scene.new("En partant travailler, maman a oublié de fermer le fameux placard interdit.",
				nil,
				"View/Assets/Placard.jpg", [
					Response.new("Boire de l’eau de javel",
						Proc.new {
							if Random.rand() > 0.3 then
								@controller.response = "Ce n'était peut-être pas une si bonne idée."
							else
								@controller.response = "Le goût est attroce et vous met K.O pour un certain temps."
							end

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					),
					Response.new("Jouer avec les éponges",
						Proc.new {
							@controller.response = "Les petits rectangles jaunes et verts " +
								"vous supplient de les utiliser.\n" +
								"Vous les prenez en main et une vision vous envahi.\n" +
								"Vous vous voyez peindre de grands tableaux et essuyer\n " +
								"les taches de peinture avec les éponges."

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					),
					Response.new("Se cacher",
						Proc.new {
							@controller.response = "Personne ne pensera à vous chercher là dedans,\n " +
								"vous décidez donc d’entrer dans ce fort imprenable.\n " +
								"Vos parents ont mis deux jours à vous retrouver."

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					),
					Response.new("Nyarnya",
						Proc.new {
							@controller.response = "Ce placard n’est pas comme les autres, vous le sentez.\n" +
								"En entrant à l’intérieur vous vous retrouvez dans un autre monde…\n " +
								"le monde de Nyarnya."

							@life.age += 5
							@controller.currentScene = @scenes.sample
						}
					)
				]
			),
			Scene.new("Vous êtes chez vous un samedi après-midi,\naprès une longue semaine d’école.",
				nil,
				"View/Assets/Bedroom.jpg", [
					Response.new("Prendre de l’avance sur les devoirs",
						Proc.new {
							 if Random.rand() > 0.5 then
							 	@controller.response = "Vous êtes surpris de la simplicité du programme.\n" +
									"Vous avez tout compris à la leçon suivante sans\n" +
									"l’aide de la maîtresse."
							 else
								@controller.response = "Les leçons suivantes sont très difficiles à comprendre sans\n" +
									"l’aide de la maîtresse. Vous attrapez une migraine et avez même\n" +
									"l’impression de vous être embrouillé avec les leçons actuelles."
							end

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("Jouer à Raiemanne 3",
						Proc.new {
							@controller.response = "Vous n’avez pas envie d’être productif aujourd’hui.\n" +
								"Vous jouez à votre jeu vidéo préféré : Raiemanne 3."

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("Faire du sport",
						Proc.new {
							@controller.response = "Vous avez l’âme d’un sportif et le week-end est\n" +
								"le moment parfait pour vous exercer.\n" +
								"Vous sortez faire un jogging."

							@controller.currentScene = @scenes[3]
						}
					)
				]
			),
			Scene.new("A l’école vous vous trouvez dans la classe de Mme <maitresse>",
				"maitresse",
				"View/Assets/Bedroom.jpg", [
					Response.new("La mater",
						Proc.new {
							@controller.response = "Vous reluquez d’un air presque obscène votre maîtresse,\n" +
								"si bien que celle-ci le remarque et vous envoie chez le proviseur."

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("Suivre la leçon",
						Proc.new {
							@controller.response = "Vous vous concentrez sur ce qu’elle dit,\n" +
								"après tout vous êtes là pour ça."

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("Être turbulent",
						Proc.new {
							@controller.response = "La leçon est ennuyeuse au possible.\n" +
								"Vous décidez donc de vous amusez en lançant des trucs.\n" +
								"On vous envoie chez le proviseur."

							@controller.currentScene = @scenes[3]
						}
					)
				]
			),
			Scene.new("Monsieur <proviseur> n’est pas très fier de votre comportement.",
				"proviseur",
				"View/Assets/Bedroom.jpg", [
					Response.new("S’excuser",
						Proc.new {
							@controller.response = "Vous excusez et promettez de ne plus recommencer."

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("Supplier de ne pas renvoyer ",
						Proc.new {
							@controller.response = "Vous vous mettez à genoux et pleurez pour votre avenir."

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("L’insulter",
						Proc.new {
							@controller.response = "Vous lui répondez avec véhémence qu’il peut se mettre\n" +
								"ce qu’il pense de vous là où il le pense."

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("Débattre",
						Proc.new {
							@controller.response = "Vous débattez alors du mal fondé de vos actions,\n" +
								"ce qui fait traîner la réunion\n" +
								"et vous permet d’échapper à la punition."

							@controller.currentScene = @scenes[3]
						}
					)
				]
			),
			Scene.new("Durant l’activité arts plastiques vous devez chercher les fournitures\ndont vous avez besoin dans le bac de la classe.",
				nil,
				"View/Assets/Bedroom.jpg", [
					Response.new("Sniffer la colle",
						Proc.new {
							@controller.response = "Vous avez vu certaines personnes cool de la classe\n" +
								"le faire. L’odeur est enivrante et addictive,\n" +
								"elle vous fait réfléchir au sens de la vie."

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("Jouer avec le ciseau",
						Proc.new {
							if Random.rand() > 0.5 then
								@controller.response = "Vous trouvez un morceau de papier pas\n" +
									"loin et décidez de faire une jolie ribambelle."
							else
								if Random.rand() > 0.5 then
									@controller.response = "Oh non, vous avez trébuché en courant avec le ciseau\n" +
										"et avez poignardé <Billy> ! Il est mort à présent."
								else
									@controller.response = "Oh non, vous êtes tombé sur le ciseau alors\n" +
										"que vous courriez avec, vous êtes mort."

								end
							end

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("L’insulter",
						Proc.new {
							@controller.response = "Vous lui répondez avec véhémence qu’il peut se mettre\n" +
								"ce qu’il pense de vous là où il le pense."

							@controller.currentScene = @scenes[0]
						}
					),
					Response.new("Débattre",
						Proc.new {
							@controller.response = "Vous débattez alors du mal fondé de vos actions,\n" +
								"ce qui fait traîner la réunion\n" +
								"et vous permet d’échapper à la punition."

							@controller.currentScene = [ @scenes[3], @scenes[2] ].sample
						}
					)
				]
			)
		]
	end
end
