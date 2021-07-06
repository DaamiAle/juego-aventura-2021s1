import wollok.game.*

class Objeto{
	var property position
	method image()
	method mover(unSentido) { }
	method puedeMover(unSentido) = false
}

object indicadorPrimario inherits Objeto{
	var property nivel = 1
	override method position() = game.at(10,14)
	override method image() = "indicadorPrimarioNivel"+ self.nivel().toString() +".png"
}
object indicadorSecundario inherits Objeto {
	var property nivel = 2
	override method position() = game.at(7,14)
	override method image() = "indicadorSecundarioNivel"+ self.nivel().toString() +".png"
}
class IndicadorNumerico inherits Objeto{
	var property valor = 0
	override method image() = self.valor().toString() +".png"
}
object indicadorUnidad inherits IndicadorNumerico{ 
	override method position() = game.at(13,14)
}
object indicadorDecena inherits IndicadorNumerico{
	override method position() = game.at(12,14)
}
object indicadorCentena inherits IndicadorNumerico{
	override method position() = game.at(11,14)
}

object aleatorios{
	method numeroUnidad() 	= 1.randomUpTo(9).truncate(0)
	method numeroDecena() 	= self.numeroUnidad() * 10
	method numeroCentena() 	= self.numeroUnidad() * 100
	method sentido() = [arriba, abajo, izquierda, derecha].get(self.numeroUnidad() % 4)
}
object arriba{ 
	method position(obj) = obj.position().up(1)
	method siguiente() = derecha
	method anterior() = izquierda
	method opuesto() = abajo
}
object derecha{ 
	method position(obj) = obj.position().right(1)
	method siguiente() = abajo
	method anterior() = arriba
	method opuesto() = izquierda
} 
object abajo{ 
	method position(obj) = obj.position().down(1)
	method siguiente() = izquierda
	method anterior() = derecha
	method opuesto() = arriba
}
object izquierda{ 
	method position(obj) = obj.position().left(1)
	method siguiente() = arriba
	method anterior () = abajo
	method opuesto() = derecha
}

object barraSuperior inherits Objeto{
	const property image = "barraSuperior.png"
	override method position() = game.at(0,14)
}

object finales {
	var property nivel = 1
	method position() = game.origin()
	method image() = "finNivel" + self.nivel().toString() + ".png"
}

object finalNivel2 {
	var property resultado = "victoria"
	method position() = game.origin()
	method image() = self.resultado() + ".png"
}






