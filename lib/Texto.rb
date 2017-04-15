class Puntuacion
	def initialize(window, xpos)
		@x = xpos
		@y = 20
		@puntos = 0
		@font = Gosu::Font.new(window, 'System', 30)
		@en_pausa = Gosu::Font.new(window, 'System', 90)
	end

	def otro_punto
		@puntos = @puntos + 1
	end

	def draw
		@font.draw("#{@puntos}", @x, @y, 1)
	end

	def draw_pause
		@en_pausa.draw("SCORE: #{@puntos}", 210, 20, 1)
	end

	def fin?
		if @puntos == 50
			return true
		end
	end
end

class Mensaje
	def initialize(window, xpos)
		@x = 55
		@y = 300
		@font = Gosu::Font.new(window, 'System', 80)
		@font2 = Gosu::Font.new(window, 'System', 30)
		@draw_text = Gosu::Font.new(window, 'System', 25)
	end

	def pausa
		@font.draw("PAUSED", 250, 250, 1)
	    @draw_text.draw("ESC - Quit", 125, 350, 1)
	    @draw_text.draw("SPACE - Resume game", 125, 400, 1) 
	end

	def game_over
		@font.draw("GAME OVER", 180, @y, 1)
	end

	def draw
		@font.draw("Press SPACE to start!", @x, @y, 1)
		@font2.draw("Left & Right to move, ESC to exit", 200, @y + 100, 1)

	end
end