import wollok.game.*
import elementos.*
import personajes.*

object aleatorios{
	method numeroCentena() 	= 1.randomUpTo(9).truncate(0) * 100
	method numeroDecena() 	= 1.randomUpTo(9).truncate(0) * 10
	method numeroUnidad() 	= 1.randomUpTo(9).truncate(0)
}

object conversacion{
	method nivel1Inicio() {
		game.say(deposito, "Deposito: Hola jugador. Bienvenido!")
		game.say(deposito, "Deposito: Me podrias ayudar con esas cajas?")
		game.say(deposito, "Deposito: Hay que llevarlas a la plataforma de piedra a tu derecha.")
		game.say(deposito, "Deposito: Va una en cada espacio, no puedes apilarlas.")
		game.say(deposito, "Deposito: Cuando termines te ayudare a continuar tu aventura.")
	}
}

object configNivelCajas{
	method aplicar(){
		// Cajas:
		game.addVisual(new Caja(position=posiciones.posicionAleatoriaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionAleatoriaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionAleatoriaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionAleatoriaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionAleatoriaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionAleatoriaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionAleatoriaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionAleatoriaCajas()))	
	}
}
object posiciones {
	method posicionAleatoriaCajas() 	= game.at( 1.randomUpTo(game.width()-2).truncate(0), 1.randomUpTo(game.height()-5).truncate(0) )
	method asignarPosicionAleatoria() 	= game.at( 0.randomUpTo(game.width()-1).truncate(0), 0.randomUpTo(game.height()-1).truncate(0) ) 
}

object verificadorDeCajas{
	method puedePasarDeNivel(){
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
}

object posicionPollos{
	var position
	method position() = position
	method colocarPollo(){
		position = posiciones.asignarPosicionAleatoria()
		if (game.getObjectsIn(self.position()).isEmpty()) { game.addVisual( new Pollo(energia=aleatorios.numeroDecena(),position=self.position()) ) }
		else { self.colocarPollo() }
	}
	method colocarPollos(){
		self.colocarPollo()
		self.colocarPollo()
		self.colocarPollo()
		self.colocarPollo()
		self.colocarPollo()
		
	}
}


