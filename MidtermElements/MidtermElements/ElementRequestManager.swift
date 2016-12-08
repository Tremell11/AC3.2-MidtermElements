//
//  ElementRequestManager.swift
//  MidtermElements
//
//  Created by Tyler Newton on 12/8/16.
//  Copyright © 2016 Tyler Newton. All rights reserved.
//

import Foundation

class ElementRequestManager {
    static let manager = ElementRequestManager()
    
    private init () {}
    
    func elementData(_ endpoint: String, callback: @escaping (Data?) -> Void) {
        
        guard let validEndpoint = URL(string: endpoint) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: validEndpoint) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("Error \(error)!")
            }
            guard let validData = data else { return }
            callback(validData)
            }.resume()
    }
}
