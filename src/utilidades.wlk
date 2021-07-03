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
		(1..8).forEach({ i => colocar.caja() })
		game.addVisual(indicadorCajas)
		// Deposito
		game.addVisual(deposito)
	}
	method nivelLlaves(){
		// Fondo
		game.addVisual(barraSuperior)
		game.addVisual(fondoNivel2)
		indicadorSuperior.nivel(2)
		game.addVisual(indicadorSuperior)
		indicadorCentena.valor(0)
		game.addVisual(indicadorCentena)
		game.addVisual(indicadorDecena)
		game.addVisual(indicadorUnidad)
		// Muros
		(0..13).forEach({ i => posiciones.muros(i).forEach({pos => game.addVisual(new ParedLadrillo(position=pos))}) })
		
		// Llaves 3
		(1..3).forEach({ i => colocar.llave() })
		// Pollos 5
		(1..5).forEach({ i => colocar.pollo() })
		// Modificadores 3
		(1..4).forEach({ posicion => colocar.modificador(posicion) })

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
	method muros(clave) {
		const fila = game.origin().up(clave)
		const laberinto = [
			0->[fila.left(3),fila.left(7)],
			1->[fila.left(1),fila.left(3),fila.left(5),fila.left(7),fila.left(9),fila.left(11),fila.left(13)],
			2->[fila.left(3),fila.left(5),fila.left(9),fila.left(10),fila.left(11),fila.left(13)],
			3->[fila,fila.left(1),fila.left(3),fila.left(5),fila.left(6),fila.left(7),fila.left(13)],
			4->[fila.left(3),fila.left(5),fila.left(7),fila.left(8),fila.left(9),fila.left(10),fila.left(11),fila.left(12),fila.left(13)],
			5->[fila.left(1),fila.left(2),fila.left(3),fila.left(5),fila.left(11)],
			6->[fila.left(3),fila.left(7),fila.left(9),fila.left(11),fila.left(13),fila.left(14)],
			7->[fila,fila.left(2),fila.left(3),fila.left(5),fila.left(6),fila.left(7),fila.left(9)],
			8->[fila,fila.left(5),fila.left(6),fila.left(9),fila.left(11),fila.left(12),fila.left(13)],
			9->[fila.left(2),fila.left(3),fila.left(5),fila.left(8),fila.left(9),fila.left(11)],
			10->[fila.left(1),fila.left(2),fila.left(4),fila.left(5),fila.left(6),fila.left(7),fila.left(8),fila.left(11),fila.left(13),fila.left(14)],
			11->[fila.left(4),fila.left(8),fila.left(9),fila.left(10),fila.left(11)],
			12->[fila,fila.left(1),fila.left(2),fila.left(4),fila.left(6),fila.left(11),fila.left(13)],
			13->[fila,fila.left(1),fila.left(2),fila.left(6),fila.left(7),fila.left(8),fila.left(9),fila.left(13)]
		]
		return laberinto.get(clave)
	}
}

object verificadores{
	method personajeNivel1EstaEnPosicionDeSalida() = personajeNivel1.position() == deposito.position().down(1)
	method cajasEnPosicion(){
		const cajas = game.allVisuals().copy()
		cajas.removeAll([deposito,personajeNivel1,fondoNivel1,indicadorSuperior,indicadorCentena,barraSuperior])
		return cajas.count({caja => caja.position().x().between(3,6) and caja.position().y().between(12,13)})
	}
	method cajasListas(){
		return self.cajasEnPosicion().equals(8)
		/*const cajas = game.allVisuals().remove(deposito,personajeNivel1,fondoNivel1,indicadorSuperior,indicadorCentena)
		return cajas.all({caja => caja.position().x().between(3,6) and caja.position().y().between(12,13)})*/
	}
}

object colocar{
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
}



