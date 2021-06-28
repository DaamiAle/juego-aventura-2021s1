import wollok.game.*
import orientaciones.*
import utilidades.*

class Bloque {
	var property position
	const property image = "market.png" 	
	
	// agregar comportamiento	
}

class Caja {
	var property position = utilidadesParaJuego.posicionArbitraria()
	const property image = "caja.png"
	
		method puedeColisionar() = false 
	
	method puedeMover() = true
	
	method mover(unaOrientacion) {
		if(self.puedoMoverAl(unaOrientacion)) {
			self.position(unaOrientacion.posicion(self))
		} else {}
	}
	
	method puedoMoverAl( unaOrientacion ) {
		return game.getObjectsIn( unaOrientacion.posicion(self) ).all { unObj => unObj.puedeColisionar()}
	}
}

class Deposito {
	var property position = []
}
class Pollo {
	var property position
	var energia 
	
	method comer() = energia
}
