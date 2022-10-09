//
//  ViewController.swift
//  crypto-coin-dashboard
//
//  Created by Oliver Ekwalla on 08/10/2022.
//

import UIKit

class ViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {

    var coins = [CoinStats]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection sections: Int) -> Int{
       return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = coins[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            if let destination = segue.destination as? DetailedViewController {
                destination.coin = coins[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
}

//extension ViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection sections: Int) -> Int{
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.textLabel?.text = coins[indexPath.row].name
//        return cell
//    }
//}

