//
//  DetailViewController.swift
//  MidtermElements
//
//  Created by Tyler Newton on 12/8/16.
//  Copyright © 2016 Tyler Newton. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var element: Element!
    
    @IBOutlet weak var elementImage: UIImageView!
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    @IBOutlet weak var nameNumberWeightLabel: UILabel!
    
    @IBOutlet weak var meltingPointLabel: UILabel!
    
    @IBOutlet weak var boilingPointLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
     // MARK: - Navigation

    
    // So the time ended now but I was about to set postEntry to a functional object within the view so that it would stop returning nil. I am about to commit now but I will continue to work on it so that I can make this button functional.
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        postEntry()
    }
    func postEntry() {
        var request = URLRequest(url: URL(string: "https://api.fieldbook.com/v1/584895a3d9fa900300f1cd86/contacts")!)
        
        request.httpMethod = "POST"
        
        // The below are different ways of getting the same stuff done
        request.addValue("application/json" /* value */, forHTTPHeaderField: "Accept") /* key */
        
        let headers = [
            "content-type": "application/json",
            "authorization": "Basic a2V5LTE6UExtSVR2NzRXcjYzZ1RVMnRwRDg=",
            "cache-control": "no-cache",
            //            "postman-token": "395019a8-b41c-69ad-bd9d-c0eb14dc3e33"
        ]
        
        request.allHTTPHeaderFields = headers
        
        //
        
        
        let parameters = [
            "my_name": "Tyler Newton",
            "favorite_element": "\(element.name)"
        ]
        
        do {
            let postData: Data = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            request.httpBody = postData
            
        }
        catch {
            print("Error converting to data")
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if (error != nil) {
                print(error!)
            }
            else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
            }
            }.resume()
    }
    
}
