import wollok.game.*
import elementos.*

object granadas inherits Objeto {
	override method image() = ""
	override method puedeColisionar() = true
	
}
object botiquin inherits Objeto {
	override method image() = ""
	override method puedeColisionar() = true
	
}
object fondoNivel3 inherits Objeto {
	override method image() = "fondoNivel1.png"
	override method puedeColisionar() = true
	override method position() = game.origin()
	method colisionarCon(personaje) {}
	
}
