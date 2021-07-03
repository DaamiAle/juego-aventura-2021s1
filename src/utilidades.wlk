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
		game.addVisual(indicadorSuperior)
		// Cajas:
		8.times({ i => colocadores.caja() })
		game.addVisual(indicadorCajas)
		// Deposito
		game.addVisual(deposito)
		// Personaje
		personajeNivel1.position(game.at(1,game.width()-3))
		game.addVisual(personajeNivel1)
	}
	method nivelLlaves(){
		// Fondo
		game.addVisual(barraSuperior)
		game.addVisual(fondoNivel2)
		indicadorSuperior.nivel(2)
		game.addVisual(indicadorSuperior)
		game.addVisual(indicadorCentena)
		game.addVisual(indicadorDecena)
		game.addVisual(indicadorUnidad)
		// Muros
		colocadores.laberintoLadrillo()
//		14.times({ fila => colocadores.muros(fila-1)/*.get(fila-1).forEach({pos => game.addVisual(new ParedLadrillo(position=pos))}) */ })
		// Llaves 3
		3.times({ i => colocadores.llave() })
		// Pollos 5
		5.times({ i => colocadores.pollo() })
		// Modificadores 3
		4.times({ posicion => colocadores.modificador(posicion) })

		// Personaje
		personajeNivel2.position(game.at(1,game.width()-3))
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
		cajas.removeAll([deposito,personajeNivel1,fondoNivel1,indicadorSuperior,indicadorCentena,barraSuperior])
		return cajas.count({caja => caja.position().x().between(3,6) and caja.position().y().between(11,12)})
	}
	method cajasListas(){
		return self.cajasEnPosicion().equals(8)
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
	method llave(){
		const posicionAleatoria = posiciones.asignarPosicionAleatoria()
		if (posiciones.posicionEstaVacia(posicionAleatoria)) { 
			game.addVisual( new Llave(position=posicionAleatoria) )
		}
		else { self.llave() }
	}
	method modificador(posicion){
		game.addVisual( new Modificador(tipo=aleatorios.numeroUnidad()%3,position=posicion) )
	}
	method cofre(){
		const posicionAleatoria = posiciones.asignarPosicionAleatoria()
		if (posiciones.posicionEstaVacia(posicionAleatoria)) { 
			game.addVisual( new Cofre(position=posicionAleatoria) )
		}
		else { self.cofre() }
	}
	method puertaSalidaNivel2(){
		
	}
	method personajeNivel2EnPosicionAleatoria(){
		
	}
	method laberintoLadrillo(){
		14.time({ fila => laberinto.posiciones().get(fila-1).size().times({ columna => game})})
		laberinto.posiciones().get({i => i.get(0) })
		laberinto.posiciones().get(fila).forEach({ pos => game.addVisual(new ParedLadrillo(position = pos)) })
	}
}

object actualizadores{
	method cajasRestantes(){ indicadorCajas.valor(8 - verificadores.cajasEnPosicion()) }
}


