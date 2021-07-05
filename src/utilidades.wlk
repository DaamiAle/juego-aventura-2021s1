import wollok.game.*
import elementos.*
import personajes.*
import elementos_nivel1.*
import elementos_nivel2.*

object aleatorios{
	method numeroCentena() 	= 1.randomUpTo(9).truncate(0) * 100
	method numeroDecena() 	= 1.randomUpTo(9).truncate(0) * 10
	method numeroUnidad() 	= 1.randomUpTo(9).truncate(0)
}

object configuraciones{
	method nivelCajas(){
		// Fondo
		game.addVisual(barraSuperior)
		game.addVisual(fondoNivel1)
		game.addVisual(indicadorPrimario)
		// Cajas:
		8.times({ i => colocadores.caja() })
		indicadorCentena.valor(8)
		game.addVisual(indicadorCentena)
		// Deposito
		game.addVisual(deposito)
		// Personaje
		personajeNivel1.position(game.at(1,game.width()-3))
		game.addVisual(personajeNivel1)
	}
	
	method nivelLlaves(){
		// Fondo
		game.addVisual(fondoNivel2)
		game.addVisual(barraSuperior)
		indicadorPrimario.nivel(2)
		game.addVisual(indicadorPrimario)
		game.addVisual(indicadorCentena)
		game.addVisual(indicadorDecena)
		game.addVisual(indicadorUnidad)
		// Muros
		colocadores.laberintoLadrillo()
		//celdas sorpesa
		[game.at(3,11),game.at(4,8),game.at(6,5),game.at(10,0)].forEach({ pos => game.addVisual(new ActuadorCeldaSorpresa(position=pos))})  
		[game.at(3,10),game.at(4,9),game.at(6,4),game.at(10,1)].forEach({ pos => game.addVisual(new IndicadorCeldaSorpresa(position=pos))})
		// Llaves 
		colocadores.objetoNivel2(llaveNivel2)
		// Pollo 
		colocadores.pollo()
		// Modificador
		colocadores.objetoNivel2(modificador)
		// Personaje
		personajeNivel2.position(game.origin())
		game.addVisual(personajeNivel2)		
	}
	method nivelElMatabichos(){
		
	}
}
object posiciones {
	method posicionAleatoriaCajas() 	= game.at( 1.randomUpTo(game.width()-2).truncate(0), 1.randomUpTo(game.height()-5).truncate(0) )
	method asignarPosicionAleatoria() 	= game.at( 0.randomUpTo(game.width()-1).truncate(0), 0.randomUpTo(game.height()-1).truncate(0) ) 
	method posicionEstaVacia(unaPosicion) = game.getObjectsIn(unaPosicion).isEmpty()
}


object verificadores{
	method personajeNivel1EstaEnPosicionDeSalida() = personajeNivel1.position() == deposito.position().down(1)
	method cajasEnPosicion(){
		const cajas = game.allVisuals().copy()
		cajas.removeAll([deposito,personajeNivel1,fondoNivel1,indicadorPrimario,indicadorCentena,barraSuperior])
		return cajas.count({caja => caja.position().x().between(3,6) and caja.position().y().between(11,12)})
	}
	method cajasListas(){
		return self.cajasEnPosicion().equals(8)
	}
	method llavesListas() {
		return personajeNivel2.llavesEncontradas().equals(3)
	}
}

object colocadores{
	method caja(){
		const posicionAleatoria = posiciones.posicionAleatoriaCajas()
		if (posiciones.posicionEstaVacia(posicionAleatoria)) { 
			game.addVisual( new Caja(position=posicionAleatoria) )
		}
		else { self.caja() }
	}

	method pollo(){
		const posicionAleatoria = posiciones.asignarPosicionAleatoria()
		if (posiciones.posicionEstaVacia(posicionAleatoria)) { 
			game.addVisual( new Pollo(energia=aleatorios.numeroDecena(),position=posicionAleatoria) )
		}
		else { self.pollo() }
	}
	
	method objetoNivel2(objeto) {
		const posicionAleatoria = posiciones.asignarPosicionAleatoria()
		if (posiciones.posicionEstaVacia(posicionAleatoria)) { 
			objeto.position(posicionAleatoria)
			game.addVisual( objeto )	
		}
		else { self.objetoNivel2(objeto) }
	}
	
	method laberintoLadrillo(){
		14.times({ fila => laberinto.posiciones().get(fila-1).forEach({ columna => game.addVisual(new ParedLadrillo(position=columna))})})
	}
}

object actualizadores{
	method cajasRestantes(){ indicadorCentena.valor(8 - verificadores.cajasEnPosicion()) }
	method energiaRestante(){
		const unidad = personajeNivel2.energia() % 10
		const decena = personajeNivel2.energia().div(10) % 10
		const centena = personajeNivel2.energia().div(100)
		indicadorUnidad.valor(unidad)
		indicadorDecena.valor(decena)
		indicadorCentena.valor(centena)
	}
	method llavesRestantes() {
		indicadorNumericoSecundario.valor(3 - personajeNivel2.llavesEncontradas())
	} 
	method llavesListas() {
		if (verificadores.llavesListas()) {
			try { game.removeVisual(llaveNivel2) } catch e { game.removeVisual(cofreNivel2) }
			game.addVisual(puertaDeSalidaNivel2)
			personajeNivel2.llavesEncontradas(0)
		}
	}
	method energiaDePersonajeEn(nivel) {
		if (personajeNivel2.energia().equals(0)) {
			nivel.perderNivel()
		}
	}
	method personajeCruzoPuertaEn(nivel) {
		if (game.hasVisual(puertaDeSalidaNivel2) and personajeNivel2.position() == puertaDeSalidaNivel2.position() ) { 
			nivel.ganarNivel()
		}
	}
}


