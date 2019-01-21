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
        let url = URL(string: "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=3c86987d6b1400cb3782c054e1949718")
        
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if error != nil {
                print("error")
            }
            else {
                if let urlContent = data {
                    
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        print(jsonResult)
                        
                        if let description = jsonResult["weather"]??[0]["description"] as? String {
                            DispatchQueue.main.sync(execute: {
                                
                                self.resultText = description
                                
                            })
                        }
                        
                    } catch {
                        print("JSON Processing failed")
                    }
                    
                }
            }
        }
        task.resume()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

