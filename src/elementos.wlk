import wollok.game.*


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
object indicadorUnidad{
	var property valor = 0
	method position() = game.at(13,14)
	method image() = self.valor().toString() +".png"
}
object indicadorDecena{
	var property valor = 0
	method position() = game.at(12,14)
	method image() = self.valor().toString() +".png"
}
object indicadorCentena{
	var property valor = 0
	method position() = game.at(11,14)
	method image() = self.valor().toString() +".png"
}
//object indicadorCajas{
//	const property position = game.at(11,14)
//	var property valor = 8
//	method image() = self.valor().toString() +".png"
//}
object indicadorNumericoSecundario{
	var property valor = 3
	method position() = game.at(8,14)
	method image() = self.valor().toString() +".png"
}
object indicadorSecundario{
	method position() = game.at(7,14)
	method image() = ".png"
}
object indicadorPrimario{
	const property position = game.at(10,14)
	var property nivel = 1
	method image() = "indicadorNivel"+ self.nivel().toString() +".png"
}


class Objeto{
	var property position
	method image()
	method puedeColisionar()
	method mover(unSentido) { }
	method puedeMover(unSentido) = false
}

object barraSuperior{
	const property image = "barraSuperior.png"
	const property position = game.at(0,14)
}

object finalNivel1 {
	method position() = game.origin()
	method image() = "finNivel1.png"
}








