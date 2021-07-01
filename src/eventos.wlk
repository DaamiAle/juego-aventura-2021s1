import wollok.game.*
import elementos.*
import personajes.*

object aleatorios{
	method numeroCentena() 	= 1.randomUpTo(9).truncate(0) * 100
	method numeroDecena() 	= 1.randomUpTo(9).truncate(0) * 10
	method numeroUnidad() 	= 1.randomUpTo(9).truncate(0)
}

object dialogos{
	method nivel1Inicio() {
		game.say(deposito, "Deposito: Hola jugador. Bienvenido!")
		game.say(deposito, "Deposito: Me podrias ayudar con esas cajas?")
		game.say(deposito, "Deposito: Hay que llevarlas a la plataforma de piedra a tu derecha.")
		game.say(deposito, "Deposito: Va una en cada espacio, no puedes apilarlas.")
		game.say(deposito, "Deposito: Cuando termines te ayudare a continuar tu aventura.")
	}
	method cajasNivel1Faltantes(){
		game.say(deposito, "Deposito: Aun no puedes pasar de nivel")
		game.say(deposito, "Deposito: Faltan cajas por colocar en la plataforma.")
	}
	method posicionDeSalidaIncorrecta(){
		game.say(personajeNivel1, "No puedo pasar de nivel desde aqui.")
		game.say(personajeNivel1, "Debo estar debajo del deposito.")
	}
	method personajeNoPuedeMoverse(){
		game.say(self,"Personaje: No puedo moverme en esa direccion")
	}
}

object configuraciones{
	method nivelCajas(){
		// Fondo
		game.addVisual(fondoNivel1)
		// Cajas:
		colocadores.caja()
		colocadores.caja()
		colocadores.caja()
		colocadores.caja()
		colocadores.caja()
		colocadores.caja()
		colocadores.caja()
		colocadores.caja()
		// Deposito
		game.addVisual(deposito)
		
	}
	method nivelLlaves(){
		// Fondo
		game.addVisual(fondoNivel2)
		// Muros
		
		// Llaves 3
		colocadores.llave()
		colocadores.llave()
		colocadores.llave()
		// Pollos 5
		colocadores.pollo()
		colocadores.pollo()
		colocadores.pollo()
		colocadores.pollo()
		colocadores.pollo()
		// Modificadores 3
		colocadores.modificador()
		colocadores.modificador()
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
}

object verificadores{
	method personajeNivel1EstaEnPosicionDeSalida() = personajeNivel1.position() == deposito.position().down(1)
	method cajasListas(){
		var objetos = game.getObjectsIn(((deposito.position().right(2))))
		var resultado = not objetos.isEmpty()
		objetos = game.getObjectsIn(((deposito.position().right(3))))
		resultado = resultado and not objetos.isEmpty()
		objetos = game.getObjectsIn(((deposito.position().right(4))))
		resultado = resultado and not objetos.isEmpty()
		objetos = game.getObjectsIn(((deposito.position().right(5))))
		resultado = resultado and not objetos.isEmpty()
		objetos = game.getObjectsIn(((deposito.position().right(2).down(1))))
		resultado = resultado and not objetos.isEmpty()
		objetos = game.getObjectsIn(((deposito.position().right(3).down(1))))
		resultado = resultado and not objetos.isEmpty()
		objetos = game.getObjectsIn(((deposito.position().right(4).down(1))))
		resultado = resultado and not objetos.isEmpty()
		objetos = game.getObjectsIn(((deposito.position().right(5).down(1))))	
		resultado = resultado and not objetos.isEmpty()
		return resultado
	}
	method posicionEstaVacia(unaPosicion) = game.getObjectsIn(unaPosicion).isEmpty()
}

object colocadores{
	method caja(){
		const posicionAleatoria = posiciones.posicionAleatoriaCajas()
		if (verificadores.posicionEstaVacia(posicionAleatoria)) { 
			game.addVisual( new Caja(position=posicionAleatoria) )
		}
		else { self.caja() }
	}
	method pollo(){
		const posicionAleatoria = posiciones.asignarPosicionAleatoria()
		if (verificadores.posicionEstaVacia(posicionAleatoria)) { 
			game.addVisual( new Pollo(energia=aleatorios.numeroDecena(),position=posicionAleatoria) )
		}
		else { self.pollo() }
	}
	method llave(){
		const posicionAleatoria = posiciones.asignarPosicionAleatoria()
		if (verificadores.posicionEstaVacia(posicionAleatoria)) { 
			game.addVisual( new Llave(position=posicionAleatoria) )
		}
		else { self.llave() }
	}
	method modificador(){
		const posicionAleatoria = posiciones.asignarPosicionAleatoria()
		if (verificadores.posicionEstaVacia(posicionAleatoria)) { 
			game.addVisual( new Modificador(tipo=aleatorios.numeroUnidad()%3,position=posicionAleatoria) )
		}
		else { self.modificador() }
	}
	method cofre(){
		const posicionAleatoria = posiciones.asignarPosicionAleatoria()
		if (verificadores.posicionEstaVacia(posicionAleatoria)) { 
			game.addVisual( new Cofre(position=posicionAleatoria) )
		}
		else { self.cofre() }
	}
	method puertaSalidaNivel2(){
		
	}
	method personajeNivel2EnPosicionAleatoria(){
		
	}
}


