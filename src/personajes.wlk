import wollok.game.*
import utilidades.*
import elementos.*
import dialogos.*
import elementos_nivel2.modificador

class Personaje { // Clase abstracta de personaje. Para usarla de plantilla
	var property position
	method image() = "player.png"
	method mover(unSentido) { if (self.puedeMover(unSentido)) { self.position(unSentido.position(self)) } else { dialogos.personajeNoPuedeMoverse(self) } }
	method puedeMover(unSentido) = unSentido.position(self).x().between(0,14) and unSentido.position(self).y().between(0,13)
	//method puedeColisionar()
}

object personajeNivel1 inherits Personaje{
	//override method puedeColisionar() = false
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
		else { 
			super(unSentido)
		}
		
	}
}

object personajeNivel2 inherits Personaje{
	var property llavesEncontradas = 0
	var property modificadorDeComida = null
	var property energia = 40
	
	override method puedeMover(unSentido) = super(unSentido) and self.energia() > 0 and game.getObjectsIn(unSentido.position(self)).all{ obj => obj.puedeColisionar()}
	override method mover(unSentido) { 
		super(unSentido)
		self.restarEnergia(1)
		
	}
	method comer(energiaPollo) {
		if (self.modificadorDeComida() != null) {
			modificador.energiaPollo(energiaPollo) 
			self.aplicarModificador() 
		//	modificador.efectos().get(self.modificadorDeComida()).apply()
		}
		else {
			self.sumarEnergia(energiaPollo)
		}
	}
	method aplicarModificador() {
		const efectos = [{modificador.duplicador(self)} , {modificador.reforzador(self)} , {modificador.tripleONada(self)} ]
		efectos.get(self.modificadorDeComida()).apply()
	}
	method patearCofre(){
		// aca va un recorrido de direcciones y patear los objetos que estan en las celdas adyacentes ortogonales
	}
	method sumarEnergia(unValor){
		self.energia(999.min(self.energia() + unValor))
	}
	method restarEnergia(unValor){
		self.energia(0.max(self.energia() - unValor))
	}
	method colisionar(unObjeto){
		if (unObjeto.puedeColisionar()){
			unObjeto.colisionarCon(self)
		}
	}
	method aplicarCeldaSorpresa(){
		const efectos = [{self.restarEnergia(aleatorios.numeroDecena())},{self.sumarEnergia(aleatorios.numeroDecena())},{self.teletransportar()},{colocadores.pollo()}]
		
		efectos.anyOne().apply()
	}
	method teletransportar(){
		const posicionAleatoria = posiciones.asignarPosicionAleatoria()
		if (posiciones.posicionEstaVacia(posicionAleatoria)) { 
			self.position(posicionAleatoria)
		}
		else { self.teletransportar() }
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
object personajeNivel3 inherits Personaje{
	var granadas = 0
	var property ultimoSentidoDeMovimiento
	//override method puedeColisionar() = true
	override method mover(unSentido) { 
		super(unSentido)
		self.ultimoSentidoDeMovimiento(unSentido)
	}
	method lanzarGranada() {
		granadas =- 1
	}


}



