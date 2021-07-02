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
	var property image = indicadorNumero.imagenNumero(self.valor())
}
object indicadorDecena{
	const property position = game.at(game.height()-1,game.width()-2)
	var property valor = 0
	var property image = indicadorNumero.imagenNumero(self.valor())
}
object indicadorCentena{
	const property position = game.at(game.height()-1,game.width()-3)
	var property valor = 0
	var property image = indicadorNumero.imagenNumero(self.valor())
}
object indicadorNumero{
	method imagenNumero(unNumero){
		var imagen = ""
		if (unNumero.equals(0)) {imagen = "0.png"}
		if (unNumero.equals(1)) {imagen = "1.png"}
		if (unNumero.equals(2)) {imagen = "2.png"}
		if (unNumero.equals(3)) {imagen = "3.png"}
		if (unNumero.equals(4)) {imagen = "4.png"}
		if (unNumero.equals(5)) {imagen = "5.png"}
		if (unNumero.equals(6)) {imagen = "6.png"}
		if (unNumero.equals(7)) {imagen = "7.png"}
		if (unNumero.equals(8)) {imagen = "8.png"}
		if (unNumero.equals(9)) {imagen = "9.png"}
		return imagen
	}
}

class Objeto{
	var property position
	method image()
	method puedeColisionar()
	method mover(unSentido) { }
	method puedeMover(unSentido) = false
}








