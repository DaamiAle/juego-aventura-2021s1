import wollok.game.*
import eventos.*
import personajes.*
import elementos.*
import nivel_elMataBichos.*

object nivelLlaves {

	method iniciarNivel() {
		configuraciones.nivelLlaves()	
		// Teclado
		keyboard.up().onPressDo 	{ personajeNivel2.mover(arriba) 	}
		keyboard.down().onPressDo 	{ personajeNivel2.mover(abajo) 		}
		keyboard.left().onPressDo 	{ personajeNivel2.mover(izquierda) 	}
		keyboard.right().onPressDo 	{ personajeNivel2.mover(derecha) 	}
		// colisiones, acá sí hacen falta
		
		// este es para probar, no es necesario dejarlo
		keyboard.g().onPressDo({ self.terminarNivel() })
		
	}
	
	method terminarNivel() {
		// es muy parecido al terminar() de nivelBloques
		// el perder() también va a ser parecido
		
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		//game.addVisual(new Fondo(image="fondoCompleto.png"))
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			//game.addVisual(new Fondo(image="ganamos.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// fin del juego
				game.stop()
			})
		})
	}
	
	
}
