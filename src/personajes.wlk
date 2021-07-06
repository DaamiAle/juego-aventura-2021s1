import wollok.game.*
import utilidades.*
import elementos.*
import dialogos.*
import elementos_nivel2.modificador
import elementos_nivel2.cofreNivel2

class Personaje { // Clase abstracta de personaje. Para usarla de plantilla
	var property position = game.origin()
	method image() = "player.png"
	method mover(unSentido) { if (self.puedeMover(unSentido)) { self.position(unSentido.position(self)) } }
	method puedeMover(unSentido) = unSentido.position(self).x().between(0,14) and unSentido.position(self).y().between(0,13)
}

object personajeNivel1 inherits Personaje{
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
	var property llavesEncontradas = 0
	var property modificadorDeComida = null
	var property energia = 40
	
	override method puedeMover(unSentido) = super(unSentido) and self.energia() > 0 and game.getObjectsIn(unSentido.position(self)).all{ obj => obj.puedeColisionar()}
	override method mover(unSentido) { 
		if (self.puedeMover(unSentido)){ self.restarEnergia(1) }
		super(unSentido)
	}
	method comer(energiaPollo) {
		if (self.modificadorDeComida() != null) {
			modificador.energiaPollo(energiaPollo) 
			self.aplicarModificador() 
		}
		else {
			self.sumarEnergia(energiaPollo)
		}
	}
	method aplicarModificador() {
		const efectos = [{modificador.duplicador(self)} , {modificador.reforzador(self)} , {modificador.tripleONada(self)} ]
		efectos.get(self.modificadorDeComida()).apply()
	}
	method patear(){
		self.restarEnergia(6)
		[arriba, abajo, izquierda, derecha].forEach({ unSentido => self.abrirCofre(unSentido) })
	}
	method abrirCofre(unSentido) {
		const objetos = game.getObjectsIn(unSentido.position(self))
		if (objetos.contains(cofreNivel2)) {
			cofreNivel2.romperse()
		}
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
	const property granadas = []
	var property ultimoSentidoDeMovimiento = null
	var property salud = 100
	var property enemigosRestantes = 0
	
	override method mover(unSentido) { 
		super(unSentido)
		self.ultimoSentidoDeMovimiento(unSentido)
	}
	method cantidadGranadas() = self.granadas().size()
	method restarSalud(unValor){
		self.salud(0.max(self.salud() - unValor))
	}
	method sumarSalud(unValor){
		self.salud(100.min(self.salud() + unValor))
	}
	method levantarGranada(unaGranada){
		self.granadas().add(unaGranada)
	}
	method lanzarGranada(){
		if (self.cantidadGranadas() > 0) {
			const granadaASacar = self.granadas().anyOne()
			self.granadas().remove(granadaASacar)
			granadaASacar.serLanzadaPor(self)
		}
	}
	method serDestruidoPor(unaGranada){
		if (unaGranada.granadaActiva()){
			unaGranada.explotar()
			self.restarSalud((self.salud()*0.5).truncate(0))
			self.position(game.origin())
		}
	}
	method derrotarEnemigo(){
		self.enemigosRestantes(self.enemigosRestantes() - 1)
	}
}

class Enemigo inherits Personaje {
	const property posicionOrigen = posiciones.posicionEnemigo()
	override method image() = "enemigo.png"
	method colisionarCon(personaje) { personaje.restarSalud(20) personaje.position(game.origin()) }
	method serDestruidoPor(unaGranada){
		if (unaGranada.granadaActiva()){
			unaGranada.explotar()
			game.removeVisual(self)
			personajeNivel3.derrotarEnemigo()
		}
	}
}



