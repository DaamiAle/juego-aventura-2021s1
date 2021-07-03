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
	override method image() = "puertaSalida.png"
	override method puedeColisionar() = true
}
class Cofre inherits Objeto{
	override method image() = "cofre.png"
	override method puedeColisionar() = false
}
class CeldaSorpresa inherits ParedLadrillo{
	override method image() = ""
}
class Sendero {
	const property position
	method image() = "movimiento.png"
}
class BarraSuperior inherits Sendero{ override method image() = "barraSuperior.png" }

class IndicadorEnergia inherits Sendero{ override method image() = "rayitoEnergia.png"}

class Salida inherits Sendero { override method image() = "puertaSalida.png" }

object fondoNivel2 inherits Objeto {
	override method position() = game.at(0,0)
	override method image() = "fondoNivel2.png"
	override method puedeColisionar() = true
	override method puedeMover(unSentido) = true
}