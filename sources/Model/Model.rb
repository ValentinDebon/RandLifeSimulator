require_relative 'Response'
require_relative 'Scene'

def initModel
	scenes = []
	scenes.push(new Scene(1, 'Assets/cailloux.png', 'Vous voyez un cailloux'))
	scenes[0].responses.push(new Response('Le manger', Proc.new {
		randy = Random.rand()
		if randy > 0.3 then
			0 #suite narmol
		else
			1 #RIP in Pepperonis
		end
	}, ['Ca n\'a pas beaucoup de Gout,\n vous êtes un peu déçu.', 'Vous']))
	scenes[0].responses.push(new)
	scenes[0].responses.push(new)
end
