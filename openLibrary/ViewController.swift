//
//  ViewController.swift
//  openLibrary
//
//  Created by Juan Diego Merino on 11/20/15.
//  Copyright © 2015 Juan Diego Merino. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate{
    //Conexiones de interfaz necesarias
    @IBOutlet weak var inputISBN: UITextField!
    @IBOutlet var textoResultado: UITextView!
    let direccionServicio = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Acción al buscar
    @IBAction func botonBuscar(sender: AnyObject) {
        if let isbnABuscar = inputISBN.text {
            realizarConexion(isbnABuscar)
        }
        
    }
    
    //Para quitar el texto cuando toca cualquier parte de la pantalla
    @IBAction func tocaronFondo(sender: UIControl){
        print( "tocaron el fondo")
        inputISBN.resignFirstResponder()
    }
    
    
    //Función para realizar la conexión al servidor
    func realizarConexion (ISBN : String){
        let urlCompleta = direccionServicio + ISBN
        print(urlCompleta)
        let urlAConsultar = NSURL(string: urlCompleta)
        let sesionConexion = NSURLSession.sharedSession()
        
        let bloqueConsulta = {(datos : NSData?, respuesta : NSURLResponse?, error : NSError?) -> Void in
            
            
            dispatch_async(dispatch_get_main_queue()) {
                if((respuesta) != nil){
                    self.textoResultado.text = NSString(data: datos!, encoding: NSUTF8StringEncoding)! as String
                }else{
                    self.textoResultado.text = "Hubo un error al consultar el servicio"
                }
            }
            
        }
        
        let dt = sesionConexion.dataTaskWithURL(urlAConsultar!, completionHandler: bloqueConsulta)
        dt.resume()
        
        
        
        
    }
    
    
    
}

