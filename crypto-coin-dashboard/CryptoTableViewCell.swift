//
//  CryptoTableViewCell.swift
//  crypto-coin-dashboard
//
//  Created by Oliver Ekwalla on 09/10/2022.
//

import UIKit

//struct CryptoTableViewCellViewModel {
//    let name: String
//    let symbol : String
//    let image : String
//}

class CryptoTableViewCell: UITableViewCell {

   // static let identifier = "CryptoTableViewCell"
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var price_change_24hLabel: UILabel!
}
