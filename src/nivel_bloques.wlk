import wollok.game.*
import eventos.*
import personajes.*
import elementos.*
import nivel_llaves.*

object nivelBloques {
	method iniciarNivel() {
		// Deposito
		game.addVisual(deposito)
		// En el archivo "eventos.wlk" carga la configuracion de las cajas y la plataforma del deposito.
		configNivelCajas.aplicar()
		// Le asigna la posicion al personaje y luego lo agrega a la visual
		personajeNivel1.position(game.at(1,game.width()-3))
		game.addVisual(personajeNivel1)
		
		conversacion.nivel1Inicio()
		// Teclado
		keyboard.up().onPressDo 	{ personajeNivel1.mover(arriba) 	}
		keyboard.down().onPressDo 	{ personajeNivel1.mover(abajo) 		}
		keyboard.left().onPressDo 	{ personajeNivel1.mover(izquierda) 	}
		keyboard.right().onPressDo 	{ personajeNivel1.mover(derecha) 	}

		// Final
		keyboard.t().onPressDo({ 
			if (personajeNivel1.estaEnPosicionDeSalida()){
				if (verificadorDeCajas.puedePasarDeNivel()) {
					self.terminarNivel()
				} else {
					game.say(deposito, "Deposito: Aun no puedes pasar de nivel")
					game.say(deposito, "Deposito: Faltan cajas por colocar en la plataforma.")
				}
			} else {
				game.say(personajeNivel1, "No puedo pasar de nivel desde aqui.")
				game.say(personajeNivel1, "Debo estar debajo del deposito.")
			}
		})		
	}
	
	method terminarNivel() {

		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		game.boardGround("fondoBlanco.png")
		/*
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		// game.addVisual(new Fondo(image="fondoCompleto.png"))
		personajeNivel2.position(game.at(1,game.width()-3))
		game.addVisual(personajeNivel2)
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			//game.addVisual(new Fondo(image="finNivel1.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				// y arranco el siguiente nivel
				nivelLlaves.configurate()
			})
		})*/
	}
		
}

