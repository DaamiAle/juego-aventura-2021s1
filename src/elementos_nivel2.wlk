import elementos.*
import utilidades.colocadores
import wollok.game.game

class ObjetoNivel2 inherits Objeto{
	method colisionarCon(unObjeto){ game.removeVisual(self) }
	method puedeColisionar() = true
	override method puedeMover(unSentido) = true
	method esIndicador() = false
}
class ParedLadrillo inherits ObjetoNivel2{
	override method image() = "paredDeLadrillo.png"
	override method puedeColisionar() = false
	
}
class Pollo inherits ObjetoNivel2{
	const property energia
	override method image() = "pollo.png"
	override method colisionarCon(unObjeto){
		super(unObjeto)
		unObjeto.comer(self.energia())
		colocadores.pollo()
	}
}
object llaveNivel2 inherits ObjetoNivel2{
	override method image() = "llaveNivel2.png"
	override method colisionarCon(unObjeto){
		super(unObjeto)
		unObjeto.llavesEncontradas(unObjeto.llavesEncontradas() + 1)
		if (aleatorios.numeroUnidad().even()) { colocadores.objetoNivel(cofreNivel2) } 
		else { colocadores.objetoNivel(self) }		
	}
}
object modificador inherits ObjetoNivel2{
	var property energiaPollo = 0
	override method image() = "modificador.png"
	override method colisionarCon(unObjeto){
		game.removeVisual(self)
		unObjeto.modificadorDeComida(aleatorios.numeroUnidad() % 3)
		colocadores.objetoNivel(self)	
	}
	method duplicador(personaje) {
		personaje.sumarEnergia(self.energiaPollo() * 2)
	}
	method reforzador(personaje) {
		if (personaje.energia() < 10) {personaje.sumarEnergia(20)}
		self.duplicador(personaje)   
	}
	method tripleONada(personaje) {
		if(personaje.energia().even()) {
			personaje.sumarEnergia(self.energiaPollo() *3)
		}
	}
}
object puertaDeSalidaNivel2 inherits ObjetoNivel2{
	override method image() = "puertaSalida.png"
	override method position() = game.at(14,13)
	override method colisionarCon(unObjeto){ /*resuelto por linea 19 de nivel_llaves.wlk*/ }
}
object cofreNivel2 inherits ObjetoNivel2{
	override method image() = "cofre.png"
	override method puedeColisionar() = false
	method romperse(){
		game.removeVisual(self)
		llaveNivel2.position(self.position())
		game.addVisual(llaveNivel2)
	}
}
class ActuadorCeldaSorpresa inherits ObjetoNivel2{
	override method image() = "plataformaPiedra.png"
	override method colisionarCon(unObjeto){
		super(self)
		unObjeto.aplicarCeldaSorpresa()
	}
}
object fondoNivel2 inherits ObjetoNivel2 {
	override method position() = game.origin()
	override method image() = "fondoNivel2.png"
	override method colisionarCon(unObjeto){ }
	
}
class IndicadorCeldaSorpresa inherits ParedLadrillo {
	var image = "celdaSorpresa.png"
	override method image() = image
	method image(unaImagen) { image = unaImagen}
	override method esIndicador() = true
}
object laberinto{
	const property positions = [
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