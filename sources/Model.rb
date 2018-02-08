
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
							@controller.currentScene = @scenes.sample #TODO Go Acte 3
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
							@life.age += 2
							case @life.age
								when 17..25
									@controller.currentScene = ([@scenes[18]] + @scenes[20..21]).sample
					 			else
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
						 		end
							else
								@controller.response = "Vous décidez de ne pas répondre à\n" +
									"la convocation et de faire une grasse matinée.\n" +
									"Vous vous faites virer de l’Université !"
								@life.university = false
								@life.age = 26
								@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
								@controller.currentScene = @scenes.sample #TODO acte 3 prison
							else
								@controller.response = "Mais pourquoi vous avez fait ça ?!\n" +
									"Du coup, il ne vous embêtera plus avec vos absences."
								@life.age += 2
								case @life.age
									when 17..25
										@controller.currentScene = ([@scenes[17]] + @scenes[20..21]).sample
						 			else
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
				 				@controller.currentScene = @scenes.sample #TODO scenes acte 3 prison
							else
								@controller.response = "Vous récupérez la marchandise et profitez de votre jeunesse"
								@life.drugs += 3
								@life.wealth -= 2
								@life.age += 2
								case @life.age
								when 17..25
										@controller.currentScene = (@scenes[17..18] + [@scenes[21]]).sample
						 			else
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
								@controller.currentScene = @scenes.sample #TODO scenes acte 3 prison
							else
								@controller.response = "Vous lui vendez une bonne quantité de votre stock\n" +
									"et profitez de votre argent."
								@life.wealth += 3
								@life.age += 2
								case @life.age
								when 17..25
										@controller.currentScene = (@scenes[17..18] + [@scenes[21]]).sample
									else
										@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
								@controller.currentScene = @scenes.sample #TODO scenes acte 3 prison
							else
								@controller.response = "Vous prévenez la police de\n" +
									"l’activité illicite de <dealer>.\n" +
									"Ils arrivent et l’embarque."
								@life.age += 2
								case @life.age
								when 17..25
										@controller.currentScene = (@scenes[17..18] + [@scenes[20]]).sample
									else
										@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
								else
									@controller.response += "Vous restez à l'Université\n" +
										"malgré votre richesse"
									case @life.age
									when 17..25
											@controller.currentScene = (@scenes[17..18] + [@scenes[20]]).sample
							 			else
							 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
							 		end
								end
							else
								@controller.response = "Vous avez perdu."
								@life.age += 2
								case @life.age
								when 17..25
										@controller.currentScene = (@scenes[17..18] + [@scenes[20]]).sample
						 			else
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
					 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
									@controller.currentScene = @scenes.sample #TODO scenes acte 3
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
				 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
							else
								@controller.response = "Votre recherche ne porte pas ses fruits"
								@life.age += 2
								case @life.age
								when 17..25
										@controller.currentScene = (@scenes[17..18] + [@scenes[20]]).sample
						 			else
						 				@controller.currentScene = @scenes.sample #TODO scenes acte 3
						 		end
							end
						}
					)
				]
			)
		]
	end
end
