import wollok.game.*
import orientaciones.*

// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición

object personajeSimple {
	var property position = game.at(10,8)
	const property image = "player.png"	
	
	//MOVIMIENTO
	
	method mover(unaOrientacion) {
		if(self.puedoMoverAl(unaOrientacion)) {
			self.position(unaOrientacion.posicion(self))
		} else if (self.puedoEmpujarAl(unaOrientacion)) {
			self.empujar(unaOrientacion)
			self.position(unaOrientacion.posicion(self))
		}
		else {}
	}
	
	method empujar(unaOrientacion) {
		game.getObjectsIn(unaOrientacion.posicion(self)).forEach { caja => caja.mover(unaOrientacion)}
	}
	
	method puedoMoverAl( unaOrientacion ) {
		return game.getObjectsIn( unaOrientacion.posicion(self) ).all { unObj => unObj.puedeColisionar()}
	}
		
	method puedoEmpujarAl(unaOrientacion){
		return game.getObjectsIn( unaOrientacion.posicion(self) ).all { unObj => unObj.puedeMover()}
	}
}

object personajeNivel2 {
	var property position = game.at(10,8)
	const property image = "player.png"
	var energia = 40
	
	method moverIzquierda() { 
		self.position(self.position().left(1))
		energia =- 1
	}
	method moverDerecha() { 
		self.position(self.position().right(1))
		energia =- 1
	}
	method moverArriba() { 
		self.position(self.position().up(1))
		energia =- 1
	}
	method moverAbajo() { 
		self.position(self.position().down(1))
		energia =- 1
	}
	method comer() {
		//aca irian los pollos
	}
}
