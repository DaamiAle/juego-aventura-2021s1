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
		keyboard.g().onPressDo		{ personajeNivel3.lanzarGranada()	}
		// Actualizaciones constantes
		game.onTick(500, "Movimiento de Enemigos", {
			const enemigos = game.allVisuals().copy()
			enemigos.remove(personajeNivel3)
			enemigos.forEach({e => e.mover(aleatorios.sentido())})
		})
		game.onTick(10, "Actualizacion Indicadores",{
			actualizadores.saludRestante()
			actualizadores.granadas()
			actualizadores.enemigosRestantes()
		})
		// Colisiones
		game.onCollideDo(personajeNivel3, { obj => obj.colisionarCon(personajeNivel3) })
		// Final
		game.schedule(1000,{
			game.onTick(10, "Resultado del Nivel", {
				if (personajeNivel3.salud().equals(0)){ self.perderNivel() }
				if (personajeNivel3.enemigosRestantes().equals(0)){ self.ganarNivel() }
			})	
		})
	}
	method ganarNivel() {
		game.clear()
		finalNivel2.resultado("victoria")
		game.addVisual(finalNivel2)
		self.terminarJuego()
	}
	
	method perderNivel() {
		game.clear()
		finalNivel2.resultado("gameOver")
		game.addVisual(finalNivel2)
		game.schedule(3000, { game.clear() self.iniciarNivel() }) 
	}
	method terminarJuego() { 
		game.schedule(3000, { 
			game.clear()
			finales.nivel(3)
			game.addVisual(finales)
			game.schedule(3000, {
				game.stop()
			})
		})
	}
}


	
	
