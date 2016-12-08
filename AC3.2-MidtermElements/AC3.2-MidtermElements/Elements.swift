//
//  Elements.swift
//  AC3.2-MidtermElements
//
//  Created by Tyler Newton on 12/8/16.
//  Copyright © 2016 Tyler Newton. All rights reserved.
//

import Foundation

class Elements {
    let name: String
    let symbol: String
    let number: Int
    let weight: Double
    let meltingPoint: Int
    let boilingPoint: Int
    
    init(name: String, symbol: String, number: Int, weight: Double, meltingPoint: Int, boilingPoint: Int) {
        
    self.name = name
    self.symbol = symbol
    self.number = number
    self.weight = weight
    self.meltingPoint = meltingPoint
    self.boilingPoint = boilingPoint
        
    }
}
