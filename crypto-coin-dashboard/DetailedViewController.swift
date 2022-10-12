//
//  DetailedViewController.swift
//  crypto-coin-dashboard
//
//  Created by Oliver Ekwalla on 08/10/2022.
//

import UIKit

class DetailedViewController: ViewController {
    
//    @IBOutlet weak var coinLabel: UI

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var coin: CoinStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text = coin?.name
       // symbolLabel.text = coin?.symbol
        // priceLabel.text = coin?.current_price
        
//        let urlString : String = String((coin?.image)!)
//        let url = URL(string: urlString)
//
//        imageView.downloaded(from: (url)!)
        
        // priceLabel.text = String((coin?.current_price))
        
    }
    
}

