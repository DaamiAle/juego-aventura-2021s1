import wollok.game.*
import eventos.*

object arriba 		{ method position(obj) = obj.position().up(1) 	}
object abajo 		{ method position(obj) = obj.position().down(1) }
object izquierda	{ method position(obj) = obj.position().left(1) }
object derecha 		{ method position(obj) = obj.position().right(1)} 

class Objeto {
	var property position
	method image()
	method puedeColisionar()
	method mover(unSentido) { }
	method puedeMover(unSentido) = false
}

class ParedLadrillo inherits Objeto{
	override method image() = "paredDeLadrillo.png"
	override method puedeColisionar() = false
}

class Caja inherits Objeto{
	override method image() = "cajaDeMadera.png"
	override method puedeColisionar() = true
	override method mover(unSentido) { if (self.puedeMover(unSentido)) { self.position(unSentido.position(self)) } else { } }
	override method puedeMover(unSentido) {
		var resultado = false
		const objetos = game.getObjectsIn(unSentido.position(self))
		if (unSentido.equals(izquierda))	{ resultado = self.position().x() > 1 }
		else if (unSentido.equals(derecha))	{ resultado = self.position().x() < game.width() - 2  }
		else if (unSentido.equals(arriba))	{ resultado = self.position().y() < game.height() - 2 }
		else 								{ resultado = self.position().y() > 1 }
		return resultado and objetos.isEmpty()
	}
}

object deposito inherits Objeto {
	override method position() = game.at(1,game.width()-2)
	override method image() = "market.png"
	override method puedeColisionar() = false
}

class Pollo inherits Objeto{
	var energia
	method comer() = energia
	override method image() = "pollo.png"
	override method puedeColisionar() = true
}
object fondoNivel1 inherits Objeto {
	override method image() = "fondoNivel1.png"
	override method puedeColisionar() = true
	override method puedeMover(unSentido) = true
}


