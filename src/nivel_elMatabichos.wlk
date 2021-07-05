import wollok.game.*
import utilidades.*
import personajes.*
import elementos.*
import elementos_nivel3.*


object nivelElMatabichos {
	method iniciarNivel() {
		configuraciones.nivelElMatabichos()	
		// Teclado
		keyboard.up().onPressDo 	{ personajeNivel3.mover(arriba) 	}
		keyboard.down().onPressDo 	{ personajeNivel3.mover(abajo) 		}
		keyboard.left().onPressDo 	{ personajeNivel3.mover(izquierda) 	}
		keyboard.right().onPressDo 	{ personajeNivel3.mover(derecha) 	}	
		//
		game.onTick(500, "Movimiento de Enemigos", {
			const enemigos = game.allVisuals().copy()
			enemigos.removeAll([personajeNivel3,fondoNivel3, barraSuperior])
			enemigos.forEach({e => e.mover(aleatorios.sentido())})
		})
		//colision
		game.onCollideDo(personajeNivel3, { obj => obj.colisionarCon(personajeNivel3) })
		// Final
		keyboard.g().onPressDo({ self.terminarNivel() })
	}
	method terminarNivel() {  }
}


	
	
