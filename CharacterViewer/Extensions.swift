//
//  Extensions.swift
//  CharacterViewer
//
//  Created by ORLANDO RIVERA on 10/14/17.
//  Copyright © 2017 DigitalSummit. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    public func imageFrom(url: URL) {
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = imageFromCache
            return
        } else {
            self.image = UIImage()
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error.debugDescription)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                imageCache.setObject(image!, forKey: url.absoluteString as NSString)
                self.image = image
            })
        }).resume()
    }}

