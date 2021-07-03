import wollok.game.*
import utilidades.*
import personajes.*
import elementos.*
import elementos_nivel2.*
import nivel_llaves.*



object fondeo {
	method aplicar() {
		game.addVisual(new Sendero(position=game.at(0,0)))
		game.addVisual(new BarraSuperior(position=game.at(0,14)))
		game.addVisual(new IndicadorEnergia(position=game.at(10,14)))
		game.addVisual(new Salida(position=game.at(14,13)))
	}
	
}



