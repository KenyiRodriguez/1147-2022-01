import UIKit

protocol Persona {
    var nombre: String { get }
    var apellido: String { get }
}

protocol Empleado {
    var codigoEmpleado: String { get }
}

protocol Docente {
    var especialidad: String { get set }
}


class Alumno: Persona {
    var nombre: String
    var apellido: String
    
    init(nombre: String, apellido: String) {
        self.nombre = nombre
        self.apellido = apellido
    }
}

class Profesor: Persona, Empleado, Docente {
    var nombre: String
    var apellido: String
    var codigoEmpleado: String
    var especialidad: String = ""
    
    init(nombre: String, apellido: String, codigoEmpleado: String) {
        self.nombre = nombre
        self.apellido = apellido
        self.codigoEmpleado = codigoEmpleado
    }
}

class Director: Persona, Empleado {
    var nombre: String
    var apellido: String
    var codigoEmpleado: String
    
    init(nombre: String, apellido: String, codigoEmpleado: String) {
        self.nombre = nombre
        self.apellido = apellido
        self.codigoEmpleado = codigoEmpleado
    }
}

var arrayPersonas = [Empleado]()
//arrayPersonas.append(Alumno(nombre: "", apellido: ""))
arrayPersonas.append(Profesor(nombre: "", apellido: "", codigoEmpleado: ""))
arrayPersonas.append(Director(nombre: "", apellido: "", codigoEmpleado: ""))
