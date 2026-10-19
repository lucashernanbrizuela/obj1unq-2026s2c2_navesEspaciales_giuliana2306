class Nave {
    var property velocidad = 0

    method recibirAmenaza()

    method propulsar() {
        velocidad = velocidad + 20000
        if (velocidad > 300000) {
            velocidad = 300000
        }
    }
    method prepararNaveParaViaje() {
        velocidad = velocidad + 15000.min(300000)
    }
}

/*

*/


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

class NaveDeCargaDeResiduosRadioactivos inherits NaveDeCarga {
    var selladaAlVacio = false

    method sellarAlVacio() {
        selladaAlVacio = true
    }
    method estaSelladaAlVacio() {
        return selladaAlVacio
    }
    method abrirVacio() {
        selladaAlVacio = false
    }
    override method recibirAmenaza() {
        velocidad = 0
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

/*
method prepararNaveParaViaje() {
        velocidad = velocidad + 15000.min(300000)
        NaveDeCargaDeResiduosRadioactivos.sellarAlVacio()
        self.prepararNaveDeCombate()
    }
    method prepararNaveDeCombate() {
        if ( NaveDeCombate.modo() == ataque) {
            NaveDeCombate.emitirMensaje("Volviendo a la base")
        } else { 
            NaveDeCombate.emitirMensaje("Saliendo en misión")
            NaveDeCombate.modo(ataque)
        }
    }
*/

/*
Hacer que todas las naves se puedan preparar para viajar. Esto hace que aumenten su velocidad 15.000 kms/seg 
(teniendo la restricción de la velocidad máxima posible de 300.000kms/s).

Además de eso ocurre lo siguiente:

    las naves que cargan residuos radioactivos se cierran al vacío.
    y las de combate, si se encuentran en modo ataque, emiten el mensaje "Volviendo a la base", 
    mientras que si están en reposo emiten el mensaje "Saliendo en misión" y se ponen en modo ataque.

*/