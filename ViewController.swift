//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Alim Gönül on 8.04.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesButton(_ sender: Any) {
        // 1) Request % session --> web sitesine gitmek bir istek yollamak
        // 2) Response and Data --> bu isteği almak datayı almak
        // 3) Parsing --> bu veriyi işlemek
        
        // 1. Kısım
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        let session = URLSession.shared
        
        //Closure
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
                
            }else {
                //2. kısım
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!,options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                         
                        // ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GPB: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let turkis = rates["CAD"] as? Double {
                                    self.tryLabel.text = "TRY: \(turkis)"
                                }
                            }
                        }
                        
                    }catch {
                        print("Error")
                    }
                }
            }
            
        }
        task.resume()
        
    }
    
}

