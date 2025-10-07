class Corsa {
  const property color

  method capacidad() = 4

  method velocidadMaxima() = 150

  method peso() = 1300 
}

class Kwid {
  var tieneTanqueDeGas

  method agregarTanque() {
    tieneTanqueDeGas = true
  }

  method quitarTanque() {
    tieneTanqueDeGas = false
  }

  method tieneTanqueDeGas() = tieneTanqueDeGas

  method capacidad() =
    if (tieneTanqueDeGas) 3 else 4

  method velocidadMaxima() =
    if (tieneTanqueDeGas) 120 else 110

  method peso() =
    if (tieneTanqueDeGas) 1350 else 1200

  method color() = "Azul"
}

object trafic {
  var property interior = comodo
  var property motor = bataton

  method capacidad() = interior.capacidad()
  method velocidadMaxima() = motor.velocidadMaxima()
  method peso() = 4000 + interior.peso() + motor.peso()
  method color() = "Blanco"
}

object comodo {
  method capacidad() = 5
  method peso() = 700
}

object popular {
  method capacidad() = 12
  method peso() = 1000
}

object pulenta {
  method peso() = 800
  method velocidadMaxima() = 130
}

object bataton {
  method peso() = 500
  method velocidadMaxima() = 80
}

class AutoEspecial {
  const property capacidad
  const property velocidadMaxima
  const property peso
  const property color   
}

class Dependencia {
  const property flota = #{}
  var property empleados
  const property pedidos = #{}

  method agregarPedido(pedido) {
    pedidos.add(pedido)
  }

  method quitarPedido(pedido) {
    pedidos.remove(pedido)
  }

  method agregarAFlota(rodado) {
    flota.add(rodado)
  }

  method quitarDeFlota(rodado) {
    flota.remove(rodado)
  }

  method pesoTotalFlota() =
    flota.sum({unRodado => unRodado.peso()})

  method estaBienEquipada() =
    flota.size() >= 3 && flota.all({unRodado => unRodado.velocidadMaxima() >= 100})
  
  method capacidadTotalEnColor(color) =
    flota.filter({unRodado => unRodado.color() == color}).sum({unRodado => unRodado.capacidad()})

  method colorDelRodadoMasRapido() = self.rodadoMasRapido().color()

  method rodadoMasRapido() = flota.max({unRodado => unRodado.velocidadMaxima()})

  method capacidadTotal() = flota.sum({unRodado => unRodado.capacidad()})

  method capacidadFaltante() = empleados - self.capacidadTotal()

  method esGrande() = empleados >= 40 && flota.size() >= 5

  method totalDePasajeros() =
    pedidos.sum({unPedido => unPedido.cantidadDePasajeros()})

  // method cualesPedidosNoSonSatisfechos() =
  //  pedidos.filter({unPedido => unPedido.satisfaceElPedido()})

  method todosLosPedidosSonIncompatibles(color) =
    pedidos.all({unPedido => unPedido.esColorIncompatible(color)})

  method relajarATodos() {
    pedidos.forEach({unPedido => unPedido.relajar()})
  }
}

// Etapa 2
class Pedido {
  const property distancia
  var tiempoMaximo
  const property cantidadDePasajeros
  const property coloresIncompatibles

  method tiempoMaximo() = tiempoMaximo

  method velocidadRequerida() = distancia / tiempoMaximo

  method satisfaceElPedido(auto) =
    auto.velocidadMaxima() >= self.velocidadRequerida() + 10 &&
    auto.capacidad() >= cantidadDePasajeros &&
    !coloresIncompatibles.contains(auto.color())

  method acelerar() {
    tiempoMaximo -= 1
  }
  method relajar() {
    tiempoMaximo += 1
  }

  method esColorIncompatible(color) = 
    coloresIncompatibles.contains(color)
}