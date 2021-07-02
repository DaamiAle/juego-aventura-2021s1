
import elementos.*
import wollok.game.game



class ParedLadrillo inherits Objeto{
	override method image() = "paredDeLadrillo.png"
	override method puedeColisionar() = false
}
class Pollo inherits Objeto{
	var energia
	method comer() = energia
	override method image() = "pollo.png"
	override method puedeColisionar() = true
}
class Llave inherits Objeto{
	override method image() = "llave.png"
	override method puedeColisionar() = true
}
class Modificador inherits Objeto{
	const property tipo
	override method image() = ""
	override method puedeColisionar() = true
}
object puertaDeSalidaNivel2 inherits Objeto{
	override method image() = ""
	override method puedeColisionar() = true
}
class Cofre inherits Objeto{
	override method image() = "cofre.png"
	override method puedeColisionar() = true
}
class CeldaSorpresa inherits Objeto{
	override method image() = ""
	override method puedeColisionar() = false
	
}

object fondoNivel2 inherits Objeto {
	override method position() = game.at(0,0)
	override method image() = "fondoNivel2.png"
	override method puedeColisionar() = true
	override method puedeMover(unSentido) = true
}