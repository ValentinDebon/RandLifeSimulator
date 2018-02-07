
require_relative 'Button'

class DeathView
	module State
		Animating = 0
		Displaying = 1
	end

	def initialize(view)
		@view = view

		@backgroundImg = Gosu::Image.new("View/Assets/birth.jpg")
		@animStart = Gosu::milliseconds
		@duration = 3000
		@stats = Button.new(@view.controller.stats,
			Proc.new { },
			0.1, 0.1, 0.8, 0.8, @view.height / 20)

		@state = State::Animating
	end

	def up(id)
	end

	def down(id)
		if @state == State::Animating then
			@state = State::Displaying
			@view.redraw = true
		elsif @state == State::Displaying then
			@view.controller.endLife
		end
	end

	def update
		if @state == State::Animating then
			if Gosu::milliseconds >= @animStart + @duration then
				@state = State::Displaying
			end
			@view.redraw = true
		end
	end

	def draw
		if @state == State::Animating then
			step = Float(Gosu::milliseconds - @animStart) / @duration
		elsif @state == State::Displaying then
			step = 1
			@stats.draw(@view.width, @view.height)
		end

		@backgroundImg.draw(0, 0, -1, Float(@view.width)/Float(@backgroundImg.width),
			Float(@view.height)/Float(@backgroundImg.height),
			Gosu::Color.new(step * 255, 255, step * 255, step * 255))
	end
end

