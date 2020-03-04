//
//  EntrarViewController.swift
//  Uber
//
//  Created by MangoBits on 02/03/20.
//  Copyright © 2020 Curso iOS. All rights reserved.
//

import UIKit
import FirebaseAuth

class EntrarViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    
    @IBAction func entrar(_ sender: Any) {
        let retorno = self.validaCampo()
        if retorno == ""{
            
            
            //autenticação do usuário (login)
            let autenticacao = Auth.auth()
            
            if let emailR = self.email.text{
                if let senhaR = self.senha.text{
                    
                    autenticacao.signIn(withEmail: emailR, password: senhaR, completion:{(usuario, erro) in
                        
                        if erro == nil {
                            
                            if usuario != nil {
                                self.performSegue(withIdentifier: "segueLogin", sender: nil)
                            }
                            
                        }else{
                            print("Erro ao autenticar o usuário, tente novamente!")
                        }
                       
                    })
                        
                }
            }
            
            
            
        }else{
            print("O campos \(retorno) não foi preenchido!")
        }
        
        
        
    }
    func validaCampo () -> String{
        if(self.email.text?.isEmpty)! {
            return "E-mail"
        }else if (self.senha.text?.isEmpty)!{
            return "Senha"
        }
        
        return ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }


}
