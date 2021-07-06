import wollok.game.*
import elementos.*
import utilidades.colocadores

class ObjetoNivel3 inherits Objeto{
	method puedeColisionar() = true
	method colisionarCon(personaje){ game.removeVisual(self) }
}
class Granada inherits ObjetoNivel3 {
	var property granadaActiva = false
	override method image() = "granada.png"
	method explotar(){
		game.removeVisual(self) 
		explosion.position(self.position())
		game.addVisual(explosion)
		game.schedule(300,{
			game.removeVisual(explosion)
		})
	}
	override method puedeMover(unSentido) = unSentido.position(self).x().between(0,14) and unSentido.position(self).y().between(0,13)
	method desplazar(unSentido){
		if (self.puedeMover(unSentido)){
			game.onCollideDo(self,{ obj => obj.serDestruidoPor(self) })
			self.position(unSentido.position(self))
		}
	}
	method serLanzadaPor(personaje){
		self.granadaActiva(true)
		const sentidoDeMovimiento = personaje.ultimoSentidoDeMovimiento()
		self.position(sentidoDeMovimiento.position(personaje))
		game.addVisual(self)
		game.schedule(400,{ if (game.hasVisual(self)){ self.desplazar(sentidoDeMovimiento) } })
		game.schedule(800,{ if (game.hasVisual(self)){ self.desplazar(sentidoDeMovimiento) } })
		game.schedule(2000,{
			if (game.hasVisual(self)){
				self.explotar()
			}
		})
	}
	method serDestruidoPor(unaGranada){
		game.removeVisual(self)
		unaGranada.explotar()
		colocadores.granada()
	}
	override method colisionarCon(personaje){
		if (not self.granadaActiva()){
			game.removeVisual(self)
			personaje.levantarGranada(self)
			colocadores.granada()
		}
	}
}

object botiquin inherits ObjetoNivel3 {
	method saludAportada() = 30.min(aleatorios.numeroDecena())
	override method image() = "botiquin.png"
	override method colisionarCon(personaje){
		super(personaje)
		personaje.sumarSalud(self.saludAportada())
		colocadores.objetoNivel(self)
	}
	method serDestruidoPor(unaGranada){
		game.removeVisual(self)
		unaGranada.explotar()
		colocadores.objetoNivel(self)
	}
}
object indicadorEnemigos inherits Objeto{
	override method position() = game.at(4,14)
	override method image() = "indicadorEnemigos.png"
}
object explosion inherits ObjetoNivel3{
	override method image() = "explosion.png"
	override method colisionarCon(personaje){
		personaje.restarSalud((personaje.salud()*0.5).truncate(0))
		personaje.position(game.origin())
	}
}
object fondoNivel3 inherits ObjetoNivel3 {
	override method image() = "fondoNivel1.png"
	override method position() = game.origin()
	override method colisionarCon(unPersonaje){}
	method serDestruidoPor(unaGranada){}
}
