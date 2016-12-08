//
//  Element.swift
//  MidtermElements
//
//  Created by Tyler Newton on 12/8/16.
//  Copyright © 2016 Tyler Newton. All rights reserved.
//

import Foundation

enum incaseOFError: Error {
    case response, name, number, symbol, weight, meltingPoint, boilingPoint
}

class Element {
    let name: String
    let number: Int
    let symbol: String
    let weight: Double
    let meltingPoint: Int
    let boilingPoint: Int
    
    init(name: String, number: Int, symbol: String, weight: Double, meltingPoint: Int, boilingPoint: Int) {
        self.name = name
        self.number = number
        self.symbol = symbol
        self.weight = weight
        self.meltingPoint = meltingPoint
        self.boilingPoint = boilingPoint
    }
    
    static func getElements(from data: Data?) -> [Element]? {
        var allElements: [Element]? = []
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
            
            guard let json = jsonData as? [[String:Any]] else { return nil }
            
            for element in json {
                guard let name = element["name"] as? String,
                    let number = element["number"] as? Int,
                    let symbol = element["symbol"] as? String,
                    let weight = element["weight"] as? Double,
                    let meltingPoint = element["melting_c"] as? Int,
                    let boilingPoint = element["boiling_c"] as? Int else { continue }
                
                allElements?.append(Element(name: name, number: number, symbol: symbol, weight: weight, meltingPoint: meltingPoint, boilingPoint: boilingPoint))
            }
            
        }
        catch {
            print(error)
        }
        return allElements
    }
}
