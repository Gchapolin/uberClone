//
//  CadastroViewController.swift
//  Uber
//
//  Created by MangoBits on 02/03/20.
//  Copyright © 2020 Curso iOS. All rights reserved.
//

import UIKit
import FirebaseAuth

class CadastroViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var nomeCompleto: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var tipoUsuario: UISwitch!
    
    @IBAction func cadastrarUsuario(_ sender: Any) {
        let retorno = self.validaCampo()
        if retorno == ""{
            
            //cadastro de usuário no firebase
            let autenticacao = Auth.auth()
            
            if let emailR = self.email.text{
                if let nomeR = self.nomeCompleto.text{
                    if let senhaR = self.senha.text{
                        
                        autenticacao.createUser(withEmail: emailR, password: senhaR, completion:
                            {(usuario, erro) in
                                if erro == nil {
                                    
                                    if usuario != nil {
                                        self.performSegue(withIdentifier: "segueLoginCadastro", sender: nil)
                                        
                                    }else{
                                        print("Erro ao autenticar o usuário")
                                    }
                                    
                                    print("❤️")
                                }else{
                                    print("🌮")
                                }
                            
                        })
                    }
                }
            }
            
        }else{
            print("O Campo \(retorno) não foi preenchido")
        }
    
    
    }
    
    func validaCampo () -> String{
        if(self.email.text?.isEmpty)! {
            return "E-mail"
        }else if (self.nomeCompleto.text?.isEmpty)!{
            return "Nome Completo"
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
