
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
				"View/Assets/Récré.jpg", [
					Response.new("Manger le caillou.",
						Proc.new {
							@life.instability += 1
							if Random.rand() > 0.3 then
								@controller.response = "Cela n'a aucun goût. Vous êtes un peu déçu."
								@life.age += 5
								case @life.age
									when 5..14
										@controller.currentScene = (@scenes[3..5] + [@scenes[7]] + [@scenes[9]]).sample
									else
										@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
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
									@controller.currentScene = (@scenes[3..5] + [@scenes[7]] + [@scenes[9]]).sample
								else
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
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
									@controller.currentScene = (@scenes[3..5] + [@scenes[7]] + [@scenes[9]]).sample
								else
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
							end
						}
					),
					Response.new("Ignorer le caillou.",
						Proc.new {
							@controller.response = "C’est un simple caillou. Pourquoi lui porter de l’attention?"
							@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = (@scenes[3..5] + [@scenes[7]] + [@scenes[9]]).sample
								else
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
							end
						}
					)
				]
			),
			Scene.new("Vous vous trouvez sur le magnifique tapis oriental\nde mamie <mamie>.",
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
								@controller.currentScene = @scenes[8]
							end
						}
					),
					Response.new("Rouler dessus.",
						Proc.new {
							@controller.response = "Ce tapis est le parfait terrain de jeu !\n" +
								"Vous décidez donc de vous rouler dedans tel un petit sushi.\n" +
								"Néanmoins, une fois enroulé, la poussière vous fait éternuer à foison."

							@life.age += 5
							@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[7]] + [@scenes[9]]).sample
						}
					),
					Response.new("Dormir.",
						Proc.new {
							@controller.response = "La douceur du tapis est apaisante.\n" +
								"Lentement, vous vous sentez partir vers le pays des rêves."

							@life.age += 5
							@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[7]] + [@scenes[9]]).sample
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
							@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[7]] + [@scenes[9]]).sample
						}
					),
					Response.new("Ah!",
						Proc.new {
							@controller.response = "Vous ne savez pas pourquoi vous avez dit ça.\n" +
								"C’est comme si ce nom vous parlait."

							@life.age += 5
							@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[7]] + [@scenes[9]]).sample
						}
					),
					Response.new("Caca",
						Proc.new {
							@controller.response = "Ah bah bonjour la maturité !\n" +
								"Vos parents ont un peu honte de vous.\n" +
								"Mais bon ça finira par passer avec le temps."

							@life.age += 5
							@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[7]] + [@scenes[9]]).sample
						}
					),
					Response.new("Papa",
						Proc.new {
							@controller.response = "Vous avez choisi votre camp," +
								"votre papa est votre champion,\n" +
								"votre modèle !\n" +
								"Maman est un peu jalouse mais vous vous en fichez un peu."

							@life.age += 5
							@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[7]] + [@scenes[9]]).sample
						}
					),
					Response.new("Maman",
						Proc.new {
							@controller.response = "Vous avez choisi votre camp," +
								"votre maman est votre reine,\n" +
								"votre inspiration !\n" +
								"Papa est un peu jaloux mais vous vous en fichez un peu."

							@life.age += 5
							@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[7]] + [@scenes[9]]).sample
						}
					)
				]
			),
			Scene.new("En partant travailler, maman a oublié de fermer\nle fameux placard interdit.",
				nil,
				"View/Assets/Placard.jpg", [
					Response.new("Boire de l’eau de javel",
						Proc.new {
							if Random.rand() > 0.3 then
								@controller.response = "Ce n'était peut-être pas une si bonne idée."
								@controller.death = "Javel"
							else
								@controller.response = "Le goût est atroce et vous met K.O pour un certain temps."
								@life.age += 5
								case @life.age
									when 5..14
										@controller.currentScene = [@scenes[0],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
									else
									  @controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
								end
							end
						}
					),
					Response.new("Jouer avec les éponges",
						Proc.new {
							@controller.response = "Vous vous voyez peindre de grands tableaux et essuyer\n" +
								"les taches de peinture avec ces éponges."

							@life.age += 5
							@life.art += 2
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
							end
						}
					),
					Response.new("Se cacher",
						Proc.new {
							@controller.response = "Personne ne pensera à vous chercher là dedans.\n" +
								"Vous décidez donc d’entrer dans ce fort imprenable.\n" +
								"Vos parents ont mis deux jours à vous retrouver."

							@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[4],@scenes[5],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
							end
						}
					),
					Response.new("Aller tout au fond du placard",
						Proc.new {
							@controller.response = "Ce placard n’est pas comme les autres, vous le sentez.\n" +
								"En entrant à l’intérieur vous vous retrouvez dans un autre monde…\n" +
								"le monde de Nyarnya. Vous ne voyez pas le temps passé."

							@life.age = 26
							@controller.currentScene = @scenes[25]
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
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
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
										@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
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
										@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
								end
						}
					)
				]
			),
			Scene.new("A l’école, vous vous trouvez dans la classe de Mme <maitresse>.",
				"maitresse",
				"View/Assets/ClassRoom.jpg", [
					Response.new("La mater",
						Proc.new {
							@controller.response = "Vous reluquez d’un air presque obscène votre maîtresse,\n" +
								"si bien que celle-ci le remarque et vous envoie chez le proviseur."
							@controller.currentScene = @scenes[6]
						}
					),
					Response.new("Suivre la leçon",
						Proc.new {
							@controller.response = "Vous vous concentrez sur ce qu’elle dit.\n" +
								"Après tout, vous êtes là pour ça."
							@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
							end
						}
					),
					Response.new("Être turbulent",
						Proc.new {
							@controller.response = "La leçon est ennuyeuse au possible.\n" +
								"Vous décidez donc de vous amusez en lançant des trucs.\n" +
								"On vous envoie chez le proviseur."
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
							@controller.response = "Vous vous excusez et promettez de ne plus recommencer."
							@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
							end
						}
					),
					Response.new("Supplier de ne pas renvoyer ",
						Proc.new {
							@controller.response = "Vous vous mettez à genoux et pleurez pour votre avenir."
							@life.blackSheep += 2
							@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
							end
						}
					),
					Response.new("L’insulter",
						Proc.new {
							@controller.response = "Vous lui répondez avec véhémence qu’il peut se mettre\n" +
								"ce qu’il pense de vous là où il le pense."
							@life.violence += 2
							@life.intelligence -= 1
							@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
							end
						}
					),
					Response.new("Débattre",
						Proc.new {
							@life.doubt += 2
							@controller.response = "Vous débattez alors du mal fondé de vos actions,\n" +
								"ce qui fait traîner la réunion\n" +
								"et vous permet d’échapper à la punition."
							@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = [@scenes[0],@scenes[3],@scenes[4],@scenes[7], @scenes[9]].sample
								else
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
							end
						}
					)
				]
			),
			Scene.new("Durant l’activité arts plastiques, vous devez chercher les fournitures\ndont vous avez besoin dans le bac de la classe.",
				"enfant",
				"View/Assets/ArtsPlastiques.jpg", [
					Response.new("Sniffer la colle",
						Proc.new {
							@life.doubt += 2
							@life.drugs += 2
							@controller.response = "Vous avez vu certaines personnes cool de la classe le faire." +
								"L’odeur est enivrante et addictive.\n" +
								"Elle vous fait réfléchir au sens de la vie."
								@life.age += 5
								case @life.age
									when 5..14
										@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[9]]).sample
									else
										@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
								end
						}
					),
					Response.new("Jouer avec le ciseau",
						Proc.new {
								case Random.rand()
									when 0.0..0.5
										@controller.response = "Vous trouvez un morceau de papier pas loin\n" +
											"et décidez de faire une jolie ribambelle."
										@life.age += 5
										@life.art += 2
										case @life.age
											when 5..14
												@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[9]]).sample
											else
												@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
										end
									when 0.5..0.75
										@controller.response = "Oh non, vous avez trébuché en courant avec le ciseau\n" +
											"et avez poignardé <enfant> !"
										@life.age += 5
										case @life.age
											when 5..14
												@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[9]]).sample
											else
												@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
										end
									when 0.75..1.0
										@controller.response = "Oh non, vous êtes tombé sur le ciseau alors\n" +
											"que vous courriez avec.\n" +
											"Vous êtes mort."
										@controller.death = "Ciseau"
									end
						}
					),
					Response.new("Manger les crayons",
						Proc.new {
							@controller.response = "Vous n’avez pas envie de faire de l’art plastique.\n" +
								"Vous mangez donc tous les crayons afin que\n" +
								"l’activité soit annulée."
							@life.age += 5
							@life.art -= 2
								case @life.age
									when 5..14
										@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[9]]).sample
									else
										@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
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
									@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[7]] + [@scenes[9]]).sample
								else
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
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
										@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[7]] + [@scenes[9]]).sample
									else
										@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
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
										@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[7]] + [@scenes[9]]).sample
									else
										@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
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
							@controller.response = "<pervers> est en réalité un ami de votre père.\n" +
							"Il décide donc de vous ramener chez vous."
								@life.age += 5
							case @life.age
								when 5..14
									@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[7]]).sample
								else
									@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
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
											@controller.currentScene = (@scenes[3..5] + [@scenes[0]] + [@scenes[7]]).sample
										else
											@controller.currentScene = (@scenes[10..12] + @scenes[15..16]).sample
									end
							else
								@controller.response = "Vous traversez sans regarder et êtes percuté par\n" +
									"une camionnette."
								@controller.death = "Camionnette"
							end
						}
					)
				]
			),
			Scene.new("Vous devez choisir une filière pour votre diplôme.",
				nil,
				"View/Assets/Bac.jpg", [
					Response.new("Sciences",
						Proc.new {
							@controller.response = "Vous avez les capacités et la volonté de vous aventurer\n" +
								"dans le chemin tortueux des sciences."
							@life.intelligence += 3
							@life.doubt -= 1
							@life.art -= 1
							@life.age += 1
							case @life.age
								when 15..17
									@controller.currentScene = (@scenes[11..12] + @scenes[15..16]).sample
								else
									@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
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
								when 15..17
									@controller.currentScene = (@scenes[11..12] + @scenes[15..16]).sample
								else
									@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
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
								when 15..17
									@controller.currentScene = (@scenes[11..12] + @scenes[15..16]).sample
								else
									@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
							end
						}
					)
				]
			),
			Scene.new("Votre crush <ado> veut vous voir après les cours.\nVous l’avez toujours aimé.",
				"ado",
				"View/Assets/Crush.jpg", [
					Response.new("Le Manger",
						Proc.new {
							@controller.response = "Lors de votre tête à tête, vous avez paniqué et l’avez mangé.\n" +
								"C’est malin, pour une fois que quelqu’un vous aimait."
							@life.love -= 2
							@life.instability += 2
							@life.age += 1
							case @life.age
								when 15..17
									@controller.currentScene = ([@scenes[10]] + [@scenes[12]] + @scenes[15..16]).sample
								else
									@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
							end
						}
					),
					Response.new("Déclarer sa flamme",
						Proc.new {
							@controller.response = "Vous avez pris votre courage à deux main.\n" +
								"Vous l’aimez depuis trop longtemps et il est tant qu’il le sache !\n" +
								"Et il a dit oui !"
							@life.love += 3
							@life.age += 1
							case @life.age
								when 15..17
									@controller.currentScene = ([@scenes[10]] + [@scenes[12]] + @scenes[15..16]).sample
								else
									@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
							end
						}
					),
					Response.new("Se cacher dans le placard",
						Proc.new {
							@controller.response = "Pour échapper à la honte d’un potentiel rejet,\n" +
							 "vous décidez de vous cacher dans le placard.\n" +
							 "Vous vous retrouvez alors dans un autre monde… le monde de Nyarnya.\n"

							@life.age = 26
							@controller.currentScene = @scenes[25]
						}
					)
				]
			),
			Scene.new("Tokyo Hauntel a sorti un nouvel album !",
				nil,
				"View/Assets/Concert.jpg", [
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
					 			when 15..17
									@controller.currentScene = (@scenes[10..11] + @scenes[15..16]).sample
					 			else
									@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
					 		end
						}
					)
				]
			),
			Scene.new("Vous vous métamorphosez en une créature\ntourmentée par ses émotions.",
				nil,
				"View/Assets/Emo.jpg", [
					Response.new("Je me sens enfin moi-même.",
						Proc.new {
							@controller.response = "Vous vous mettez à porter que du noir,\n" +
							 "écouter des musiques sombres et\n" +
							 "écrire des poèmes reflétant le tréfond de votre âme."
							@life.art += 2
							@life.age += 1
							case @life.age
					 			when 15..17
									@controller.currentScene = (@scenes[10..11] + @scenes[15..16]).sample
					 			else
									@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
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
						 			when 15..17
										@controller.currentScene = (@scenes[10..11] + @scenes[15..16]).sample
						 			else
										@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
						 		end
						}
					)
				]
			),
			Scene.new("Vous n’avez que 17 ans et êtes jeune et beau.",
				nil,
				"View/Assets/Pop.jpg", [
					Response.new("Tant mieux !",
						Proc.new {
							@controller.response = "Vous le savez mieux que quiconque."
								@life.age += 1
								case @life.age
						 			when 15..17
										@controller.currentScene = (@scenes[10..11] + @scenes[15..16]).sample
						 			else
										@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
						 		end
						}
					),
					Response.new("Vous êtes la reine de la danse.",
						Proc.new {
							@controller.response = "Enfin surtout dans votre chambre."
								@life.sport += 1
								@life.age += 1
								case @life.age
						 			when 15..17
										@controller.currentScene = (@scenes[10..11] + @scenes[15..16]).sample
						 			else
										@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
						 		end
						}
					),
					Response.new("Ressentez le rythme du tambourin",
						Proc.new {
							@controller.response = "Vous vous sentez en accord avec la musique et vous même."
								@life.art += 1
								@life.age += 1
								case @life.age
						 			when 15..17
										@controller.currentScene = (@scenes[10..11] + @scenes[15..16]).sample
						 			else
										@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
						 		end
						}
					)
				]
			),
			Scene.new("Vous vous questionnez sur l’orientation Omo.",
				nil,
				"View/Assets/Lessive.jpg", [
					Response.new("Cela vous correspond.",
						Proc.new {
							@controller.response = "Vous achetez donc de la lessive Omo pour votre mère."
								@life.age += 1
								case @life.age
						 			when 15..17
						 				@controller.currentScene = (@scenes[10..12] + [@scenes[16]]).sample
						 			else
										@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
						 		end
						}
					),
					Response.new("Cela ne vous correspond pas.",
						Proc.new {
							@controller.response = "Vous décidez d’acheter de la lessive Bonne-ux pour votre mère."
								@life.sport += 1
								@life.age += 1
								case @life.age
						 			when 15..17
						 				@controller.currentScene = (@scenes[10..12] + [@scenes[16]]).sample
						 			else
										@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
						 		end
						}
					)
				]
			),
			Scene.new("Vous rencontrez <ado> dans la rue.",
				"ado",
				"View/Assets/Rue.jpg", [
					Response.new("Le frapper.",
						Proc.new {
							@controller.response = "Vous n’aimez pas sa tête\n" +
								"et vous êtes décidé à le lui faire savoir." +
								"Vous le frappez donc violemment."
							@life.violence += 2
							@life.age += 1
							case @life.age
					 			when 15..17
					 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample
					 			else
									@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
					 		end
						}
					),
					Response.new("Lui parler.",
						Proc.new {
							if Random.rand() > 0.5 then
									@controller.response = "Il n’aime pas votre tête\n" +
										"et a décidé de vous le faire savoir. Il vous frappe donc violemment."
									@life.blackSheep += 2
							else
									@controller.response = "La conversation se fait facilement. Vous flirtez innocemment."
									@life.love += 2
							end
							@life.age += 1
							case @life.age
								when 15..17
									@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample
								else
									@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
							end
						}
					),
					Response.new("L'ignorer.",
						Proc.new {
							@controller.response = "Vous n’avez pas de temps à lui consacrez et poursuivez votre chemin."
							@life.age += 1
							case @life.age
					 			when 15..17
					 				@controller.currentScene = (@scenes[10..12] + [@scenes[15]]).sample
					 			else
									@controller.currentScene = (@scenes[17..18] + @scenes[20..21]).sample
					 		end
						}
					)
				]
			),
			Scene.new("Que souhaitez-vous faire après la fac ?",
				nil,
				"View/Assets/Diplome.jpg", [
					Response.new("Une école d’ingénieur.",
						Proc.new {
							@controller.response = "Vous souhaitez un métier bien payé et un avenir radieux.\n" +
								"L’école d’ingénieur semble être une bonne perspective."
							@life.wealth += 2
							@life.intelligence += 2
							@life.employment = true
							@life.age = 26
					 		@controller.currentScene = @scenes[27..32].sample
						}
					),
					Response.new("Allez dans la vie active.",
						Proc.new {
							@controller.response = "Vous avez fait assez d’études comme ça!\n" +
								"Il est temps d’aller travailler !"
							@life.age = 26
							@controller.currentScene = @scenes[26..30].sample
						}
					),
					Response.new("Continuer en Master.",
						Proc.new {
							@controller.response = "La fac, au final, ce n'est pas si mal.\n" +
								"Vous décidez d’y rester encore un peu en poursuivant en Master. "
							@life.intelligence += 3
							@life.age += 2
							case @life.age
								when 17..25
									@controller.currentScene = ([@scenes[18]] + @scenes[20..21]).sample
					 			else
					 				@controller.currentScene = @scenes[26..30].sample
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
							@life.age += 2
							case @life.age
								when 17..25
									@controller.currentScene = ([@scenes[17]] + @scenes[20..21]).sample
					 			else
					 				@controller.currentScene = @scenes[26..30].sample
					 		end
						}
					),
					Response.new("Le mater.",
						Proc.new {
							if Random.rand() > 0.4 then
								@controller.response = "Vous reluquez d’un air presque obscène votre professeur,\n" +
									"si bien que celui-ci le remarque et vous envoie chez le directeur."
								@life.age += 1
								@life.intelligence -= 2
								@controller.currentScene = @scenes[19]
							else
								@controller.response = "Sa beauté indécente et son sex-appeal\n" +
									"vous empêchent de le quitter du regard.\n" +
									"Vous n’arrivez pas à vous concentrer sur le cours."
								@life.intelligence -= 2
								@life.age += 2
								case @life.age
									when 17..25
										@controller.currentScene = ([@scenes[17]] + @scenes[20..21]).sample
						 			else
					 					@controller.currentScene = @scenes[26..30].sample
									end
							end
						}
					),
					Response.new("Suivre le cours",
						Proc.new {
							@controller.response = "Vous êtes là pour étudier.\n" +
								"Vous ne laisserez rien ni personne vous distraire."
							@life.intelligence += 3
							@life.age += 2
							case @life.age
							when 17..25
								@controller.currentScene = ([@scenes[17]] + @scenes[20..21]).sample
					 			else
					 				@controller.currentScene = @scenes[26..30].sample
					 		end
						}
					),
					Response.new("Ne rien comprendre",
						Proc.new {
							@controller.response = "Vous ne savez pas pourquoi ce cours est dans votre cursus.\n" +
								"Il est trop compliqué pour que vous y compreniez quoi que ce soit."
							@life.intelligence -= 1
							@life.age += 2
							case @life.age
							when 17..25
								@controller.currentScene = ([@scenes[17]] + @scenes[20..21]).sample
					 			else
									@controller.currentScene = @scenes[26..30].sample
					 		end
						}
					)
				]
			),
			Scene.new("Vous êtes convoqué dans le bureau du directeur <proviseur>\nà cause de votre grand nombre d’absences.",
				"proviseur",
				"View/Assets/HeadMasterOffice.jpg", [
					Response.new("Ne pas y aller.",
						Proc.new {
							if Random.rand() > 0.8 then
								@controller.response = "Vous décidez de ne pas répondre à\n" +
									"la convocation et de faire une grasse matinée."
								@life.laziness += 2
								@life.intelligence -= 2
								@life.age += 2
								case @life.age
									when 17..25
										@controller.currentScene = ([@scenes[17]] + @scenes[20..21]).sample
						 			else
										@controller.currentScene = @scenes[26..30].sample
						 		end
							else
								@controller.response = "Vous décidez de ne pas répondre à\n" +
									"la convocation et de faire une grasse matinée.\n" +
									"Vous vous faites virer de l’Université !"
								@life.university = false
								@life.age = 26
								@controller.currentScene = @scenes[26..30].sample
							end
						}
					),
					Response.new("Manger le directeur.",
						Proc.new {
							@life.instability += 3
							if Random.rand() > 0.6 then
								@controller.response = "Mais pourquoi vous avez fait ça ?!\n" +
									"Bah bravo maintenant vous allez en prison."
								@life.age = 26
								@life.prison = true
								@controller.currentScene = @scenes[23]
							else
								@controller.response = "Mais pourquoi vous avez fait ça ?!\n" +
									"Du coup, il ne vous embêtera plus avec vos absences."
								@life.age += 2
								case @life.age
									when 17..25
										@controller.currentScene = ([@scenes[17]] + @scenes[20..21]).sample
						 			else
										@controller.currentScene = @scenes[26..30].sample
						 		end
							end
						}
					),
					Response.new("Y aller et se justifier.",
						Proc.new {
							@controller.response = "Vous décidez de tout remettre\n" +
								"à plat et de justifier vos absences."
							@life.age += 2
							case @life.age
							when 17..25
									@controller.currentScene = ([@scenes[17]] + @scenes[20..21]).sample
					 			else
									@controller.currentScene = @scenes[26..30].sample
					 		end
						}
					)
				]
			),
			Scene.new("Vous rencontrez votre fournisseur <dealer>\nau coin d’une ruelle sombre.",
				"dealer",
				"View/Assets/Ruelle.jpg", [
					Response.new("Acheter des stupéfiants.",
						Proc.new {
							if Random.rand() > 0.2 then
								@controller.response = "Vous êtes sur le point de récupérer la marchandise\n" +
									"quand la police arrive et vous arrête.\n" +
									"Votre fournisseur arrive à s’enfuir avec votre argent."
								@life.wealth -= 3
								@life.drugs += 2
								@life.age = 26
								@life.prison = true
								@controller.currentScene = @scenes[23]
							else
								@controller.response = "Vous récupérez la marchandise et profitez de votre jeunesse"
								@life.drugs += 3
								@life.wealth -= 2
								@life.age += 2
								case @life.age
								when 17..25
										@controller.currentScene = (@scenes[17..18] + [@scenes[21]]).sample
						 			else
										@controller.currentScene = @scenes[26..30].sample
						 		end
							end
						}
					),
					Response.new("Vendre des stupéfiants.",
						Proc.new {
							if Random.rand() > 0.4 then
								@controller.response = "Vous lui vendez une bonne quantité de votre stock,\n" +
									"mais la police arrive et vous arrête. "
								@life.wealth += 1
								@life.age = 26
								@life.prison = true
								@controller.currentScene = @scenes[23]
							else
								@controller.response = "Vous lui vendez une bonne quantité de votre stock\n" +
									"et profitez de votre argent."
								@life.wealth += 3
								@life.age += 2
								case @life.age
								when 17..25
										@controller.currentScene = (@scenes[17..18] + [@scenes[21]]).sample
									else
										@controller.currentScene = @scenes[26..30].sample
								end
							end
						}
					),
					Response.new("Dénoncer à la police.",
						Proc.new {
							@life.drugs -= 2
							if Random.rand() > 0.3 then
								@controller.response = "Vous prévenez la police de\n" +
									"l’activité illicite de <dealer>." +
									"Ils arrivent et vous embarque tous les deux."
								@life.age = 26
								@life.prison = true
								@controller.currentScene = @scenes[23]
							else
								@controller.response = "Vous prévenez la police de\n" +
									"l’activité illicite de <dealer>.\n" +
									"Ils arrivent et l’embarque."
								@life.age += 2
								case @life.age
								when 17..25
										@controller.currentScene = (@scenes[17..18] + [@scenes[20]]).sample
									else
										@controller.currentScene = @scenes[26..30].sample
								end
							end
						}
					)
				]
			),
			Scene.new("Vous déprimez sur votre canapé\ncar vous avez des problèmes à la fac.",
				nil,
				"View/Assets/Canapé.jpg", [
					Response.new("Jouer au loto.",
						Proc.new {
							if Random.rand() > 0.005 then
								@controller.response = "Vous avez gagné le gros lot ! Félicitations !\n"
								@life.wealth += 8
								if Random.rand() > 0.5 then
									@controller.response += "Vous décidez de quitter l'Université."
									@life.age = 26
									@life.university = false
									@controller.currentScene = @scenes[26..30].sample
								else
									@controller.response += "Vous restez à l'Université\n" +
										"malgré votre richesse"
									case @life.age
									when 17..25
											@controller.currentScene = (@scenes[17..18] + [@scenes[20]]).sample
							 			else
											@controller.currentScene = @scenes[26..30].sample
							 		end
								end
							else
								@controller.response = "Vous avez perdu."
								@life.age += 2
								case @life.age
								when 17..25
										@controller.currentScene = (@scenes[17..18] + [@scenes[20]]).sample
						 			else
										@controller.currentScene = @scenes[26..30].sample
						 		end
							end
						}
					),
					Response.new("Dormir.",
						Proc.new {
							@controller.response = "Vous ne vous sentez pas productif aujourd’hui.\n" +
								"Vous décidez de faire un petit somme sur le canapé."
							@life.laziness += 1
							@life.age += 2
							case @life.age
							when 17..25
									@controller.currentScene = (@scenes[17..18] + [@scenes[20]]).sample
					 			else
									@controller.currentScene = @scenes[26..30].sample
					 		end
						}
					),
					Response.new("Manger des chips.",
						Proc.new {
							@controller.response = "Le goût salé des chips vous remonte\n" +
								"un peu le moral et vous aide à affronter cette journée."
							@life.age += 2
							case @life.age
							when 17..25
									@controller.currentScene = (@scenes[17..18] + [@scenes[20]]).sample
								else
									@controller.currentScene = @scenes[26..30].sample
							end
						}
					),
					Response.new("Chercher un emploi.",
						Proc.new {
							if Random.rand() > 0.3 then
								@controller.response = "Vous avez trouver un emploi !\n"
								@life.wealth += 3
								@life.age = 26
								@life.employment = true
								@controller.currentScene = @scenes[27..32].sample
							else
								@controller.response = "Votre recherche ne porte pas ses fruits"
								@life.age += 2
								case @life.age
								when 17..25
										@controller.currentScene = (@scenes[17..18] + [@scenes[20]]).sample
						 			else
										@controller.currentScene = @scenes[26..30].sample
						 		end
							end
						}
					)
				]
			),
			Scene.new("C’est l’heure de se décrasser.\n" +
				"Vous êtes dans les douches communes\n" +
				"lorsque soudain vous faites tomber votre savonnette.",
				nil,
				"View/Assets/Douche.jpg", [
					Response.new("Manger la Savonnette.",
						Proc.new {
							if Random.rand() > 0.9 then
								@controller.response = "Ce n’est pas très bon!\n" +
									"Et en plus, vous n’avez plus de quoi vous doucher. Bravo !"
								@life.age += 1
								@life.instability += 2
								@life.cleanliness -= 2
				 				@controller.currentScene = @scenes[24]
							else
								@controller.response += "Vous vous étouffez avec le savon et mourrez.\n"
								@controller.death = "Savon"
							end
						}
					),
					Response.new("Ramasser la Savonnette.",
						Proc.new {
							@controller.response = "Vous êtes propre comme un sou neuf !"
							@life.cleanliness += 3
							@life.age += 2
							@controller.currentScene = @scenes[24]
						}
					)
				]
			),
			Scene.new("C’est l’heure des activités !",
				nil,
				"View/Assets/Prison.jpg", [
					Response.new("Participer à l’activité tricot.",
						Proc.new {
							@controller.response = "Vous êtes le détenu le plus doué de la prison.\n" +
							"Tout le monde vous demande des conseils !"
							@life.age += 2
							@life.art += 2
			 				@controller.currentScene = @scenes[22]
						}
					),
					Response.new("Se battre avec vos co-détenus.",
						Proc.new {
							if Random.rand() > 0.5 then
								@controller.response = "Ils sont des adversaires redoutables.\n" +
									"Mais ils ne sont pas de taille face à vos prouesses au combat."
								@life.violence += 3
								@life.sport += 2
							else
								@controller.response = "Vous n'auriez pas dû... Ils vous battent à plates coutures."
								@life.blackSheep += 3
							end
							@life.age += 1
							@life.instability += 2
							@controller.currentScene = @scenes[22]
						}
					),
					Response.new("Se repentir et réfléchir au sens de la vie.",
						Proc.new {
							@controller.response = "Vous passez l’après-midi sur votre lit à réfléchir\n" +
								"à ce que vous avez fait et\n" +
								"sentez que vous devenez quelqu’un de plus respectable. "
							@life.age += 1
							@life.instability -= 2
							@life.violence -= 1
							@life.doubt += 1
							@controller.currentScene = @scenes[22]
						}
					)
				]
			),
			Scene.new("Vous êtes enfin sortie ! Que faire désormais ?",
				nil,
				"View/Assets/Rue.jpg", [
					Response.new("Aller chez ses parents",
						Proc.new {
							@controller.response = "Votre mère vous accueille à bras ouvert."
							@life.age += 5
							@life.love += 3
							case @life.age
								when 26..60
									out = @scenes[29..30]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out << @scenes[31..32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					),
					Response.new("Rejoindre la vie active.",
						Proc.new {
							@controller.response = "Un ancien détenu vous embauche pour\n" +
							"faire la plonge dans son restaurant."
							@life.age += 3
							@life.wealth += 1
							@life.employment = true
							case @life.age
								when 26..60
									out = @scenes[29..32]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					),
					Response.new("Adopter un chien",
						Proc.new {
							@controller.response = "Vous adoptez un énorme toutou trop mignon."
							@life.age += 3
							@life.dog = true
							@life.instability -= 2
							@life.violence -= 1
							case @life.age
								when 26..60
									out = @scenes[29..30]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out << @scenes[31..32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					)
				]
			),
			Scene.new("Votre instabilité psychologique vous a mener en hôpital psychatrique.\nQue faites-vous ?",
				nil,
				"View/Assets/Hospital Psy.jpg", [
					Response.new("Discuter de la psychanalyse Freudienne.",
						Proc.new {
							@controller.response = "La discussion est très intéressante.\n" +
								"Freud est de loin l'une des personnes les plus haït\n" +
								"dans le domaine de la psychatrie !"
							@life.age += 2
							@life.instability -= 2
							@life.doubt +=1
							@controller.currentScene = @scenes[22]
						}
					),
					Response.new("Prendre vos médicaments.",
						Proc.new {
							@controller.response = "Les petites pilules rouges ressemblent à des bonbons\n" +
							 	"et s’avalent sans problème."
							@life.age += 1
							@life.instability -= 1
							@controller.currentScene = @scenes[22]
						}
					),
					Response.new("Voler dans les affaires de votre voisin de chambre.",
						Proc.new {
							if Random.rand() > 0.5
								@controller.response = "Vous fouillez dans ses affaires\n" +
									"et récupérez des objets qui vous intéressent."
							else
								@controller.response = "Vous vous faites attraper la main dans le sac.\n" +
									"Vous ne prenez rien mais il n'a plus grand confiance en vous."
							end
							@life.age += 1
							@life.instability += 2
							@controller.currentScene = @scenes[22]
						}
					)
				]
			),
			Scene.new("Vous recherchez un emploi. Dans quel domaine ?",
				nil,
				"View/Assets/Chomage.jpg", [
					Response.new("Domaine de l’art.",
						Proc.new {
							if Random.rand() > 0.4 then
								@controller.response = "Poursuivant votre inspiration sans fin,\n" +
									"vous décidez de vous lancer dans l’art ! "
								@life.art += 2
								@life.wealth += 1
								@life.employment = true
							else
								@controller.response = "Les recherches sont infructueuses."
							end
							@life.age += 5
							case @life.age
								when 26..60
									out = @scenes[29..30]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out += @scenes[31..32]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					),
					Response.new("Domaine de la science.",
						Proc.new {
							if Random.rand() > 0.8 then
								@controller.response = "Poursuivant votre soif de découverte et de logique,\n" +
									"vous rejoignez le monde des sciences."
								@life.intelligence += 2
								@life.wealth += 3
								@life.employment = true
							else
								@controller.response = "Les recherches sont infructueuses."
							end
							@life.age += 5
							case @life.age
								when 26..60
									out = @scenes[29..30]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out += @scenes[31..32]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					),
					Response.new("Domaine psychologique",
						Proc.new {
							if Random.rand() > 0.5 then
								@controller.response = "Poursuivant votre quête de la compréhension de l’être humain,\n" +
									"vous décidez de devenir psychologue à plein temps."
								@life.doubt += 5
								@life.wealth += 2
								@life.instability -= 3
								@life.employment = true
							else
								@controller.response = "Les recherches sont infructueuses.\n" +
								 "En même temps, vous vous attendiez à quoi avec ce domaine ?"
							end
							@life.age += 5
							case @life.age
								when 26..60
									out = @scenes[29..30]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out += @scenes[31..32]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					)
				]
			),
			Scene.new("C’est le jour de votre mariage.\nVotre futur femme <mariee> vous attend devant l’autel.",
				"mariee",
				"View/Assets/Eglise.jpg", [
					Response.new("Manger l’alliance.",
						Proc.new {
							if Random.rand() > 0.4 then
								@controller.response = "Vous manger votre alliance devant les yeux ébahis de vos invités.\n" +
									"Ils ont interprété ça comme le fait que vous vouliez garder\n" +
									"votre amour au plus profond de votre être."
								@life.love += 2
								@life.marriedTo = @controller.formatText("<mariee>")
								@life.age += 5
								case @life.age
									when 26..60
										out = @scenes[29..30]
										if @life.child == nil then
											out << @scenes[28]
										end
										if @life.employment == true then
											out += @scenes[31..32]
										else
											out << @scenes[26]
										end
										@controller.currentScene = out.sample
									else
										@controller.currentScene = @scenes[33..40].sample
								end
							else
								@controller.response = "Vous vous étouffer sur l'alliance et mourrez."
								@controller.death = "Alliance"
							end
						}
					),
					Response.new("Donner un discours émouvant.",
						Proc.new {
							@controller.response = "Vous surprenez tout le monde avec vos talents d’orateur\n" +
								"et faites pleurer l’amour de votre vie. "
							@life.art += 2
							@life.marriedTo = @controller.formatText("<mariee>")
							@life.age += 5
							case @life.age
								when 26..60
									out = @scenes[29..30]
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out += @scenes[31..32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					),
					Response.new("Pleurer de joie",
						Proc.new {
							@controller.response = "Vous pleurez devant devant tout le monde\n" +
								"telle la grosse victime que vous êtes."
							@life.blackSheep += 3
							@life.marriedTo = @controller.formatText("<mariee>")
							@life.age += 5
							case @life.age
								when 26..60
									out = @scenes[29..30]
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out += @scenes[31..32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					)
				]
			),
			Scene.new("Vous décidez d’avoir un enfant nommé <enfant> avec <mariee>",
				"enfant",
				"View/Assets/Birth.jpg", [
					Response.new("Manger l’enfant.",
						Proc.new {
							if Random.rand() > 0.7 then
								@controller.response = "Bah bravo ! Vous allez en prison."
								@life.instability += 4
								@life.age += 2
								@controller.currentScene = @scenes[23] #TODO acte 3 employé
							else
								@controller.response = "Génial !\n" +
									"Vous n’avez plus besoin de payer pour cette espèce de sangsue."
								@life.wealth += 1
								case @life.age
									when 26..60
										out = @scenes[29..30]
										if @life.marriedTo == nil then
											out << @scenes[27]
										end
										if @life.employment == true then
											out += @scenes[31..32]
										else
											out << @scenes[26]
										end
										@controller.currentScene = out.sample
									else
										@controller.currentScene = @scenes[33..40].sample
								end
							end
						}
					),
					Response.new("L’abandonner.",
						Proc.new {
							@controller.response = "<enfant> était tellement fan du petit poucet\n" +
								" que vous avez décidé de faire de son rêve une réalité.\n" +
								"Vous l’abandonnez dans la forêt la plus proche."
							@life.violence += 4
							@life.age += 2
							case @life.age
								when 26..60
									out = @scenes[29..30]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.employment == true then
										out += @scenes[31..32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					),
					Response.new("L’élever avec amour.",
						Proc.new {
							@controller.response = "Vous êtes un vrai parent poule et êtes\n" +
								"aux petits soins pour votre progéniture."
							@life.blackSheep += 3
							@life.child = @controller.formatText("<enfant>")
							@life.age += 2
							case @life.age
								when 26..60
									out = @scenes[29..30]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.employment == true then
										out += @scenes[31..32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					)
				]
			),
			Scene.new("Vous vous réveillez un matin, avec l’impression d’être un être\n" +
				"totalement inutile.\n" +
				"Vous faites une crise de la quarantaine.",
				nil,
				"View/Assets/House.jpg", [
					Response.new("Acheter une parsche.",
						Proc.new {
							@controller.response = "Une nouvelle voiture pourrait vous remonter le morale !"
							@life.wealth -= 5
							@life.car = "parsche"
							@life.age += 2
							case @life.age
								when 26..60
									out = [@scenes[30]]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out += @scenes[31..32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					),
					Response.new("Elever des yaks en Mongolie.",
						Proc.new {
							@controller.response = "Vous n’en pouvez plus de votre vie actuelle\n" +
							"et décidez de tout plaquer pour partir en Mongolie élever des yaks."
							@life.violence -= 4
							@life.car = "yak"
							@life.age = 60
							@controller.currentScene = @scenes[33..40].sample
						}
					),
					Response.new("Tromper son conjoint.",
						Proc.new {
							@controller.response = "Vous avez besoin de changement et décidez de\n" +
								"tromper votre conjoint avec <maitresse>."
							@life.love -= 3
							@life.age += 5
							case @life.age
								when 26..60
									out = [@scenes[30]]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out += @scenes[31..32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					)
				]
			),
			Scene.new("Au détour de votre immeuble, vous apercevez\n" +
				"une camionnette blanche à la vente.",
				nil,
				"View/Assets/Combi.jpg", [
					Response.new("L’acheter.",
						Proc.new {
							@controller.response = "Vous décidez à l’acheter,\n" +
								"car elle vous rappelle votre enfance.\n" +
								"Vous ne savez pas trop pourquoi..."
							@life.wealth -= 2
							@life.car = "camionnette"
							@life.age += 5
							case @life.age
								when 26..60
									out = [@scenes[29]]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out += @scenes[31..32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					),
					Response.new("Passer devant.",
						Proc.new {
							@controller.response = "Vous passez devant comme si vous ne l’aviez pas vue."
							@life.age += 5
							case @life.age
								when 26..60
									out = [@scenes[29]]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out += @scenes[31..32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					),
					Response.new("Parler au propriétaire.",
						Proc.new {
							@controller.response = "Vous parlez avec le propriétaire de la camionnette\n" +
								"qui ne vous inspire pas du tout confiance."
							@life.doubt += 3
							@life.age += 5
							case @life.age
								when 26..60
									out = [@scenes[29]]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out += @scenes[31..32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					)
				]
			),
			Scene.new("Vous n’êtes pas satisfait du travail de <adulte>.",
				"adulte",
				"View/Assets/Office.jpg", [
					Response.new("Le virer.",
						Proc.new {
							if Random.rand() > 0.6 then
								@controller.response = "Il a dû plier bagages et quitter le bâtiment.\n" +
								"Votre manager satisfait vous donne une prime."
								@life.wealth += 4
								@life.violence += 2
							else
								@controller.response = "<adulte> ne se laisse pas faire et arrive à vous faire virer."
								@life.wealth -= 3
								@life.blackSheep += 4
								@life.employment = false
							end
							@life.age += 5
							case @life.age
								when 26..60
									out = @scenes[29..30]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out << @scenes[32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					),
					Response.new("Ne rien faire.",
						Proc.new {
							@controller.response = "C’est au manager de faire quelque chose pas à vous."
							@life.age += 5
							case @life.age
								when 26..60
									out = @scenes[29..30]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out << @scenes[32]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					)
				]
			),
			Scene.new("Vous demandez une augmentation dans le bureau du patron <proviseur>.",
				"proviseur",
				"View/Assets/OfficePromotion.jpg", [
					Response.new("Passer sous le bureau.",
						Proc.new {
							if Random.rand() > 0.2 then
								@controller.response = "Le patron, qui cherchait une excuse pour vous,\n" +
									"renvoyer est ravi que vous ayez tenté quelque chose.\n" +
									"Il peut donc vous licencier en toute impunité."
								@life.employment = false
								@life.wealth -= 2
							else
								@controller.response = "Vous ramassez le stylo de votre patron.\n" +
									"Il vous remercie en vous offrant un poste mieux payé."
								@life.wealth += 5
							end
								@life.age += 5
								case @life.age
									when 26..60
										out = @scenes[29..30]
										if @life.marriedTo == nil then
											out << @scenes[27]
										end
										if @life.child == nil then
											out << @scenes[28]
										end
										if @life.employment == true then
											out << @scenes[31]
										else
											out << @scenes[26]
										end
										@controller.currentScene = out.sample
									else
										@controller.currentScene = @scenes[33..40].sample
								end
						}
					),
					Response.new("Manger le patron.",
						Proc.new {
							if Random.rand() > 0.6 then
								@controller.response = "Bah bravo ! Vous allez en prison."
								@life.age += 2
								@controller.currentScene = @scenes[22]
							else
								@controller.response = "On est ce qu'on mange. Vous devenez donc le patron."
								@life.instability += 4
								@life.wealth += 3
								case @life.age
									when 26..60
										out = @scenes[29..30]
										if @life.marriedTo == nil then
											out << @scenes[27]
										end
										if @life.child == nil then
											out << @scenes[28]
										end
										if @life.employment == true then
											out << @scenes[31]
										else
											out << @scenes[26]
										end
										@controller.currentScene = out.sample
									else
										@controller.currentScene = @scenes[33..40].sample
								end
							end
						}
					),
					Response.new("Jouer au Domino.",
						Proc.new {
							@controller.response = "La partie est captivante et vous oubliez de lui parler de l’augmentation."
							@life.age += 5
							case @life.age
								when 26..60
									out = @scenes[29..30]
									if @life.marriedTo == nil then
										out << @scenes[27]
									end
									if @life.child == nil then
										out << @scenes[28]
									end
									if @life.employment == true then
										out << @scenes[31]
									else
										out << @scenes[26]
									end
									@controller.currentScene = out.sample
								else
									@controller.currentScene = @scenes[33..40].sample
							end
						}
					)
				]
			),

			Scene.new("L’Infirmière <infirmiere> vous a rendu visite et veut repartir.",
				"infirmiere",
				"View/Assets/Hospital.jpg", [
				Response.new("Jouer aux dominos avec elle.",
					Proc.new {
						@life.age += 5
						if Random.rand() > 0.5 then
							@controller.response = "Vous gagnez la partie et <infirmiere> ragequit la chambre"
							@controller.currentScene = (@scenes[34..40]).sample
						else
							@controller.response = "<infirmiere> gagne la partie et vous vous mettez à pleurer \n"
								+ "comme la grosse victime que vous êtes."
							@controller.currentScene = (@scenes[34..40]).sample
						end
					}
				),
				Response.new("Lui demander de la morphine.",
					Proc.new {
						@life.age += 5
						if Random.rand() > 0.7 then
							@controller.response = "C'est rarement une bonne idée de demander de la morphine\n" +
								"à un infirmère débtante"
							@controllerdeath = 'Morphine'
						else
							@controller.response = "La Morphine vous détend énormément, vous vous sentez serein."
							@controller.currentScene = (@scenes[34..40]).sample
							@life.instability -= 2
						end
					}
				),
				Response.new("La frapper avec le déambulateur.",
					Proc.new {
						@controller.response = "Elle part dans la chambre et ne reviendra plus vous voir."
						@life.age += 1
						@life.violence += 2
						@controller.currentScene = (@scenes[34..40]).sample
					}
				)
			]
		),
		Scene.new("Votre neveu <neveu> a déféqué sur votre magnifique tapis oriental !",
			"neveu",
			"View/Assets/Hospital.jpg", [
				Response.new("Le réprimander.",
					Proc.new {
						@life.age += 5
						if Random.rand() > 0.5 then
							@controller.response = "Votre neveu n'apprécie guère et vous mange.\n" +
								"Les jeunes de nos jours..."
							@controller.death = 'Mange'
						else
							@controller.response = "<neveu> se met à pleurer mais au moins\n" +
								"vous saurez qu’il ne recommencera plus.\n"
							@controller.currentScene = (@scenes[35..40] + @scenes[33]).sample
						end
					}
				),
				Response.new("Ne rien dire.",
					Proc.new {
						@life.age += 5
						@controller.response = "Vous n’avez pas envie de vous énerver,\n" +
						 	"mais vous savez qu’il recommencera sûrement."
						@controller.currentScene = (@scenes[35..40] + @scenes[33]).sample
					}
				)
			]
		),
		Scene.new("Vous êtes en maison de retraite.",
		nil,
		"View/Assets/Hospital.jpg", [
				Response.new("Jouer à la pétanque.",
					Proc.new {
						@life.age += 5
						if Random.rand() > 0.5 then
							@controller.response = "Votre âme de sudiste vous incite à jouer à la pétanque\n" +
								"avec vos amis du cinquième âge."
							@life.sport += 2
							@controller.currentScene = (@scenes[36..40] + @scenes[33..34]).sample
						else
							@controller.response = "Vous êtes beaucoup trop fort et vous suspectent de tricher\n" +
								"pour vous offrir plus de challenge,\n" +
								"ils entreprennent de vous frapper à coup de déambulateur."
							@controller.death = 'Déambulateur'
						end
					}
				),
				Response.new("Tricher au bingo.",
					Proc.new {
						@life.age += 5
						if Random.rand() > 0.6 then
							@controller.response = "Personne ne remarque le subterfuge et\n" +
								"vous remportez le premier prix qui est un grattoir."
							@life.wealth += 1
							@controller.currentScene = (@scenes[36..40] + @scenes[33..34]).sample
						else
							@controller.response = "Les autres remarquent que vous modifiez votre grille\n" +
								"et vous apprenez vite que: \"La triche, C'est mal...\""
							@controller.death = 'Déambulateur'
						end
					}
				),
				Response.new("Voter au PPP.",
					Proc.new {
						@life.age += 5
						if Random.rand() > 0.5 then
							@controller.response = "Vous votez pour le parti d’extrême droite qui offrait\n" +
								"une revalorisation du tricot en tant que patrimoine de l’UNESCO."
							@controller.currentScene = (@scenes[36..40] + @scenes[33..34]).sample
						else
							@controller.response = "Les autres n’approuvent pas le vote pour le parti d’extrême droite.\n" +
								"Ils vous offrent donc un cours de démocratie."
							@controller.death = 'Déambulateur'
						end
					}
				),
				Response.new("Tricoter.",
					Proc.new {
						@life.age += 5
						@controller.response = "Vous faites de jolis pulls moches pour vos petits-enfants."
						@controller.currentScene = (@scenes[36..40] + @scenes[33..34]).sample
					}
				),
				Response.new("Manger.",
					Proc.new {
						@life.age += 5
						randy = Random.rand()
						if randy > 0.75 then
							@controller.response = "Vous mangez votre infirmière car elle a refusé de\n" +
								"jouer à la belotte avec vous."
							@controller.currentScene = (@scenes[36..40] + @scenes[33..34]).sample
						elsif randy > 0.5 && randy <= 0.75
							@controller.response = "Vous mangez votre déambulateur.\n" +
								"Vous espérez que ça comblera vos carences en fer."
							@controller.currentScene = (@scenes[36..40] + @scenes[33..34]).sample
						elsif randy > 0.25 && randy <= 0.5
							@controller.response = "Vous mangez le caillou." +
								"Ca passe mal..."
							@controller.death = 'Caillou'
						else
							@controller.response = "Vous mangez en cachette les pâtisseries que vous avez volé."
							@controller.currentScene = (@scenes[36..40] + @scenes[33..34]).sample
						end
					}
				)
			],
		),
			Scene.new("Une grande partie des résidents de la maison de retraite\n" +
				"s'est rassemblée pour regarder\n" +
				"des rediffusions de \" Question pour un pochtron\".",
				nil,
				"View/Assets/Hospital.jpg", [
					Response.new("Vous donnez toutes les réponses",
						Proc.new {
							@life.age += 5
							if Random.rand() > 0.7 then
								@controller.response = "Sérieux, vous êtes lourd,\n" +
									"vous vous prennez un coup de déambulateur"
								@controller.death = 'Déambulateur'
							else
								@controller.response = "Vous êtes un puit de culture,\n" +
									"tout le monde apprécie."
								@controller.currentScene = (@scenes[37..40] + @scenes[33..36]).sample
							end
						}
					),
					Response.new("C'était mieux avant.",
						Proc.new {
							@life.age += 5
							@controller.response = "Vous passez pour un gros rabas joie."
							@controller.currentScene = (@scenes[37..40] + @scenes[33..36]).sample
						}
					),
					Response.new("Vous retournez jouer à DOUM dans votre coin.",
						Proc.new {
							@life.age += 5
							@life.violence += 2
							@controller.response = "Vous avez bien fait, le nouveau présentateur" +
								"est ennuyant de toute façon."
							@controller.currentScene = (@scenes[37..40] + @scenes[33..36]).sample
						}
					)
				]
			),
			Scene.new("Votre neveu <neveu> tente de vous tuer pour récupérer l'héritage plus tôt.",
			"neveu",
			"View/Assets/Hospital.jpg", [
					Response.new("Le frapper.",
						Proc.new {
							@life.age += 5
							@life.violence += 5
							@controller.response = "Vous avez bien fait de faire du judo enfant."
							@controller.currentScene = (@scenes[38..40] + @scenes[33..36]).sample
						}
					),
					Response.new("Fuir ce monde de brutes",
						Proc.new {
							if Random.rand > 0.3 then
								@controller.response = "Vous vous prennez les pieds dans le tapis et mourrez."
								@controller.death = 'meurtre'
							else
								@life.age += 5
								@controller.response = "Vous fuyez en hurlant,\n"
									+ "la sécurité ne tarde pas à maitriser l'aggresseur."
								@controller.currentScene = (@scenes[38..40] + @scenes[33..36]).sample
							end
						}
					),
					Response.new("Il oserai tout de même pas...",
						Proc.new {
							if Random.rand > 0.5 then
								@controller.response = "Il a osé."
								@controller.death = 'meurtre'
							else
								@life.age += 5
								@controller.response = "En effet, il est faible, à l'image de son père."
								@controller.currentScene = (@scenes[38..40] + @scenes[33..36]).sample
							end
						}
					)
				]
			),
			Scene.new("Vous retrouvez votre \"ami\" d'antan <dealer>,\n" +
				"il continue, même à son grand age, \n" +
				"ses activités légalement discutables.",
				"dealer",
				"View/Assets/Hospital.jpg", [
					Response.new("Faire tourner un sucre d'orge.",
						Proc.new {
							@life.age += 5
							@controller.response = "Le \"sucre\" vous fait tourner la tête\n" +
								"une bonne soirée en perspective."
							@controller.currentScene = (@scenes[39..40] + @scenes[33..37]).sample
						}
					),
					Response.new("Prendre un buvard de grenadine.",
						Proc.new {
							@life.age += 5
							@controller.response = "C'est de la bonne grenadine.\n" +
								"Cependant vous vous méfiez du dragon près du frigo."
							@controller.currentScene = (@scenes[39..40] + @scenes[33..37]).sample
						}
					),
					Response.new("Gober un Tac-Tac.",
						Proc.new {
							@life.age += 5
							@controller.response = "Vous n'avez jamais eut une telle énergie,\n" +
								"vous faites la fête toute la nuit."
							@controller.currentScene = (@scenes[39..40] + @scenes[33..37]).sample
						}
					),
					Response.new("À votre âge ce n'est pas sérieux.",
						Proc.new {
							@life.age += 5
							@controller.response = "<dealer> s'en va dépité."
							@controller.currentScene = (@scenes[39..40] + @scenes[33..37]).sample
						}
					)
				]
			),
			Scene.new("C'est l'anniversaire de votre neveu <neveu>.",
				"neveu",
				"View/Assets/Hospital.jpg", [
					Response.new("Lui envoyer une lettre et un peu d'argent.",
						Proc.new {
							@life.age += 5
							if Random.rand() > 0.5 then
								@controller.response = "Comme d'habitude, il ne vous réponds pas."
								@controller.currentScene = (@scenes[40] + @scenes[33..38]).sample
							else
								@controller.response = "Vous recevez quelques jours plus tard une lettre de remerciement."
								@controller.currentScene = (@scenes[40] + @scenes[33..38]).sample
							end
						}
					),
					Response.new("Lui envoyer un colis rempli de CD.",
						Proc.new {
							@life.age += 5
							@controller.response = "Pas de réponse.... Justin Lieber est sans doute passé de mode."
							@controller.currentScene = (@scenes[40] + @scenes[33..38]).sample
						}
					),
					Response.new("Lui envoyer un beau pull tricoté par vos soins.",
						Proc.new {
							@life.age += 5
							if Random.rand() > 0.5 then
								@controller.response = "Vous ne tardez pas à recevoir un lettre de remerciement,\n" +
									"vous commencez à croire qu'il aime vraiment vos immondes pulls."
								@controller.currentScene = (@scenes[40] + @scenes[33..38]).sample
							else
								@controller.response = "Il ne répondes pas, c'était peut être le pull de trop?"
								@controller.currentScene = (@scenes[40] + @scenes[33..38]).sample
							end
						}
					),
					Response.new("Quel neveu? Celui qui est déshérité?",
						Proc.new {
							@life.age += 5
							@controller.response = "Vous avez bien fait de ne rien lui envoyer,\n" +
								"c'est un petit con."
							@controller.currentScene = (@scenes[40] + @scenes[33..38]).sample
						}
					)
				]
			),
			Scene.new("Vous sentez que c'est l'heure de votre dernier mot.",
				nil,
				"View/Assets/Hospital.jpg", [
					Response.new("Dites à mon conjoint que je l'ai aimé.",
						Proc.new {
							if @life.marriedTo != nil then
								@controller.response = "On lui dira"
								@controller.death = 'Vieillesse'
							else
								@controller.response = "Ces belles paroles tomberont dans l'oubli,\n" +
									"vous n'êtes pas marrié."
									@controller.death = 'Vieillesse'
							end
						}
					),
					Response.new("Allez vous faire...",
						Proc.new {
							@controller.response = "La mort vous prends de court"
							@controller.death = 'Vieillesse'
						}
					)
				]
			)
		]

	end
end
