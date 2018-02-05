class Button

  def initialize(x, y, width, height, content)
    @x = x
    @y = y
    @width = width
    @height = height

    @content = content
    @imageText = Gosu::Image.from_text(self, @content, Gosu.default_font_name, 100)

    @image = Gosu::Image.new("Assets/button.png")
  end

  def draw
    @image.draw(@x, @y, ZOrder::Button, Float(@width) / Float(@image.width), Float(@height) / Float(@image.height))
    @imageText.draw(@x, @y, ZOrder::ButtonText, Float(@width) / Float(@image.width), Float(@height) / Float(@image.height))
  end

  def isClicked(x, y)
    x > @x && x < @x + @width && y > @y && y < @y + @height
  end
end
