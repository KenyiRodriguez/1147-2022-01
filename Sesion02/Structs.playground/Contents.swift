import UIKit

struct Persona {
    var nombre: String
    var apellido: String
    var direccion: String?
    
    var nombreCompleto: String {
        return "\(self.nombre) \(self.apellido)"
    }
    
    var iniciales: String {
        let nomnbre = self.nombre.prefix(1).uppercased()
        let apellido = self.apellido.prefix(1).uppercased()
        return nomnbre + apellido
    }
    
    init(nombre: String, apellido: String) {
        self.nombre = nombre
        self.apellido = apellido
    }
    
    func gotToHome() {
        let direccionSegura = self.direccion ?? "Dirección no especificada"
        print("Vamos a casa ubicada en: \(direccionSegura)")
    }
}


var persona1 = Persona(nombre: "Kenyi", apellido: "Rodriguez")
var persona2 = persona1

persona1.nombre = "Juan"

persona1.nombre
persona2.nombre




//persona.direccion = "Calle los olvidados del señor 666"
//persona.nombreCompleto
//persona.iniciales
//persona.direccion
//
//persona.gotToHome()
//persona.nombre = "dfdfdf"




struct Motor {
    
    let cilindrada: String
    let potencia: String
    
    func encender() {
        print("Motor encendido")
    }
    
    func apagar() {
        print("Motor apagado")
    }
}

struct Automovil {
    
    let motor: Motor
    
    func andar() {
        self.motor.encender()
        self.motor.apagar()
    }
}

let motor = Motor(cilindrada: "2.0T", potencia: "280HP")
let auto = Automovil(motor: motor)

auto.motor.cilindrada
auto.motor.potencia
auto.motor.apagar()
auto.motor.encender()
auto.andar()
