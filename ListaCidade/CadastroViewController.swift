//
//  CadastroViewController.swift
//  ListaCidade
//
//  Created by Cátia Souza on 24/09/23.
//

import UIKit

class CadastroViewController: UIViewController {

    @IBOutlet weak var botao: UIButton!
    @IBOutlet weak var imageCidade: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var end: UITextField!
    @IBOutlet weak var problema: UITextField!
    var lista: Lista?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let lista = lista {
            title = "Edicao"
            name.text = lista.nome
            end.text = lista.end
            problema.text = lista.desc
            botao.setTitle("Editar", for: .normal)
        }
        
    }
    @IBAction func cadastro(_ sender: Any) {
        if lista == nil {
            lista = Lista(context: context)
        }
        
        lista?.desc = problema.text
        lista?.end = end.text
        lista?.nome = name.text
        try? context.save()

        navigationController?.popViewController(animated: true)
    }
}
