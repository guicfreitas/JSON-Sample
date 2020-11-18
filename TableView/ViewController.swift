//
//  ViewController.swift
//  TableView
//
//  Created by João Guilherme on 10/08/20.
//  Copyright © 2020 João Guilherme. All rights reserved.
//

import UIKit

//MARK:


class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    var fetchedCrypto = [Crypto]()
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        parseData()
    }
    
    func parseData() {
        fetchedCrypto = []
        
        
        let url = "https://braziliex.com/api/v1/public/ticker"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("error")
            } else {
                do {
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String:Any]
                    //print(arrayFetched)
                    
                    for (_, eachCrypto) in fetchedData {
                        let eachKey = eachCrypto as! [String: Any]
                        let mercado = eachKey["market"] as? String
                        let valor = eachKey["last"] as? Double
                        
                        
                        
                        if(mercado != nil || valor != nil) {
                            //print(mercado!,valor!)
                            self.fetchedCrypto.append(Crypto(mercado: mercado!, valor: valor!))
                        }
                        
                        
                        
                        //print(fetchedCrypto)
                    }
                    self.tableView.reloadData()
                }
                    
                catch {
                    print("catch error")
                }
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCrypto.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //parseData()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = fetchedCrypto[indexPath.row].mercado
        if(fetchedCrypto[indexPath.row].valor >= 1) {
            cell?.detailTextLabel?.text = String(fetchedCrypto[indexPath.row].valor)
            cell?.detailTextLabel?.textColor = .green
        }else {
            cell?.detailTextLabel?.text = String(fetchedCrypto[indexPath.row].valor)
            cell?.detailTextLabel?.textColor = .red
        }
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Nome:\(fetchedCrypto[indexPath.row].mercado), Valor: \(fetchedCrypto[indexPath.row].valor)")
    }
}







