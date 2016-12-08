//
//  APIManager.swift
//  AC3.2-MidtermElements
//
//  Created by Tyler Newton on 12/8/16.
//  Copyright © 2016 Tyler Newton. All rights reserved.
//

import Foundation

let endpoint = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements"

class ElementsAPIManager {
    static let manager = ElementsAPIManager()
    private init () {}
    
    class func getElements(from endpoint: String, callback: @escaping ([Elements]?) -> Void) {
        
        guard let validEndpoint = URL(string: endpoint) else { return }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: validEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            guard let validData = data else { return }
            
            let elements = ElementsAPIManager.manager.getElements(from: validData)
            callback(elements)
            }.resume()
    }
    
    func getElements(from data: Data) -> [Elements]? {
        do { let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            var allElements = [Elements]()
            
            guard let json = jsonData as? [[String:Any]] else { return nil }
            
            for element in json {
                guard let name = element["name"] as? String,
                    let number = element["number"] as? Int,
                    let symbol = element["symbol"] as? String,
                    let weight = element["weight"] as? Double,
                    let meltingPoint = element["melting_c"] as? Int,
                    let boilingPoint = element["boiling_c"] as? Int else { continue }
                
                allElements.append(Elements(name: name, symbol: symbol, number: number, weight: weight, meltingPoint: meltingPoint, boilingPoint: boilingPoint))
                
            }
            return allElements
        }
            
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
    func elementPost(callback: @escaping([Elements]?) -> ()) {
        var postElements = [Elements]()
        var elementRequest = URLRequest(url: URL(string: endpoint)!)
        elementRequest.httpMethod = "Get"
        
        let headers = [
            "accept":"application/json",
            "content-type": "application/json"
        ]
        
        elementRequest.allHTTPHeaderFields = headers
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: elementRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            do {
                let jsonData: Any = try JSONSerialization.jsonObject(with: data!, options: [])
                
                guard let json = jsonData as? [[String:Any]] else { return }
                
                for element in json {
                    guard let name = element["name"] as? String,
                    let number = element["number"] as? Int,
                    let symbol = element["symbol"] as? String,
                    let weight = element["weight"] as? Double,
                    let meltingPoint = element["melting_c"] as? Int,
                    let boilingPoint = element["boiling_c"] as? Int else { continue }
                    
                    postElements.append(Elements(name: name, symbol: symbol, number: number, weight: weight, meltingPoint: meltingPoint, boilingPoint: boilingPoint))
                }
                return
            }
            catch {
                print(error.localizedDescription)
            }
            callback(postElements)
        }.resume()
    }
    func newElementPost(name: String, number: Int, symbol: String, weight: Double, meltingPoint: Int, boilingPoint: Int) {
        
        var elementRequest = URLRequest(url: URL(string: endpoint)!)
        let headers = [
            "content-type": "application/json"
        ]
        elementRequest.allHTTPHeaderFields = headers
        elementRequest.httpMethod = "POST"
        
        let elementBodyDict: [String:Any] = [
        "name": name,
        "number": number,
        "symbol": symbol,
        "weight": weight,
        "melting_c": meltingPoint,
        "boiling_c": boilingPoint
        ]
        do {
            let elementData: Data = try JSONSerialization.data(withJSONObject: elementBodyDict, options: [])
            elementRequest.httpBody = elementData
        }
        catch {
            print(error)
        }
        let session = URLSession(configuration: .default)
        session.dataTask(with: elementRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil{
                print(error!)
            }
            if response != nil{
                print(response!)
            }
            if data != nil{
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data as Any, options: [])
                    if let validJSON = jsonData {
                        print(validJSON)
                    }
                }
                catch {
                    
                }
            }
            
        }
    }
    
}
