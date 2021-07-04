import wollok.game.*
import utilidades.*
import personajes.personajeNivel2
import elementos.*
import elementos_nivel2.puertaDeSalidaNivel2


object nivelLlaves {
	method iniciarNivel() {
		configuraciones.nivelLlaves()	
		// Teclado
		keyboard.up().onPressDo 	{ personajeNivel2.mover(arriba) 	}
		keyboard.down().onPressDo 	{ personajeNivel2.mover(abajo) 		}
		keyboard.left().onPressDo 	{ personajeNivel2.mover(izquierda) 	}
		keyboard.right().onPressDo 	{ personajeNivel2.mover(derecha) 	}
		// colisiones, acá sí hacen falta
		game.onTick( 10,"Actualizacion indicador", { 
			actualizadores.energiaRestante() 
			actualizadores.llavesRestantes() 
			actualizadores.llavesListas() 
			actualizadores.personajeCruzoPuertaEn(self)
		} )
		game.onCollideDo(personajeNivel2, { objeto => personajeNivel2.colisionar(objeto) })
		//agregar contador de llaves
	}
	
	method terminarNivel() {
		// es muy parecido al terminar() de nivelBloques
		// el perder() también va a ser parecido
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		game.addVisual(finalNivel2)
		game.schedule(2500, { game.clear() game.schedule(3000, { game.stop() }) })
	}
	
	
}
