//
//  ViewController.swift
//  ListaCidade
//
//  Created by Cátia Souza on 24/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var geral: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var endereco: UILabel!
    @IBOutlet weak var name: UILabel!
    
    var lista: ListaC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareScreen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ViewController {
            controller.lista
        }
    }
    func prepareScreen(){
        if let lista = lista {
           // image.image = UIImage(named: "mapa")
            geral.text = lista.desc
            descricao.text = lista.desc
            name.text = lista.nome
            endereco.text = lista.end
            
            
        }
    }

}

