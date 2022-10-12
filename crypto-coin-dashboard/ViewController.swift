//
//  ViewController.swift
//  crypto-coin-dashboard
//
//  Created by Oliver Ekwalla on 08/10/2022.
//

import UIKit

class ViewController:  UIViewController {

    var coins = [CoinStats]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegate()
        // set Row height
       // tableView.rowHeight = 1
        // Do any additional setup after loading the view.
        downloadJSON {
            self.tableView?.reloadData()
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()){
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=true&price_change_percentage=7d")
        
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            if error == nil {
                do{
                    self.coins = try JSONDecoder().decode([CoinStats].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("Error")
                }
            }
        }.resume()
    }
    
    func setTableViewDelegate(){
        // Data Source
        tableView?.delegate = self
        tableView?.dataSource = self
        // Register the cell
        //tableView?.register(CryptoTableViewCell.self, forCellReuseIdentifier: "CryptoTableViewCell")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            if let destination = segue.destination as? DetailedViewController {
                destination.coin = coins[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
}


// Where should this auxilliary function go ?
// An extension on Double

func preciseRound(_ number : Double, _ precision: String ) -> Double {
    switch precision{
    case "tenths":
        return number
    case "hundrenths":
        return Double(round(100000000 * number) / 100000000)
    case "thousandth":
        return Double(round(1000 * number) / 1000)
    default:
        return number
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection sections: Int) -> Int{
       return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CryptoTableViewCell.self)", for: indexPath) as? CryptoTableViewCell else {
            fatalError("Error")
        }
        
        let coin = coins[indexPath.row]
       
        cell.symbolLabel?.text = coin.symbol.uppercased()
        cell.nameLabel?.text = coin.name
        cell.priceLabel?.text = String((coin.current_price))
        
        let urlString : String = String((coin.image))
        let url = URL(string: urlString)
        
        cell.imageLabel?.downloaded(from: (url)!)
        
        //NumberFormatter.RoundingMode(rawValue: <#T##UInt#>)
        //cell.price_change_24hLabel?.text = String(preciseRound(coin.price_change_24h, "hundrenths"))
        
        cell.price_change_percentage_24hLabel?.text = "\(coin.price_change_percentage_24h)%"
        cell.price_change_percentage_24hLabel.textColor = coin.price_change_percentage_24h < 0 ? .red : .green
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showDetails", sender: self)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
