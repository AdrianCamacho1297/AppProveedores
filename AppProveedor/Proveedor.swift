//
//  Proveedor.swift
//  AppProveedor
//
//  Created by Jesus Adrian Camacho Rocha on 05/04/21.
//

import Foundation

class Proveedor {
    var claProveedor : Int = 0
    var nomProveedor : String = ""
    var corProveedor : String = ""
    
    init(clave : Int, nombre : String, correo : String) {
        self.claProveedor = clave
        self.nomProveedor = nombre
        self.corProveedor = correo
    }
}
