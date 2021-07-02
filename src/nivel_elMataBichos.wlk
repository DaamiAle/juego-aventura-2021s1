import wollok.game.*
import utilidades.*
import personajes.*
import elementos.*
import nivel_final.*

object nivelElMataBichos {
	method iniciarNivel() {
		configuraciones.nivelElMatabichos()	
		// Teclado
		keyboard.up().onPressDo 	{ personajeNivel3.mover(arriba) 	}
		keyboard.down().onPressDo 	{ personajeNivel3.mover(abajo) 		}
		keyboard.left().onPressDo 	{ personajeNivel3.mover(izquierda) 	}
		keyboard.right().onPressDo 	{ personajeNivel3.mover(derecha) 	}	
		// Final
		keyboard.g().onPressDo({ self.terminarNivel() })
	}
	method terminarNivel() {  }
}
	
	
