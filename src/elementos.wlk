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
	const property position = game.at(game.height()-1,game.width()-1)
	var property valor = 0
	var property image = self.valor()+".png"
}
object indicadorDecena{
	const property position = game.at(game.height()-1,game.width()-2)
	var property valor = 0
	var property image = self.valor()+".png"
}
object indicadorCentena{
	const property position = game.at(game.height()-1,game.width()-3)
	var property valor = 0
	var property image = self.valor()+".png"
}


class Objeto{
	var property position
	method image()
	method puedeColisionar()
	method mover(unSentido) { }
	method puedeMover(unSentido) = false
}








