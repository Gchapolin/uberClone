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

class PassageiroViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
     

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //recuperar as coordenadas do usuário
        if let coordenadas = manager.location?.coordinate{
        
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
