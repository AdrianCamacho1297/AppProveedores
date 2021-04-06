//
//  ProveedorTableViewCell.swift
//  AppProveedor
//
//  Created by Jesus Adrian Camacho Rocha on 05/04/21.
//

import UIKit

class ProveedorTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblSubtitulo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
