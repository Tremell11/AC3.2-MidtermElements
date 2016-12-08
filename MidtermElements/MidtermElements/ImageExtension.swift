//
//  ImageExtension.swift
//  MidtermElements
//
//  Created by Tyler Newton on 12/8/16.
//  Copyright © 2016 Tyler Newton. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadImage(from imageURLString: String, with cache: NSCache<NSString, UIImage>){
        if let image = cache.object(forKey: imageURLString as NSString){
            self.image = image
            return
        }
        guard let validURL = URL(string: imageURLString) else { return }
        
        var imageData: Data?
        
        DispatchQueue.global(qos: .background).async {
            do {
                imageData = try Data(contentsOf: validURL)
            }
            catch {
                print(error.localizedDescription)
            }
            guard let data = imageData,
                let image = UIImage(data: data) else { return }
            
            cache.setObject(image, forKey: imageURLString as NSString)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
