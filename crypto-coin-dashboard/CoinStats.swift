//
//  Coin.swift
//  crypto-coin-dashboard
//
//  Created by Oliver Ekwalla on 08/10/2022.
//

import UIKit

struct CoinStats: Decodable{
    let name: String
    let symbol : String
    let image : String
    let current_price: Double
    let price_change_24h: Double
    
}

