//
//  CadastroViewController.swift
//  ListaCidade
//
//  Created by Cátia Souza on 24/09/23.
//

import UIKit

class CadastroViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var end: UITextField!
    @IBOutlet weak var problema: UITextField!
    var lista: ListaC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let lista = lista {
            title = "Edicao"
            name.text = lista.nome
            end.text = lista.end
            problema.text = lista.desc
        }
        
    }
    @IBAction func cadastro(_ sender: Any) {
        if lista == nil {
            lista = ListaC(context: context)
        }
        
        lista?.desc = problema.text
        lista?.end = end.text
        lista?.nome = name.text
        try? context.save()
        
        navigationController?.popViewController(animated: true)
    }
    

   
    

}
