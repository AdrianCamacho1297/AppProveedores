//
//  ViewController.swift
//  AppProveedor
//
//  Created by Jesus Adrian Camacho Rocha on 05/04/21.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    
    var proveedores = [Proveedor]()
    var adminBD : AdminBD = AdminBD()

    @IBOutlet weak var txtClave: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        txtClave.becomeFirstResponder()
    }

    @IBAction func btnAdd(_ sender: UIButton) {
        if txtClave.text!.isEmpty || txtNombre.text!.isEmpty || txtCorreo.text!.isEmpty {
            showAlert(Titulo: "Error", Mensaje: "Faltan Datos por Ingresar")
            txtClave.becomeFirstResponder()
        } else {
            let cla = Int(txtClave.text!)!
            let nom = txtNombre.text!
            let cor = txtCorreo.text!
            /*
            proveedores.append(Proveedor(clave: cla, nombre: nom, correo: cor))
            */
            let query : String = "INSERT INTO proveedores (claProveedor, nomProveedor, corProveedor) VALUES (\(cla), '\(nom)', '\(cor)')"
            if adminBD.run(query: query) {
                showAlert(Titulo: "Completado", Mensaje: "El Provedoor fue Agregado Correctamente")
                txtClave.text = ""
                txtNombre.text = ""
                txtCorreo.text = ""
                txtClave.becomeFirstResponder()
            } else {
                showAlert(Titulo: "Error", Mensaje: "El Provedoor no fue Agregado")
                txtClave.text = ""
                txtNombre.text = ""
                txtCorreo.text = ""
                txtClave.becomeFirstResponder()
            }
        }
    }
    
    @IBAction func btnRead(_ sender: UIButton) {
        var prov = [Proveedor]()
        let query : String = "SELECT * FROM proveedores ORDER BY claProveedor ASC"
        let pointQuery : OpaquePointer? = adminBD.read(query: query)
        while sqlite3_step(pointQuery) == SQLITE_ROW {
            let clave = Int(sqlite3_column_int(pointQuery, 0))
            let nombre = String(describing: String(cString: sqlite3_column_text(pointQuery, 1)))
            let correo = String(describing: String(cString: sqlite3_column_text(pointQuery, 2)))
            prov.append(Proveedor(clave: clave, nombre: nombre, correo: correo))
        }
        proveedores = prov
        self.performSegue(withIdentifier: "segueListProveedor", sender: self)
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        if txtClave.text!.isEmpty || txtNombre.text!.isEmpty || txtCorreo.text!.isEmpty {
            showAlert(Titulo: "Error", Mensaje: "Faltan Datos por Ingresar")
            txtClave.becomeFirstResponder()
        } else {
            let cla = Int(txtClave.text!)!
            let nom = txtNombre.text!
            let cor = txtCorreo.text!
            let query : String = "UPDATE proveedores SET nomProveedor = '\(nom)', corProveedor = '\(cor)' WHERE claProveedor = \(cla)"
            if adminBD.run(query: query) {
                showAlert(Titulo: "Completado", Mensaje: "El Provedoor fue Agregado Correctamente")
                txtClave.text = ""
                txtNombre.text = ""
                txtCorreo.text = ""
                txtClave.becomeFirstResponder()
            } else {
                showAlert(Titulo: "Error", Mensaje: "El Provedoor no fue Agregado")
                txtClave.text = ""
                txtNombre.text = ""
                txtCorreo.text = ""
                txtClave.becomeFirstResponder()
            }
        }
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        if txtClave.text!.isEmpty {
            showAlert(Titulo: "Error", Mensaje: "Faltan Agregar la Clave del Proveedor")
            txtClave.becomeFirstResponder()
        } else {
            let cla = Int(txtClave.text!)!
            let query : String = "DELETE FROM proveedores WHERE claProveedor = \(cla)"
            if adminBD.run(query: query) {
                showAlert(Titulo: "Completado", Mensaje: "El Provedoor fue Eliminado Correctamente")
                txtClave.text = ""
                txtNombre.text = ""
                txtCorreo.text = ""
                txtClave.becomeFirstResponder()
            } else {
                showAlert(Titulo: "Error", Mensaje: "El Provedoor no fue Eliminado")
                txtClave.text = ""
                txtNombre.text = ""
                txtCorreo.text = ""
                txtClave.becomeFirstResponder()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueListProveedor" {
            let tvc = segue.destination as! ProveedorTableViewController
            tvc.proveedores = self.proveedores
        }
    }
    
    func showAlert(Titulo : String, Mensaje : String){
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

