import wollok.game.*
import elementos.*
import elementos_nivel1.*
//import elementos_nivel2.*
import personajes.*


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
	method personajeNoPuedeMoverse(unPersonaje){
		game.say(unPersonaje,"Personaje: No puedo moverme en esa direccion")
	}
}