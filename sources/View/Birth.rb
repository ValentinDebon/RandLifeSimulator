
require_relative 'TextBox'
require_relative 'Button'

class Birth
	def initialize(view)
		@view = view

		names = ["Gérard", "Alphonse", "Pablo", "Winifred", "Adolphe", "Josiane"]

		@backgroundImg = Gosu::Image.new("View/Assets/birth.jpg")
		@backBtn = Button.new("Retour", Proc.new { @view.returnToTitle }, 0.10, 0.80, 0.20, 0.15)
		@raiseBtn = Button.new("Naître", Proc.new { @view.controller.newLife(@nameTxtBox.text) if @nameTxtBox.text.length != 0 },
			0.70, 0.80, 0.20, 0.15)
		@nameTxtBox = TextBox.new(0.2, 0.2, 0.6, 0.15)
		@nameTxtBox.text = names.sample

	end

	def up(id)
	end

	def down(id)

		if id == Gosu::MS_LEFT then
			@backBtn.trigger if @backBtn.hovered
			@raiseBtn.trigger if @raiseBtn.hovered

			if @nameTxtBox.hovered then
				@view.text_input = @nameTxtBox
			else
				@view.text_input = nil
			end
		end
	end

	def update
		mx = @view.mouse_x / @view.width
		my = @view.mouse_y / @view.height

		@backBtn.update(mx, my)
		@raiseBtn.update(mx, my)
		@nameTxtBox.update(mx, my)
		@view.redraw = true if @view.text_input != nil || (mx >= 0.05 && mx <= 0.95 && my >= 0.75)
	end

	def draw
		@backgroundImg.draw(0, 0, -1, Float(@view.width)/Float(@backgroundImg.width),
			Float(@view.height)/Float(@backgroundImg.height))

		@backBtn.draw(@view.width, @view.height)
		@raiseBtn.draw(@view.width, @view.height)

		@nameTxtBox.draw(@view.width, @view.height)
	end
end

