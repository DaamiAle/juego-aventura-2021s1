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
		game.addVisual(fondoNivel1)
		// Cajas:
		([1,2,3,4,5,6,7,8]).forEach({ i => colocar.caja() })
		// Deposito
		game.addVisual(deposito)
	}
	method nivelLlaves(){
		// Fondo
		game.addVisual(fondoNivel2)
		// Muros
		
		// Llaves 3
		([1,2,3]).forEach({ i => colocar.llave() })
		// Pollos 5
		([1,2,3,4,5]).forEach({ i => colocar.pollo() })
		// Modificadores 3
		([1,2,3,4]).forEach({ posicion => colocar.modificador(posicion) })

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
	method cajasListas(){
		const cajas = game.allVisuals().remove(deposito,personajeNivel1,fondoNivel1)
		return cajas.all({caja => caja.position().x().between(3,6) and caja.position().y().between(12,13)})
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



