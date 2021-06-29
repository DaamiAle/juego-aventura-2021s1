import wollok.game.*
import eventos.*
import elementos.*

// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición

class Personaje {
	var property position
	const property image = "player.png"
	method mover(unSentido) { if (self.puedeMover(unSentido)) { self.position(unSentido.position(self)) } else { game.say(self,"Personaje: No puedo moverme en esa direccion") } }
	method puedeMover(unSentido) {
		var resultado = false
		if (unSentido.equals(izquierda))	{ resultado = self.position().x() > 0 }
		else if (unSentido.equals(derecha))	{ resultado = self.position().x() < game.width() - 1  }
		else if (unSentido.equals(arriba))	{ resultado = self.position().y() < game.height() - 1 }
		else 								{ resultado = self.position().y() > 0 }
		return resultado
	}
}

object personajeNivel1 inherits Personaje{ 
	override method puedeMover(unSentido) {
		const objetos = game.getObjectsIn(unSentido.position(self))
		return super(unSentido) and objetos.all{ obj => obj.puedeMover(unSentido)}
	} 
	// Movimientos
	override method mover(unSentido) {
		const objetos = game.getObjectsIn(unSentido.position(self))
		if (not objetos.isEmpty()) { 
			objetos.forEach{ obj => obj.mover(unSentido) }
			super(unSentido)
		}
		else { super(unSentido) }
	}
	method estaEnPosicionDeSalida() = self.position() == deposito.position().down(1)
}

object personajeNivel2 inherits Personaje{
	var energia = 40
	override method mover(unSentido) { 
		super(unSentido)
		energia =- 1
	}
	
	method comer() {
		//aca irian los pollos
	}
}
