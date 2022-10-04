//
//  ViewController.swift
//  ApiCall
//
//  Created by Berkan Korkmaz on 25.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var amountTxt: UITextField!
    @IBOutlet weak var toTxt: UITextField!
    @IBOutlet weak var fromTxt: UITextField!
    
    let apiKey = "ttgsCPUQ9WAzRQU42J4AEnJbHxJxciFQ"
    var fromText = ""
    var toText = ""
    var amountText = ""
    
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

}
@IBAction func convertAction(_ sender: Any) {
    
    print("ButtonPressed")
    
        fromText = fromTxt.text!.uppercased()
        toText = toTxt.text!.uppercased()
        amountText = amountTxt.text!
        
        let queryItems = [URLQueryItem(name: "apikey", value: apiKey), URLQueryItem(name: "from", value: self.fromText), URLQueryItem(name: "to", value: toText), URLQueryItem(name: "amount", value: amountText)]
        var urlComps = URLComponents(string: "https://api.apilayer.com/fixer/convert")!
        urlComps.queryItems = queryItems
        let url = urlComps.url!
        
        
        //let url = URL(string: "https://api.apilayer.com/fixer/convert?apikey=ttgsCPUQ9WAzRQU42J4AEnJbHxJxciFQ&from=\(fromTxt.text!)&to=\(toTxt.text!)&amount=\(amountTxt.text!)")
        
        let session = URLSession.shared
        
        //Closure
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else{
                // 2.
                if data != nil{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //ASYNC
                        
                        DispatchQueue.main.async{
                            
                            if let result = jsonResponse["result"] as? Double {
                                self.resultLabel.text = "Result: \(result)"
                            }
                        }
                    }catch{
                        print("error")
                    }
                    
                }
                
                
            }
        }
        
        task.resume()
        
        
        
    }
    
}

