require 'Gosu'

require_relative 'lib/Pelota'
require_relative 'lib/Raqueta'
require_relative 'lib/Bloque'
require_relative 'lib/Texto'


class GameWindow < Gosu::Window

	def initialize
		super 800, 600, false
		self.caption = "BreakOut" #self is the Window
		@background_image = Gosu::Image.new("space.png", :tileable => true) #Imagen de fondo
		@musica = Gosu::Song.new("tetris.mp3") #Un poco de musica

		@pelota = Pelota.new(self)
		@raqueta = Raqueta.new(self)
		@bloques = []
		(1..5).each do |row|
			(1..10).each do |col|
				@bloques.push Bloque.new(self, col * 70, row * 30)
			end
		end
		@puntos = Puntuacion.new(self, 20)
		@mensaje = Mensaje.new(self, 20)
		@texto = true
	end

	def empezar_juego
		@start = true
		@texto = false
		@musica.play(true)
		@pelota.mover
		@pausa = false
		@game_over = false
		reset = false
	end

	def pausa
		@pausa = true
		@start = false
		@texto = false
		@game_over = false
		@musica.pause
	end

	def game_over
		if @pelota.fuera? or @puntos.fin?
			@game_over = true
		end
	end

	def reset
		@start = true
		@musica.play(true)
		@pelota.mover
		@pausa = false
		@game_over = false
	end



	def se_tocan?(obj1, obj2) #obj1 (pelota) and obj2 (raqueta) are rectangular and have x, y, w and h methods that are "readers" for these values.
  		obj1.x > obj2.x - obj1.w and obj1.x < obj2.x + obj2.w and obj1.y > obj2.y - obj1.h and obj1.y < obj2.y + obj2.h
	end


	def button_up(id)
		case id
		when (Gosu::KbSpace)
			self.empezar_juego
		when (Gosu::KB_ESCAPE)
			close
		when (Gosu::KbP)
			self.pausa
		when (Gosu::KbS)
			self.reset
		end

	end


	def update
		if button_down?(Gosu::KbLeft) and @start == true
			@raqueta.mover_izq
		end

		if button_down?(Gosu::KbRight) and @start == true
			@raqueta.mover_der
		end

		if @start == true #Indico que cuando se presione Start (espacio) la pelota empiece a moverse y rebote en caso de colision
			@pelota.mover
				if se_tocan?(@pelota, @raqueta)
  					@pelota.rebota
  				end
  		end

  		if @start
	  		@bloques.each do |bloque|
	  			if se_tocan?(@pelota, bloque)
	  				@pelota.rebota
	  				@bloques.delete bloque
	  				@puntos.otro_punto
	  			end
	  		end
	  	end

  		if game_over
  			@musica.pause
			@pelota.pausa
		end

	end

	def draw
		@background_image.draw(0, 0, 0)
		@pelota.draw
		@raqueta.draw


		if @start == true
			@puntos.draw
			@bloques.each do |bloque|
				bloque.draw
			end
		end

		if @texto == true
			@mensaje.draw
		end

		if @pausa == true
			@puntos.draw_pause
			@mensaje.pausa
		end

		if @game_over == true
			@mensaje.game_over
		end
	end

end

window = GameWindow.new
window.show #show is another method of window that we don't see inside Gosu
