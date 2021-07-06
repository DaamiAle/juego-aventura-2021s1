import wollok.game.*
import utilidades.*
import personajes.personajeNivel1
import elementos.*
import nivel_llaves.*
import dialogos.*

object nivelBloques {
	method iniciarNivel() {
		// En el archivo "eventos.wlk" carga la configuracion de las cajas y la plataforma del deposito.
		configuraciones.nivelCajas()
		dialogos.nivel1Inicio()
		// Teclado
		keyboard.up().onPressDo 	{ personajeNivel1.mover(arriba) 	}
		keyboard.down().onPressDo 	{ personajeNivel1.mover(abajo) 		}
		keyboard.left().onPressDo 	{ personajeNivel1.mover(izquierda) 	}
		keyboard.right().onPressDo 	{ personajeNivel1.mover(derecha) 	}
		game.onTick( 10,"Actualizacion indicador", { actualizadores.cajasRestantes() } )
		
		// Final
		keyboard.n().onPressDo({ 
			if (verificadores.personajeNivel1EstaEnPosicionDeSalida()){
				if (verificadores.cajasListas()) { self.terminarNivel() } else { dialogos.cajasNivel1Faltantes() }
			} else { dialogos.posicionDeSalidaIncorrecta() }
		})		
	}
	
	method terminarNivel() {
		game.clear()
		finales.nivel(1)
		game.addVisual(finales)
		game.schedule(3000, { 
			game.clear() 
			nivelLlaves.iniciarNivel()
		})			
	}
		
}



