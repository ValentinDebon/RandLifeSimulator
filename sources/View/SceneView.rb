
require_relative 'Button'

class SceneView
	module State
		Narrating = 0
		Choosing = 1
	end

	def initialize(view)
		@view = view

		@textImg = Gosu::Image.from_text("", 50)
		@textIterator = 0
		@textLastIteration = 0
		@text = @view.controller.sceneText
		@textHeight = @view.height / 20

		btnCount = @view.controller.sceneResponses.length
		@responseBtns = Array.new(btnCount) {
			|i|
			Button.new(@view.controller.sceneResponses[i],
				Proc.new { @view.controller.sceneChose(i) },
				0.15, 0.70 + (0.26 / btnCount) * i, 0.7, (0.26 / btnCount), @textHeight)
		}

		@state = State::Narrating
	end

	def up(id)
	end

	def down(id)
		if @state == State::Narrating then
			@state = State::Choosing
		elsif @state == State::Choosing then
			@responseBtns.map { |btn| btn.trigger if btn.hovered }
		end
	end

	def update
		mx = @view.mouse_x / @view.width
		my = @view.mouse_y / @view.height

		@responseBtns.map { |btn| btn.update(mx, my) }

		@view.redraw = true
	end

	def draw
		if @state == State::Narrating && (Gosu::milliseconds - @textLastIteration) >= 50 then
			@textIterator += 1
			@textLastIteration = Gosu::milliseconds
			@textImg = Gosu::Image.from_text(@text[0..@textIterator], @textHeight)

			@state = State::Choosing if @textIterator == @text.length
		elsif @state == State::Choosing
			@textImg = Gosu::Image.from_text(@text, @textHeight)

			@responseBtns.map { |btn| btn.draw(@view.width, @view.height) }
		end

		Gosu::draw_rect(@view.width / 10 - 10, @view.height / 2 - 10,
			8 * @view.width / 10 + 20, @view.height / 6 + 20, Gosu::Color::BLUE, 1)
		@textImg.draw(@view.width / 10, @view.height / 2, 2, 1, 1, Gosu::Color::WHITE)
	end
end

