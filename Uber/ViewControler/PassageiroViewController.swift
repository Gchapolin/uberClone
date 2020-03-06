//
//  PassageiroViewController.swift
//  Uber
//
//  Created by MangoBits on 02/03/20.
//  Copyright © 2020 Curso iOS. All rights reserved.
//

import UIKit
import FirebaseAuth
import MapKit
import FirebaseDatabase




class PassageiroViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    var localUsuario = CLLocationCoordinate2D()
     

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
    }
    
    
    @IBAction func chamarUber(_ sender: Any) {
        
        let database = Database.database().reference()
        let autenticaca = Auth.auth()
        
        let requisicao = database.child("requisicao")
        
        if let emailUsuario = autenticaca.currentUser?.email{
        
            let dadosUsuario = [
                "email": emailUsuario,
                "nome":"Guilherme",
                "latitude": self.localUsuario.latitude,
                "longitude": self.localUsuario.longitude
                
                
            ] as [String : Any]
            requisicao.childByAutoId().setValue(dadosUsuario)
            
        }

    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //recuperar as coordenadas do usuário
        if let coordenadas = manager.location?.coordinate{
            
            //Configura o local do usuario
            self.localUsuario = coordenadas
            
            let regiao = MKCoordinateRegion(center: coordenadas, latitudinalMeters: 2000, longitudinalMeters: 2000 )
            mapa.setRegion(regiao, animated: true)
            
            //remove anotações antes de criar o mapa
            mapa.removeAnnotations(mapa.annotations)
            
            //criar anotação da localização do usuario
            let anotacaoUsuario = MKPointAnnotation()
            anotacaoUsuario.coordinate = coordenadas
            anotacaoUsuario.title = "Seu Local"
            mapa.addAnnotation(anotacaoUsuario)
            
            
            }
    
        }
    
    
    @IBAction func deslogarUsuario(_ sender: Any) {
        
        let autenticacao = Auth.auth()
        
        do {
            try autenticacao.signOut()
            dismiss(animated: true, completion: nil)
        } catch  {
            print("Não foi possível deslogar o usuário")
        }
        
        
    }
    
}
