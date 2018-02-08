
require_relative 'Controller'
require_relative 'Model/Life'
require_relative 'Model/Scene'
require_relative 'Model/Response'

class Model
	attr_accessor :life
	attr_reader :controller, :scenes

	def first
		@scenes[0..2].sample
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
							@life.instability += 1
							if Random.rand() > 0.3 then
								@controller.response = "Cela n'a aucun goût, vous êtes un peu déçu."
								@life.age += 5
								case @life.age
									when 5..14
										@controller.currentScene = [@scenes[3], @scenes[4], @scenes[5], @scenes[7], @scenes[9]].sample
									else
										@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
								end

							else
								@controller.response = "Vous vous étouffez avec."
								@controller.death = "Caillou"
							end
						}
					),
					Response.new("Jeter le caillou sur petit <enfant>.",
						Proc.new {
							@controller.response = "Tel un lanceur de baseball professionnel,\nvous lancez le caillou à toute vitesse.\n" +
								"Ce dernier heurte violemment petit <enfant>, il se met à pleurer."

							@life.age += 5
							@life.violence += 2
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[3], @scenes[4], @scenes[5], @scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
							end
						}
					),
					Response.new("Cacher le caillou.",
						Proc.new {
							@controller.response = "Ce caillou vous semble être très précieux.\n" +
								"Vous décidez de le cacher afin que personne ne vous le vole."

							@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[3], @scenes[4], @scenes[5], @scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
							end
						}
					),
					Response.new("Ignorer le caillou.",
						Proc.new {
							@controller.response = "C’est un simple caillou, pourquoi lui porter de l’attention?"

							@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[3], @scenes[4], @scenes[5], @scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
							end
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
								@controller.death = "Déshydratation"
							else
								@controller.response = "Votre Mamie est revenue,\nvous avez le droit à une belle engueulade."
								@life.age += 5
								@controller.currentScene = @scenes[8] #TODO scene engueulade
							end
						}
					),
					Response.new("Rouler dessus.",
						Proc.new {
							@controller.response = "Ce tapis est le parfait terrain de jeu !\n" +
								"Vous décidez donc de vous rouler dedans tel un petit sushi.\n" +
								"Néanmoins, une fois enroulé, la poussière vous fait éternuer à foison."

							@life.age += 5
							@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
						}
					),
					Response.new("Dormir.",
						Proc.new {
							@controller.response = "La douceur du tapis est apaisante,\n" +
								"lentement vous vous sentez partir vers le pays des rêves."

							@life.age += 5
							@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
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
							@life.instability += 1
							@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
						}
					),
					Response.new("Ah!",
						Proc.new {
							@controller.response = "Vous ne savez pas pourquoi vous avez dit ça,\n" +
								"c’est comme si ce nom vous parlait."

							@life.age += 5
							@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
						}
					),
					Response.new("Caca",
						Proc.new {
							@controller.response = "Ah bah bonjour la maturité,  " +
								"vos parents ont un peu honte de vous.\n" +
								"Mais bon ça finira par passer avec le temps."

							@life.age += 5
							@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
						}
					),
					Response.new("Papa",
						Proc.new {
							@controller.response = "Vous avez choisi votre camp," +
								"votre papa est votre champion,\n" +
								"votre modèle !\n" +
								"Maman est un peu jalouse mais vous vous en fichez un peu."

							@life.age += 5
							@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
						}
					),
					Response.new("Maman",
						Proc.new {
							@controller.response = "Vous avez choisi votre camp," +
								"votre maman est votre reine,\n" +
								"votre inspiration !\n" +
								"Papa est un peu jaloux mais vous vous en fichez un peu."

							@life.age += 5
							@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
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
								@controller.death = "Javel"
							else
								@controller.response = "Le goût est attroce et vous met K.O pour un certain temps."
								@life.age += 5
								case @life.age
									when 5..14
										@controller.currentScene = [@scenes[0],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
									else
									  @controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
								end
							end
						}
					),
					Response.new("Jouer avec les éponges",
						Proc.new {
							@controller.response = "Vous vous voyez peindre de grands tableaux et essuyer\n" +
								"les taches de peinture avec les éponges."

							@life.age += 5
							@life.art += 2
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
							end
						}
					),
					Response.new("Se cacher",
						Proc.new {
							@controller.response = "Personne ne pensera à vous chercher là dedans,\n" +
								"vous décidez donc d’entrer dans ce fort imprenable.\n" +
								"Vos parents ont mis deux jours à vous retrouver."

							@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
							end
						}
					),
					Response.new("Aller tout au fond du placard",
						Proc.new {
							@controller.response = "Ce placard n’est pas comme les autres, vous le sentez.\n" +
								"En entrant à l’intérieur vous vous retrouvez dans un autre monde…\n" +
								"le monde de Nyarnya."

							@life.age = 26
							@controller.currentScene = @scenes.sample #TODO Go Acte 3
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
								@life.intelligence += 1
							 	@controller.response = "Vous êtes surpris de la simplicité du programme.\n" +
									"Vous avez tout compris à la leçon suivante sans\n" +
									"l’aide de la maîtresse."
							 else
								@life.intelligence -= 1
								@controller.response = "Les leçons suivantes sont très difficiles à comprendre sans\n" +
									"l’aide de la maîtresse. Vous attrapez une migraine et avez même\n" +
									"l’impression de vous être embrouillé avec les leçons actuelles."
							end
							@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[3],@scenes[5],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
							end
						}
					),
					Response.new("Jouer à Raiemanne 3",
						Proc.new {
							@controller.response = "Vous n’avez pas envie d’être productif aujourd’hui.\n" +
								"Vous jouez à votre jeu vidéo préféré : Raiemanne 3."
								@life.laziness += 2
								@life.age += 5
								case @life.age
									when 5..14
										@controller.currentScene = [@scenes[0],@scenes[3],@scenes[5],@scenes[7], @scenes[9]].sample
									else
										@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
								end
						}
					),
					Response.new("Faire du sport",
						Proc.new {
							@controller.response = "Vous avez l’âme d’un sportif et le week-end est\n" +
								"le moment parfait pour vous exercer.\n" +
								"Vous sortez faire un jogging."
								@life.sport += 2
								@life.age += 5
								case @life.age
									when 5..14
										@controller.currentScene = [@scenes[0],@scenes[3],@scenes[5],@scenes[7], @scenes[9]].sample
									else
										@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
								end
						}
					)
				]
			),
			Scene.new("A l’école vous vous trouvez dans la classe de Mme <maitresse>",
				"maitresse",
				"View/Assets/ClassRoom.jpg", [
					Response.new("La mater",
						Proc.new {
							@controller.response = "Vous reluquez d’un air presque obscène votre maîtresse,\n" +
								"si bien que celle-ci le remarque et vous envoie chez le proviseur."
							@life.age += 5
							@controller.currentScene = @scenes[6]
						}
					),
					Response.new("Suivre la leçon",
						Proc.new {
							@controller.response = "Vous vous concentrez sur ce qu’elle dit,\n" +
								"après tout vous êtes là pour ça."
							@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
							end
						}
					),
					Response.new("Être turbulent",
						Proc.new {
							@controller.response = "La leçon est ennuyeuse au possible.\n" +
								"Vous décidez donc de vous amusez en lançant des trucs.\n" +
								"On vous envoie chez le proviseur."
							@life.age += 5
							@controller.currentScene = @scenes[6]
						}
					)
				]
			),
			Scene.new("Proviseur <proviseur> n’est pas très fier de votre comportement.",
				"proviseur",
				"View/Assets/HeadMasterOffice.jpg", [
					Response.new("S’excuser",
						Proc.new {
							@controller.response = "Vous excusez et promettez de ne plus recommencer."
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
							end
						}
					),
					Response.new("Supplier de ne pas renvoyer ",
						Proc.new {
							@controller.response = "Vous vous mettez à genoux et pleurez pour votre avenir."
							@life.blackSheep += 2
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
							end
						}
					),
					Response.new("L’insulter",
						Proc.new {
							@controller.response = "Vous lui répondez avec véhémence qu’il peut se mettre\n" +
								"ce qu’il pense de vous là où il le pense."
								@life.violence += 2
								@life.intelligence -= 1
								case @life.age
									when 5..14
										@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[7], @scenes[9]].sample
									else
										@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
								end
						}
					),
					Response.new("Débattre",
						Proc.new {
							@life.doubt += 2
							@controller.response = "Vous débattez alors du mal fondé de vos actions,\n" +
								"ce qui fait traîner la réunion\n" +
								"et vous permet d’échapper à la punition."
								case @life.age
									when 5..14
										@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[7], @scenes[9]].sample
									else
										@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
								end
						}
					)
				]
			),
			Scene.new("Durant l’activité arts plastiques vous devez chercher les fournitures\ndont vous avez besoin dans le bac de la classe.",
				"enfant",
				"View/Assets/ClassRoom.jpg", [
					Response.new("Sniffer la colle",
						Proc.new {
							@life.doubt += 2
							@life.drugs += 2
							@controller.response = "Vous avez vu certaines personnes cool de la classe\n" +
								"le faire. L’odeur est enivrante et addictive,\n" +
								"elle vous fait réfléchir au sens de la vie."
								@life.age += 5
								case @life.age
									when 5..14
										@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5], @scenes[9]].sample
									else
										@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
								end
						}
					),
					Response.new("Jouer avec le ciseau",
						Proc.new {
								case Random.rand()
									when 0.0..0.5
										@controller.response = "Vous trouvez un morceau de papier pas\n" +
											"loin et décidez de faire une jolie ribambelle."
										@life.age += 5
										@life.art += 2
										case @life.age
											when 5..14
												@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5], @scenes[9]].sample
											else
												@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
										end
									when 0.5..0.75
										@controller.response = "Oh non, vous avez trébuché en courant avec le ciseau\n" +
											"et avez poignardé <enfant> !"
										@life.age += 5
										case @life.age
											when 5..14
												@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5], @scenes[9]].sample
											else
												@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
										end
									when 0.75..1.0
										@controller.response = "Oh non, vous êtes tombé sur le ciseau alors\n" +
											"que vous courriez avec, vous êtes mort."
										@controller.death = "Ciseau"
									end
						}
					),
					Response.new("Manger les crayons",
						Proc.new {
							@controller.response = "Vous n’avez pas envie de faire de l’art plastique.\n" +
								"Vous mangez donc tous les crayons afin\n" +
								"que l’activité soit annulée."
							@life.age += 5
							@life.art -= 2
								case @life.age
									when 5..14
										@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5], @scenes[9]].sample
									else
										@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
								end
						}
					)
				]
			),
			Scene.new("Mamie <mamie> n’est pas très contente que son magnifique tapis\noriental ait été souillé par vos excréments.",
				"mamie",
				"View/Assets/Tapis.jpg", [
					Response.new("La Manger",
						Proc.new {
							@controller.response = "Elle n’avait que la peau sur les os et avait comme un goût\n" +
							"de verveine. C’était pas très bon."
							@life.instability += 2
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
							end
						}
					),
					Response.new("Pleurer",
						Proc.new {
							@controller.response = "Ne supportant pas l’immonde pression sociale et psychologique\n" +
							 	"que vous fait subir votre grand-mère.\n" +
								"Vous vous mettez à pleurer. "
							@life.blackSheep += 2
								case @life.age
									when 5..14
										@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
									else
										@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
								end
						}
					),
					Response.new("Débattre",
						Proc.new {
							@controller.response = "Vous expliquez à votre mamie <mamie> que vos actions\n" +
							 	"ont bien plus de sens qu’un simple caca sur un tapis."
							@life.doubt += 2
								case @life.age
									when 5..14
										@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
									else
										@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
								end
						}
					)
				]
			),
			Scene.new("Vous sortez de l’école et apercevez une camionnette blanche\navec à son bord un homme d’une quarantaine d’année.",
				"pervers",
				"View/Assets/Camionette.jpg", [
					Response.new("Monter dedans",
						Proc.new {
							@controller.response = "<pervers> est en réalité un ami de votre père,\n" +
							"il décide donc de vous ramener chez vous."
								@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5],@scenes[7]].sample
								else
									@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
							end
						}
					),
					Response.new("Rentrer à pied et jouer à Raiemanne",
						Proc.new {
							if Random.rand() > 0.8 then
								@controller.response = "Ignorant la camionnette vous décidez de rentrer chez vous\n" +
									"à pied pour jouer aux jeux vidéo."
								@life.age += 5
								@life.laziness += 2
									case @life.age
										when 5..14
											@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[5],@scenes[7],@scenes[10], @scenes[11]].sample
										else
											@controller.currentScene = [@scenes[10], @scenes[11], @scenes[12], @scenes[15]].sample #TODO scenes acte 2
									end
							else
								@controller.response = "Vous traversez sans regarder et êtes percuté par\n" +
									"une camionnette"
								@controller.death = "Camionnette"
							end
						}
					)
				]
			),
			Scene.new("Vous devez choisir une filière pour votre diplôme.",
				nil,
				"View/Assets/ClassRoom.jpg", [
					Response.new("Sciences",
						Proc.new {
							@controller.response = "Vous avez les capacités et la volonté de vous aventurer\n" +
								"dans le chemin tortueux des sciences."
							@life.intelligence += 3
							@life.doubt -= 1
							@life.art -= 1
							@life.age += 1
							case @life.age
								when 15..18
									@controller.currentScene = [@scenes[11..12] + @scenes[15..16]].sample
								else
									@controller.currentScene = @scenes.sample #TODO scenes acte 3
							end
						}
					),
					Response.new("Social",
						Proc.new {
							@controller.response = "Vous aimez les gens, leur être, leur façon de penser,\n" +
								"le social est fait pour vous !"
							@life.doubt += 3
							@life.art -= 1
							@life.intelligence -= 1
							@life.age += 1
							case @life.age
								when 15..18
									@controller.currentScene = (@scenes[11..12] + @scenes[15..16]).sample
								else
									@controller.currentScene = @scenes.sample #TODO scenes acte 3
							end
						}
					),
					Response.new("Art",
						Proc.new {
							@controller.response = "Vous vous sentez l’âme d’un créateur. Vous voulez donner vie à votre\n" +
								"imagination, vous décidez donc d’aller en littéraire. "
							@life.art += 3
							@life.doubt -= 1
							@life.intelligence -= 1
							@life.age += 1
							case @life.age
								when 15..18
									@controller.currentScene = (@scenes[11..12] + @scenes[15..16]).sample
								else
									@controller.currentScene = @scenes.sample #TODO scenes acte 3
							end
						}
					)
				]
			),
			Scene.new("Votre crush <ado> veut vous voir après les cours.\nVous l’avez toujours aimé.",
				"ado",
				"View/Assets/ClassRoom.jpg", [
					Response.new("Le Manger",
						Proc.new {
							@controller.response = "Lors de votre tête à tête, vous avez paniqué et l’avez mangé.\n" +
								"C’est malin, pour une fois que quelqu’un vous aimait."
							@life.love -= 2
							@life.instability += 2
							@life.age += 1
							case @life.age
								when 15..18
									@controller.currentScene = [@scenes[10],@scenes[12], @scenes[15], @scenes[16]].sample
								else
									@controller.currentScene = @scenes.sample #TODO scenes acte 3
							end
						}
					),
					Response.new("Déclarer sa flamme",
						Proc.new {
							@controller.response = "Vous avez pris votre courage en main,\n" +
								"vous l’aimez depuis trop longtemps il est tant qu’il le sache !\n" +
								"Et il a dit oui !"
							@life.love += 3
							@life.age += 1
							case @life.age
								when 15..18
									@controller.currentScene = [@scenes[10],@scenes[12], @scenes[15], @scenes[16]].sample
								else
									@controller.currentScene = @scenes.sample #TODO scenes acte 3
							end
						}
					),
					Response.new("Se cacher dans le placard",
						Proc.new {
							@controller.response = "Pour échapper à la honte d’un potentiel rejet,\n" +
							 "vous décidez de vous cacher dans le placard.\n" +
							 "Vous vous retrouvez alors dans un autre monde… le monde de Nyarnya.\n"

							@life.age = 26
							@controller.currentScene = @scenes.sample #TODO Go Acte 3
						}
					)
				]
			),
			Scene.new("Tokyo Hauntel a sorti un nouvel album !",
				nil,
				"View/Assets/ClassRoom.jpg", [
					Response.new("C’est génial ! Je l’achète en 50 exemplaires !",
						Proc.new {
							@controller.playSound('View/Assets/Musics/Sexual Healing.mp3')
							@controller.response = "Vous adorez Tokyo Hauntel au plus haut point\n"
							@life.wealth -= 2
							@controller.currentScene = @scenes[13]
						}
					),
					Response.new("J’irai l’écouter une fois que j’en aurai fini avec ADDA.",
						Proc.new {
						 	@controller.playSound('View/Assets/Musics/Gimme! Gimme! Gimme!.mp3')
							@controller.response = "Qui écouterait du Tokyo Hauntel alors qu'ADDA a sortit un album ?\n" +
							 "Pas vous en tout cas !"
							@controller.currentScene = @scenes[14]
						}
					),
					Response.new("Je ne m’en préoccupe pas.",
						Proc.new {
							@controller.response = "Qui écoute encore du Tokyo Hauntel de nos jours ?\n" +
							 "Pas vous en tout cas !"
							 @life.age += 1
					 		case @life.age
					 			when 15..18
					 				@controller.currentScene = [@scenes[10],@scenes[11],scenes[15], @scenes[16]].sample
					 			else
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
					 		end
						}
					)
				]
			),
			Scene.new("Vous vous métamorphosez en une créature\ntourmentée par ses émotions.",
				nil,
				"View/Assets/ClassRoom.jpg", [
					Response.new("Je me sens enfin moi-même.",
						Proc.new {
							@controller.response = "Vous vous mettez à porter que du noir,\n" +
							 "écouter des musiques sombres et\n" +
							 "écrire des poèmes reflétant le tréfond de votre âme."
							@life.art += 2
							@life.age += 1
							case @life.age
					 			when 15..18
					 				@controller.currentScene = [@scenes[10],@scenes[11],@scenes[15], @scenes[16]].sample
					 			else
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
					 		end
						}
					),
					Response.new("J’ai peur que ce ne soit qu’une phase.",
						Proc.new {
							@controller.response = "Vous vous mettez à réfléchir et avez peur\n" +
							 "que ce voile de ténèbres dans lequel\n" +
							 "vous vous êtes enveloppé ne soit que temporaire."
								@life.doubt += 2
								@life.instability += 1
								@life.age += 1
								case @life.age
						 			when 15..18
						 				@controller.currentScene = [@scenes[10],@scenes[11],@scenes[15], @scenes[16]].sample
						 			else
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
						 		end
						}
					)
				]
			),
			Scene.new("Vous n’avez que 17 ans et êtes jeune et beau.",
				nil,
				"View/Assets/ClassRoom.jpg", [
					Response.new("Tant mieux !",
						Proc.new {
							@controller.response = "Vous le savez mieux que quiconque."
								@life.age += 1
								case @life.age
						 			when 15..18
						 				@controller.currentScene = [@scenes[10],@scenes[11],@scenes[15], @scenes[16]].sample
						 			else
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
						 		end
						}
					),
					Response.new("Vous êtes la reine de la danse.",
						Proc.new {
							@controller.response = "Enfin surtout dans votre chambre."
								@life.sport += 1
								@life.age += 1
								case @life.age
						 			when 15..18
						 				@controller.currentScene = [@scenes[10],@scenes[11],@scenes[15], @scenes[16]].sample
						 			else
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
						 		end
						}
					),
					Response.new("Ressentez le rythme du tambourin",
						Proc.new {
							@controller.response = "Vous vous sentez en accord avec la musique et vous même."
								@life.art += 1
								@life.age += 1
								case @life.age
						 			when 15..18
						 				@controller.currentScene = [@scenes[10],@scenes[11],@scenes[15], @scenes[16]].sample
						 			else
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
						 		end
						}
					)
				]
			),
			Scene.new("Vous vous questionnez sur l’orientation Omo.",
				nil,
				"View/Assets/ClassRoom.jpg", [
					Response.new("Cela vous correspond.",
						Proc.new {
							@controller.response = "Vous achetez donc de la lessive Omo pour votre mère."
								@life.age += 1
								case @life.age
						 			when 15..18
						 				@controller.currentScene = (@scenes[10..12] + [@scenes[16]]).sample
						 			else
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 2 university
						 		end
						}
					),
					Response.new("Cela ne vous correspond pas.",
						Proc.new {
							@controller.response = "Vous décidez d’acheter de la lessive Bonne-ux pour votre mère."
								@life.sport += 1
								@life.age += 1
								case @life.age
						 			when 15..18
						 				@controller.currentScene = (@scenes[10..12] + [@scenes[16]]).sample
						 			else
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 2 university
						 		end
						}
					)
				]
			),
			Scene.new("Vous rencontrez <ado> dans la rue.",
				"ado",
				"View/Assets/ClassRoom.jpg", [
					Response.new("Le frapper.",
						Proc.new {
							@controller.response = "Vous n’aimez pas sa tête\n" +
								"et vous êtes décidé à lui faire savoir." +
								"Vous le frappez donc violemment."
							@life.violence += 2
							@life.age += 1
							case @life.age
					 			when 15..18
					 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample
					 			else
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 2 university
					 		end
						}
					),
					Response.new("Lui parler.",
						Proc.new {
							if Random.rand() > 0.5 then
									@controller.response = "Il n’aime pas votre tête\n" +
										"et a décidé à vous le faire savoir. Il vous frappe donc violemment."
									@life.blackSheep += 2
							else
									@controller.response = "La conversation se fait facilement, vous flirtez innocemment."
									@life.love += 2
							end
							@life.age += 1
							case @life.age
								when 15..18
									@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample
								else
									@controller.currentScene = @scenes.sample #TODO scenes acte 2 university
							end
						}
					),
					Response.new("L'ignorer.",
						Proc.new {
							@controller.response = "Vous n’avez pas de temps à lui consacrez et poursuivez votre chemin."
							@life.age += 1
							case @life.age
					 			when 15..18
					 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample
					 			else
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 2 university
					 		end
						}
					)
				]
			),
			Scene.new("Que souhaitez-vous faire après la fac ?",
				nil,
				"View/Assets/ClassRoom.jpg", [
					Response.new("Une ecole d’ingénieur.",
						Proc.new {
							@controller.response = "Vous souhaitez un métier bien payé et un avenir radieux,\n" +
								"l’école d’ingénieur semble être une bonne perspective."
							@life.wealth += 2
							@life.intelligence += 2
							@life.age = 26
					 		@controller.currentScene = @scenes.sample #TODO scenes acte 3
						}
					),
					Response.new("Allez dans la vie active.",
						Proc.new {
							@controller.response = "Vous avez fait assez d’études comme ça!\n" +
								"Il est temps d’aller travailler !"
							@life.age = 26
							@controller.currentScene = @scenes.sample #TODO scenes acte 3
						}
					),
					Response.new("Continuer en Master.",
						Proc.new {
							@controller.response = "La fac, au final, ce n'est pas si mal.\n" +
								"Vous décidez d’y rester encore un peu en poursuivant en Master. "
							@life.intelligence += 3
							@life.age += 1
							case @life.age
								when 18..25
					 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample #TODO acte 2 university
					 			else
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 2 university
					 		end
						}
					)
				]
			),
			Scene.new("Vous êtes en cours avec le merveilleux professeur <professeur>.",
				"professeur",
				"View/Assets/Amphi.jpg", [
					Response.new("Dormir.",
						Proc.new {
							@controller.response = "Ses cours sont extrêmement soporifiques.\n" +
								"Et si on faisait un petit somme ?"
							@life.laziness += 2
							@life.intelligence += 2
							@life.age += 1
							case @life.age
								when 18..25
					 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample #TODO acte 2 university
					 			else
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
					 		end
						}
					),
					Response.new("Le mater.",
						Proc.new {
							if Random.rand() > 0.4 then
								@controller.response = "Vous reluquez d’un air presque obscène votre maîtresse,\n" +
									"si bien que celle-ci le remarque et vous envoie chez le proviseur."
								@life.age += 5
								@controller.currentScene = @scenes[6]

							@controller.response = "Sa beauté indécente et son sex-appeal\n" +
								"vous empêchent de le quitter du regard.\n" +
								"Vous n’arrivez pas à vous concentrer sur le cours."
								@life.intelligence -= 2
								@life.age += 1
								case @life.age
									when 18..25
						 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample #TODO acte 2 university
						 			else
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
						 		end
						}
					),
					Response.new("Suivre le cours",
						Proc.new {
							@controller.response = "Vous êtes là pour étudier.\n" +
								"Vous ne laisserez rien ni personne vous distraire."
							@life.intelligence += 3
							@life.age += 1
							case @life.age
							when 18..25
					 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample #TODO acte 2 university
					 			else
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 2 university
					 		end
						}
					),
					Response.new("Ne rien comprendre",
						Proc.new {
							@controller.response = "Vous ne savez pas pourquoi ce cours est dans votre cursus,\n" +
								"il est trop compliqué pour que vous y compreniez quoi que ce soit."
							@life.intelligence -= 1
							@life.age += 1
							case @life.age
							when 18..25
					 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample #TODO acte 2 university
					 			else
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 2 university
					 		end
						}
					)
				]
			),
			Scene.new("Vous êtes en cours avec le merveilleux professeur <professeur>.",
				"professeur",
				"View/Assets/Amphi.jpg", [
					Response.new("Dormir.",
						Proc.new {
							@controller.response = "Ses cours sont extrêmement soporifiques.\n" +
								"Et si on faisait un petit somme ?"
							@life.laziness += 2
							@life.intelligence += 2
							@life.age += 1
							case @life.age
								when 18..25
					 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample #TODO acte 2 university
					 			else
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
					 		end
						}
					),
					Response.new("Le mater.",
						Proc.new {
							@controller.response = "Sa beauté indécente et son sex-appeal\n" +
								"vous empêchent de le quitter du regard.\n" +
								"Vous n’arrivez pas à vous concentrer sur le cours."
								@life.intelligence -= 2
								@life.age += 1
								case @life.age
									when 18..25
						 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample #TODO acte 2 university
						 			else
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
						 		end
						}
					),
					Response.new("Suivre le cours",
						Proc.new {
							@controller.response = "Vous êtes là pour étudier.\n" +
								"Vous ne laisserez rien ni personne vous distraire."
							@life.intelligence += 3
							@life.age += 1
							case @life.age
							when 18..25
					 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample #TODO acte 2 university
					 			else
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 2 university
					 		end
						}
					),
					Response.new("Ne rien comprendre",
						Proc.new {
							@controller.response = "Vous ne savez pas pourquoi ce cours est dans votre cursus,\n" +
								"il est trop compliqué pour que vous y compreniez quoi que ce soit."
							@life.intelligence -= 1
							@life.age += 1
							case @life.age
							when 18..25
					 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample #TODO acte 2 university
					 			else
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 2 university
					 		end
						}
					)
				]
			)
		]
	end
end
