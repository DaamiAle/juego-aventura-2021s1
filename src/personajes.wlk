import wollok.game.*
import utilidades.*
import elementos.*
import dialogos.*

class Personaje { // Clase abstracta de personaje. Para usarla de plantilla
	var property position
	method image() = "player.png"
	method mover(unSentido) { if (self.puedeMover(unSentido)) { self.position(unSentido.position(self)) } else { dialogos.personajeNoPuedeMoverse() } }
	method puedeMover(unSentido) {
		var resultado = false
		if (unSentido.equals(izquierda))	{ resultado = self.position().x() > 0 }
		else if (unSentido.equals(derecha))	{ resultado = self.position().x() < game.width() - 1  }
		else if (unSentido.equals(arriba))	{ resultado = self.position().y() < game.height() - 1 }
		else 								{ resultado = self.position().y() > 0 }
		return resultado
	}
	method puedeColisionar()
}

object personajeNivel1 inherits Personaje{ 
	override method puedeColisionar() = false
	override method puedeMover(unSentido) {
		const objetos = game.getObjectsIn(unSentido.position(self))
		return super(unSentido) and objetos.all{ obj => obj.puedeMover(unSentido)}
	} 
	override method mover(unSentido) {
		const objetos = game.getObjectsIn(unSentido.position(self))
		if (not objetos.isEmpty()) { 
			objetos.forEach{ obj => obj.mover(unSentido) }
			super(unSentido)
		}
		else { super(unSentido) }
	}
}

object personajeNivel2 inherits Personaje{
	var energia = 40
	override method puedeColisionar() = true
	override method mover(unSentido) { 
		super(unSentido)
		energia =- 1
	}
	method actualizarIndicadorEnergia(){
		const unidad = energia % 10
		const decena = energia.div(10) % 10
		const centena = energia.div(100)
		indicadorUnidad.valor(unidad)
		indicadorDecena.valor(decena)
		indicadorCentena.valor(centena)
	}
	
	method comer() {
		//aca irian los pollos
	}
	method patearCofre(){
		// aca va un recorrido de direcciones y patear los objetos que estan en las celdas adyacentes ortogonales
	}
	method colisionar(unObjeto){
		if (unObjeto.puedeColisionar()){
			unObjeto.colisionarCon(self)
		}
	}
}
object personajeNivel3 inherits Personaje{
	var granadas = 0
	var property ultimoSentidoDeMovimiento
	override method puedeColisionar() = true
	override method mover(unSentido) { 
		super(unSentido)
		self.ultimoSentidoDeMovimiento(unSentido)
	}
	method lanzarGranada() {
		
		granadas =- 1
	}

}



