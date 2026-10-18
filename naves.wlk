class Nave {
    var property velocidad = 0

    method recibirAmenaza()
}

class NaveDeCarga inherits Nave {
    var property carga = 0

    method sobrecargada() = carga > 100000

    method excedidaDeVelocidad() = velocidad > 100000

    override method recibirAmenaza() {
        carga = 0
    }
    
    method enFalta() = self.sobrecargada() and self.excedidaDeVelocidad()
    
    method acercamientoDeControl() {
        if (self.enFalta()) {
            self.recibirAmenaza()
        }
    }
}



class NaveDePasajeros inherits Nave {
    var property alarma = false
    const cantidadDePasajeros = 0

    method tripulacion() = cantidadDePasajeros + 4

    method velocidadMaximaPermitida() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

    method estaEnPeligro() = velocidad > self.velocidadMaximaPermitida() or alarma

    override method recibirAmenaza() {
        alarma = true
    }
}

class NaveDeCombate inherits Nave {
    var property modo = reposo
    const property mensajesEmitidos = []

    method emitirMensaje(mensaje) {
        mensajesEmitidos.add(mensaje)
    }
    
    method ultimoMensaje() = mensajesEmitidos.last()

    method estaInvisible() = velocidad < 10000 and modo.invisible()

    override method recibirAmenaza() {
        modo.recibirAmenaza(self)
    }
}
object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

}
