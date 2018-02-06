require_relative 'Response'
require_relative 'Scene'

def initModel
	scenes = []

	scenes.push(Scene.new(1, 'Assets/Cailloux.png', 'Vous voyez un cailloux'))
	scenes.push(Scene.new(1, 'Assets/Tapis.png', 'Vous vous trouvez sur le magnifique\n tapis oriental de mamie <Mamie>.'))
	scenes.push(Scene.new(1, 'Assets/PremierMot', 'Vous le sentez au plus profond de votre être,\n vous êtes prêt !\n Vous allez dire votre premier mot !'))
	scenes.push(Scene.new(1, 'Assets/Placard', 'En partant travailler, maman a oublié de fermer le fameux placard interdit.'))


	scenes[0].responses.push(Response.new('Le manger', Proc.new {
		randy = Random.rand()
		if randy > 0.3 then
			0 #suite narmol
		else
			1 #RIP in Pepperonis
		end
		}, ['Ca n\'a pas beaucoup de Gout,\n vous êtes un peu déçu.', 'Vous vous étouffez avec.']))

	scenes[0].responses.push(Response.new('Le jetter sur Billy', Proc.new {
		0 #violence ++ suite normale
		}, ['Tel un lanceur de baseball professionnel,\n vous lancez la balle à toute vitesse.
				\n Cette dernière heurte violemment la tête de <Billy>\n qui se met à pleurer.']))

	scenes[0].responses.push(Response.new('Le Cacher', Proc.new {
		0 #suite normale
		}, ['Ce caillou vous semble être très précieux.\n
			 Vous décidez de le cacher afin que personne ne vous le vole.']))

	scenes[0].responses.push(Response.new('L\'ignorer', Proc.new {
		0
		}, ['C’est un simple caillou, pourquoi lui porter de l’attention ?']))


	scenes[1].responses.push(Response.new('Lui déféquer Dessus', Proc.new {
		randy = Random.rand()
		if randy > 0.4 then
			0 #suite narmol
		else
			1 #RIP in Pepperonis
		end
		}, ['La Diarhée a été plus forte que vous.', 'Votre Mamie est revenue,\n vous avez droit à une belle engueulade.']))

	scenes[1].responses.push(Response.new('Se Rouler dessus', Proc.new {
		0
		}, ['Ce tapis est le parfait terrain de jeu !\n
			 Vous décidez donc de vous rouler dedans tel un petit sushi.\n
			 Néanmoins, une fois enroulé, la poussière vous fait éternuer à foison.']))

	scenes[1].responses.push(Response.new('Dormir', Proc.new {
		0
		}, ['La douceur du tapis est apaisante,\n
			 lentement vous vous sentez partir vers le pays des rêves.']))



	scenes[2].responses.push(Response.new('Manger', Proc.new {
		0
		}, ['Tel l’estomac sur patte que vous êtes,\n
			 vous avez choisi votre premier mot afin de\n
			 réclamer trois fois plus de nourriture à vos esclaves nommés parents. ']))

	scenes[2].responses.push(Response.new('<Nom Random>', Proc.new {
		0
	}, ['Vous ne savez pas pourquoi vous avez dit ça, c’est comme si ce nom vous parlait.']))

	scenes[2].responses.push(Response.new('Caca', Proc.new {
		0
		}, 'Ah bah bonjour la maturité, vos parents ont un peu honte de vous.\n
		 Mais bon ça finira par passer avec le temps.'))

	scenes[2].responses.push(Response.new('Papa', Proc.new {
		0
		}, ['Vous avez choisi votre camp, votre papa est votre champion, votre modèle!\n
			 Maman est un peu jalouse mais vous vous en fichez un peu.']))

	scenes[2].responses.push(Response.new('Maman', Proc.new {
		0
		}, ['Vous avez choisi votre camp, votre maman est votre reine, votre inspiration!\n
			 Papa est un peu jaloux mais vous vous en fichez un peu.']))



  scenes[3].responses.push(Response.new('Boire de l\'Eau de Javel', Proc.new {
		randy = Random.rand()
		if randy > 0.7 then
			0 #suite narmol Fertilité--
		else
			1 #RIP in Pepperonis
		end
		}, ['La Javel n\'était pas si bonne que ça.', 'Vous ne vous sentez pas super bien après avoir ingurgité le liquide.\n
			 Vous vous sentez différent aux alentours de vos membres inférieurs comme si quelque chose avait brûlé.']))

    scenes[3].responses.push(Response.new('Jouer avec les éponges', Proc.new {
			0 #art++ chomage++
			}, ['Ce fut passionant.']))

end
#initModel
