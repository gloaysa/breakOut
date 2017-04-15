class Pelota #Aqui defino la Pelota, y sus metodos de inicio, movimiento, etc.
	attr_reader :x, :y, :w, :h

	def initialize(window)
		@x = window.width / 2 - 10
		@y = 555
		@w = 20
		@h = 20
		@vx = 5
		@vy = -5
		@imagen = Gosu::Image.new(window, "ball.png", false)

	end


	def mover
		@x = @x + @vx
		@y = @y + @vy

		if @x < 0 #Hace que la pelota rebote cuando toca pared izquierda con el doble de velocidad
			@vx = 10
		end
		if @x > 780 #Hace que la pelota rebote cuando toca pared derecha con el doble de velocidad
			@vx = -10
		end
		if @y < 0 #Hace que la pelota rebote cuando toca techo
		 	@vy = 5
		end
		if @y > 600
			pausa
		end
	end

	def fuera?
		if @y > 600
			return true
		end
	end


	def rebota #Hace que la pelota rebote cuando toca Raqueta o Brick (ver método are_touching? en GameWindow)
		@vy = -1 * @vy
		@vx = 5
	end

	def pausa
		@vx = 0
		@vy = 0
	end


	def draw
		@imagen.draw(@x, @y, 1)
	end

end