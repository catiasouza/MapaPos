//
//  ListaTableViewCell.swift
//  ListaCidade
//
//  Created by Cátia Souza on 24/09/23.
//

import UIKit

class ListaTableViewCell: UITableViewCell {

    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ mapa: Lista) {
        desc.text = mapa.desc
        data.text = mapa.end
        nome.text = mapa.nome
        
        imageView?.image = UIImage(named: data.mapa.image)
    }
}
