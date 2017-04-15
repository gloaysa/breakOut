class Raqueta
	attr_reader :x, :y, :w, :h

	def initialize(window)
		@x = window.width / 2 -40
		@y = 580
		@w = 80
		@h = 15
		@imagen = Gosu::Image.new(window, "paddle.png", false)
	end

	def draw
		@imagen.draw(@x, @y, 1)
	end

	def mover_izq
		if @x > 0
			@x = @x - 7
		end
	end

	def mover_der
		if @x < 720
			@x = @x + 7
		end
	end

end