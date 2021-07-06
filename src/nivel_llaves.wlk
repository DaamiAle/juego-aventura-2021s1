import wollok.game.*
import utilidades.configuraciones
import utilidades.actualizadores
import personajes.personajeNivel2
import elementos.*
import nivel_elMatabichos.*


object nivelLlaves {
	method iniciarNivel() {
		configuraciones.nivelLlaves()	
		// Teclado
		keyboard.up().onPressDo 	{ personajeNivel2.mover(arriba) 	}
		keyboard.down().onPressDo 	{ personajeNivel2.mover(abajo) 		}
		keyboard.left().onPressDo 	{ personajeNivel2.mover(izquierda) 	}
		keyboard.right().onPressDo 	{ personajeNivel2.mover(derecha) 	}
		keyboard.p().onPressDo 		{ personajeNivel2.patear() 			}
		// Verificaciones constantes
		game.onTick( 10,"Actualizacion indicador", { 
			actualizadores.energiaRestante() 
			actualizadores.llavesRestantes() 
			actualizadores.llavesListas() 
			actualizadores.personajeCruzoPuertaEn(self)
			actualizadores.energiaDePersonajeEn(self)
		} )
		// Colisiones
		game.onCollideDo(personajeNivel2, { objeto => personajeNivel2.colisionar(objeto) })
	}
	
	method ganarNivel() {
		game.clear()
		finalNivel2.resultado("victoria")
		game.addVisual(finalNivel2)
		game.schedule(3000, { 
			game.clear()
			finales.nivel(2)
			game.addVisual(finales)
			game.schedule(300, {
				game.clear()
				nivelElMatabichos.iniciarNivel()
			})
		})
	}
	
	method perderNivel() {
		game.clear()
		finalNivel2.resultado("gameOver")
		game.addVisual(finalNivel2)
		game.schedule(3000, { 
			game.clear()
			self.iniciarNivel()
		}) 
	}
}
