import wollok.game.*

// en la implementación real, conviene tener un personaje por nivel
// los personajes probablemente tengan un comportamiendo más complejo que solamente
// imagen y posición

object personajeSimple {
	var property position = game.at(10,8)
	const property image = "player.png"	
	
	method moverIzquierda() { self.position(self.position().left(1)) }
	method moverDerecha() { self.position(self.position().right(1)) }
	method moverArriba() { self.position(self.position().up(1)) }
	method moverAbajo() { self.position(self.position().down(1)) }
}

object personajeNivel2 {
	var property position = game.at(10,8)
	const property image = "player.png"
	var energia = 40
	
	method moverIzquierda() { 
		self.position(self.position().left(1))
		energia - 1
	}
	method moverDerecha() { 
		self.position(self.position().right(1))
		energia - 1
	}
	method moverArriba() { 
		self.position(self.position().up(1))
		energia - 1
	}
	method moverAbajo() { 
		self.position(self.position().down(1))
		//aca irian los pollos
	}
}
