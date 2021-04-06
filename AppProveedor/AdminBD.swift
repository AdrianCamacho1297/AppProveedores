//
//  AdminBD.swift
//  AppProveedor
//
//  Created by Jesus Adrian Camacho Rocha on 06/04/21.
//

import Foundation
import SQLite3

class AdminBD {
    let dbPath = "myDB.sqlite"
    var db : OpaquePointer?
    
    init() {
        db = openDataBase()
        createTableProveedores()
    }
    
    func openDataBase() -> OpaquePointer? {
        let archUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        var dataBase : OpaquePointer?
        if sqlite3_open(archUrl.path, &dataBase) != SQLITE_OK {
            print("Error al Abrir la Base de Datos")
            return nil
        } else {
            print("Se abrio la Base de Datos \(dbPath)")
            return dataBase
        }
    }
    
    func createTableProveedores() {
        let createTable : String = "CREATE TABLE IF NOT EXISTS proveedores (claProveedor INTEGER, nomProveedor TEXT, corProveedor TEXT)"
        var pointTable : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTable, -1, &pointTable, nil) == SQLITE_OK {
            if sqlite3_step(pointTable) == SQLITE_DONE {
                print("Tabla de Proveedores Creada")
            } else {
                print("Error, no se Creo la Tabla de Proveedores")
            }
            sqlite3_finalize(pointTable)
        }
    }
    
    func run(query : String) -> Bool {
        var pointQuery : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &pointQuery, nil) == SQLITE_OK {
            if sqlite3_step(pointQuery) == SQLITE_DONE {
                print("Se Ejecuto la Sentecia de Forma Correcta")
                sqlite3_finalize(pointQuery)
                return true
            } else {
                print("Error, no se Ejecuto la Sentencia Correctamente \(query)")
            }
        } else {
            print("No se Ejecuto el Query. \(query)")
        }
        sqlite3_finalize(pointQuery)
        return false
    }
    
    func read(query : String) -> OpaquePointer? {
        var pointQuery : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &pointQuery, nil) == SQLITE_OK {
            return pointQuery
        } else {
            print("Error, Al Ejecutar el Query -> \(query)")
            sqlite3_finalize(pointQuery)
            return pointQuery
        }
    }
}
