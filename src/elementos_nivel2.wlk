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
object fondoNivel2 inherits Objeto {
	override method position() = game.at(0,0)
	override method image() = "fondoNivel2.png"
	override method puedeColisionar() = true
	override method puedeMover(unSentido) = true
}
object laberinto{
	const property posiciones = [
			[game.at(3,0),game.at(7,0)],
			[game.at(1,1),game.at(3,1),game.at(5,1),game.at(7,1),game.at(9,1),game.at(11,1),game.at(13,1)],
			[game.at(3,2),game.at(5,2),game.at(9,2),game.at(10,2),game.at(11,2),game.at(13,2)],
			[game.at(0,3),game.at(1,3),game.at(3,3),game.at(5,3),game.at(6,3),game.at(7,3),game.at(13,3)],
			[game.at(3,4),game.at(5,4),game.at(7,4),game.at(8,4),game.at(9,4),game.at(10,4),game.at(11,4),game.at(12,4),game.at(13,4)],
			[game.at(1,5),game.at(2,5),game.at(3,5),game.at(5,5),game.at(11,5)],
			[game.at(3,6),game.at(7,6),game.at(9,6),game.at(11,6),game.at(13,6),game.at(14,6)],
			[game.at(0,7),game.at(2,7),game.at(3,7),game.at(5,7),game.at(6,7),game.at(7,7),game.at(9,7)],
			[game.at(0,8),game.at(5,8),game.at(6,8),game.at(9,8),game.at(11,8),game.at(12,8),game.at(13,8)],
			[game.at(2,9),game.at(3,9),game.at(5,9),game.at(8,9),game.at(9,9),game.at(11,9)],
			[game.at(1,10),game.at(2,10),game.at(4,10),game.at(5,10),game.at(6,10),game.at(7,10),game.at(8,10),game.at(11,10),game.at(13,10),game.at(14,10)],
			[game.at(4,11),game.at(8,11),game.at(9,11),game.at(10,11),game.at(11,11)],
			[game.at(0,12),game.at(1,12),game.at(2,12),game.at(4,12),game.at(6,12),game.at(11,12),game.at(13,12)],
			[game.at(0,13),game.at(1,13),game.at(2,13),game.at(6,13),game.at(7,13),game.at(8,13),game.at(9,13),game.at(13,13)]
		]
}