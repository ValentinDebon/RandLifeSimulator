
require_relative 'Button'

class SceneView
	module Color
		TextBackground = Gosu::Color.new(224, 0, 0, 0)
	end

	module State
		Narrating = 0
		Choosing = 1
		Responding = 2
		Waiting = 3
	end

	def initialize(view)
		@view = view

		@backgroundImg = Gosu::Image.new(@view.controller.currentScene.bg)

		@sceneCharacter = @view.controller.sceneCharacter
		if @sceneCharacter != nil then
			@sceneBodyImg = Gosu::Image.new("View/Assets/Characters/" + @sceneCharacter.character + ".png")
			@sceneHeadImg = Gosu::Image.new("View/Assets/Identities/" + @sceneCharacter.identity + ".png")
		end

		@textImg = Gosu::Image.from_text("", 50)
		@textIterator = 0
		@textLastIteration = 0
		@text = @view.controller.sceneText
		@textHeight = @view.height / 20

		btnTexts = @view.controller.responsesText
		btnCount = btnTexts.length
		@responseBtns = Array.new(btnCount) {
			|i|
			Button.new(btnTexts[i],
				Proc.new {
					@view.controller.currentScene.respond(i)
					@textIterator = 0
					@text = @view.controller.response
					@state = State::Responding
				},
				0.15, 0.70 + (0.26 / btnCount) * i, 0.7, (0.26 / btnCount), @textHeight)
		}

		@state = State::Narrating
	end

	def up(id)
	end

	def down(id)
		if @state == State::Narrating then
			@state = State::Choosing
			@view.redraw = true
		elsif @state == State::Choosing then
			if id == Gosu::MS_LEFT then
				@responseBtns.each { |btn| btn.trigger if btn.hovered }
			end
		elsif @state == State::Responding then
			@state = State::Waiting
			@view.redraw = true
		elsif @state == State::Waiting then
			@view.controller.nextScene
		end
	end

	def update
		mx = @view.mouse_x / @view.width
		my = @view.mouse_y / @view.height

		@responseBtns.each { |btn| btn.update(mx, my) }

		if (@state == State::Narrating || @state == State::Responding &&
				(Gosu::milliseconds - @textLastIteration) >= 30) ||
			(@state == State::Choosing && my >= 0.5) then
			@view.redraw = true
		end
	end

	def draw
		@backgroundImg.draw(0, 0, Depth::BACKGROUND, Float(@view.width)/Float(@backgroundImg.width),
			Float(@view.height)/Float(@backgroundImg.height))

		if (@state == State::Narrating || @state == State::Responding) && (Gosu::milliseconds - @textLastIteration) >= 30 then
			@textIterator += 1
			@textLastIteration = Gosu::milliseconds
			@textImg = Gosu::Image.from_text(@text[0..@textIterator], @textHeight)

			if @textIterator == @text.length then
				@state = State::Choosing if @state == State::Narrating
				@state = State::Waiting if @state == State::Responding
			end
		elsif @state == State::Choosing || @state == State::Waiting
			@textImg = Gosu::Image.from_text(@text, @textHeight)

			@responseBtns.map { |btn| btn.draw(@view.width, @view.height) } if @state == State::Choosing
		end

		if @sceneCharacter != nil then
			posx = @view.width / 2
			posy = @view.height / 10

			if @state == State::Narrating || @state == State::Responding then
				posy += Math.sin(Gosu::milliseconds / 100) * Float(@view.height / 60.0)
			end
			scale = (Float(@view.width) / Float(@sceneBodyImg.width)) / 2.0
			@sceneBodyImg.draw(posx, posy, Depth::BODY, scale, scale)
			@sceneHeadImg.draw(posx, posy, Depth::HEAD, scale, scale)
		end

		Gosu::draw_rect(@view.width / 10 - 10, @view.height / 2 - 10,
			8 * @view.width / 10 + 20, @view.height / 6 + 20, Color::TextBackground, Depth::RECTANGLE)
		@textImg.draw(@view.width / 10, @view.height / 2, Depth::TEXT, 1, 1, Gosu::Color::WHITE)
	end
end

