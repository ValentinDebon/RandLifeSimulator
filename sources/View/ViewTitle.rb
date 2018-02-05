
class ViewTitle

	def initialize(controller)
		@controller = controller
	end

	def draw
		puts @controller.text
		sleep 1
	end

end

