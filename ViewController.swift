//
//  ViewController.swift
//  Weather App
//
//  Created by salman siraj on 1/9/19.
//  Copyright © 2019 salman siraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var resultText: UILabel!
    
    @IBAction func BtnPressed(_ sender: Any) {
        let url = URL(string: "https://weather.com/weather/today/l/US" + inputText.text! + "0996:1:US")!
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var message = ""
            
            if error != nil {
                print(error!)
            }
            else {
                if let unwrapData = data {
                    // Create NSString
                    let dataString = NSString(data: unwrapData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeperator = "<div class=\"today_nowcard-temp\"><span class="
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeperator) {
                        
                        if contentArray.count > 0 {
                            
                            stringSeperator = "<sup>°</sup></span></div><div class=\"today_"
                            let newContentArray = contentArray[1].components(separatedBy: stringSeperator)
                            
                            if newContentArray.count > 0 {
                                
                                message = newContentArray[0]
                                message = "Weather Forecast: " + newContentArray[0].suffix(2) + " Degrees"
//                                print(message)
                            }
                        }
                        
                    }
                    
                }
                
            }
//            print(message)
            DispatchQueue.main.sync(execute: {
                self.resultText.text = message
            })
        }
        task.resume()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

