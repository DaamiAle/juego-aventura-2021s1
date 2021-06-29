import wollok.game.*
import elementos.*
import personajes.*

object conversacion{
	method nivel1Inicio() {
		game.say(deposito, "Deposito: Hola jugador. Bienvenido!")
		
		
		game.say(personajeNivel1, "Jugador: Hola. Gracias!")
		
		game.say(personajeNivel1, "Jugador: En que te puedo ayudar?")
		
		game.say(deposito, "Deposito: Ya que lo dices...")
		game.say(deposito, "Deposito: Me podrias ayudar con esas cajas.")
		game.say(deposito, "Deposito: Hay que llevarlas a la plataforma de piedra a tu derecha.")
		game.say(deposito, "Deposito: Va una en cada espacio, no puedes apilarlas.")
		game.say(deposito, "Deposito: Cuando termines te ayudare a continuar tu aventura.")
	}
}

object configNivelCajas{
	method aplicar(){
		// Cajas:
		game.addVisual(new Caja(position=posiciones.posicionArbitrariaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionArbitrariaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionArbitrariaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionArbitrariaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionArbitrariaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionArbitrariaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionArbitrariaCajas()))
		game.addVisual(new Caja(position=posiciones.posicionArbitrariaCajas()))	
	}
}
object posiciones {
	method posicionArbitrariaCajas() = game.at( 1.randomUpTo(game.width()-2).truncate(0), 1.randomUpTo(game.height()-5).truncate(0) )
}

object verificarCajas{
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