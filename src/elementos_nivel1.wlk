import wollok.game.*
import elementos.*

class Caja inherits Objeto{
	override method image() = "cajaDeMadera.png"
	override method puedeColisionar() = true
	override method mover(unSentido) { if (self.puedeMover(unSentido)) { self.position(unSentido.position(self)) } }
	override method puedeMover(unSentido) {
		const objetos = game.getObjectsIn(unSentido.position(self))
		return unSentido.position(self).x().between(0,14) and unSentido.position(self).y().between(0,12) and objetos.isEmpty()
	}
}

object deposito inherits Objeto{
	override method position() = game.at(1,game.width()-2)
	override method image() = "market.png"
	override method puedeColisionar() = false
}

object fondoNivel1 inherits Objeto {
	override method position() = game.at(0,-1)
	override method image() = "fondoNivel1.png"
	override method puedeColisionar() = true
	override method puedeMover(unSentido) = true
}
