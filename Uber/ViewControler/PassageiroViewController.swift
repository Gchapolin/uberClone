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

class PassageiroViewController: UIViewController {

    @IBOutlet weak var mapa: MKMapView!
    
    
    @IBAction func deslogarUsuario(_ sender: Any) {
        
        let autenticacao = Auth.auth()
        
        do {
            try autenticacao.signOut()
            dismiss(animated: true, completion: nil)
        } catch  {
            print("Não foi possível deslogar o usuário")
        }
         
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
