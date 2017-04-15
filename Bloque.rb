class Bloque
	attr_reader :x, :y, :w, :h

	def initialize(window, x, y)
		@x = x
		@y = y
		@w = 60
		@h = 20
		@imagen = Gosu::Image.new(window, "brick.png", false)
	end

	def draw
		@imagen.draw(@x, @y, 1)

	end
end
