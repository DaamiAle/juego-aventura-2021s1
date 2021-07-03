import wollok.game.*
import utilidades.configuraciones
import utilidades.verificadores
import personajes.personajeNivel1
import elementos.*
import nivel_llaves.*
import dialogos.*

object nivelBloques {
	method iniciarNivel() {
		
		// En el archivo "eventos.wlk" carga la configuracion de las cajas y la plataforma del deposito.
		configuraciones.nivelCajas()
		dialogos.nivel1Inicio()
		// Personaje
		personajeNivel1.position(game.at(1,game.width()-3))
		game.addVisual(personajeNivel1)
		// Teclado
		keyboard.up().onPressDo 	{ personajeNivel1.mover(arriba) 	}
		keyboard.down().onPressDo 	{ personajeNivel1.mover(abajo) 		}
		keyboard.left().onPressDo 	{ personajeNivel1.mover(izquierda) 	}
		keyboard.right().onPressDo 	{ personajeNivel1.mover(derecha) 	}
		// Final
		keyboard.t().onPressDo({ 
			if (verificadores.personajeNivel1EstaEnPosicionDeSalida()){
				if (verificadores.cajasListas()) { self.terminarNivel() } else { dialogos.cajasNivel1Faltantes() }
			} else { dialogos.posicionDeSalidaIncorrecta() }
		})		
	}
	
	method terminarNivel() {
		game.clear()
		// Aca va la Transicion de nivel
		
		// Pasamos al siguiente nivel
//		game.schedule(3000, {game.clear()})
		nivelLlaves.iniciarNivel()
	}
		
}

