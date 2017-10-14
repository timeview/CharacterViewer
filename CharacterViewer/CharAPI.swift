//
//  CharAPI.swift
//  CharacterViewer
//
//  Created by ORLANDO RIVERA on 10/14/17.
//  Copyright © 2017 DigitalSummit. All rights reserved.
//

import UIKit

typealias JSONDict = [String:Any]
// base API services to handle any base url with same json struture 
class CharAPI: NSObject {
    
    static let shared = CharAPI()
    // http://api.duckduckgo.com/?q=simpsons+characters&format=json
    // http://api.duckduckgo.com/?q=seinfeld+characters&format=json

    func fetchResults(for CharUrl: String, completion: @escaping ([CharData]) -> ()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        if let url = URL(string: CharUrl) {
            
            URLSession.shared.invalidateAndCancel()
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    print(error.debugDescription)
                    return
                }
                guard let data = data else {
                    print("Data is empty")
                    return
                }
                
                var items = [CharData]()
                
                guard let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONDict else { return }
                guard let json = jsonDict,
                    let results = json["RelatedTopics"] as? [JSONDict] else { return }

                print("results count = \(results.count)")
                var charName = ""
                
                for result in results {

                    if let _ = result["FirstURL"] as? String ,
                        let artworkUrlStrTemp = result["Icon"] as? [String:String],
                        let artworkUrlStr = artworkUrlStrTemp["URL"]
                    {
                        
                        var artworkUrl = URL(string: artworkUrlStr)
                        if artworkUrl == nil {  // temp image url - show have internal default
                            artworkUrl = URL(string: "https://i.pinimg.com/736x/d7/8f/4f/d78f4f6079dc0eef29995cded9afd0e9.jpg")
                        }
                        
                        var myStringArr:Array<Any>
                        var descTemp:String = "No data"
                        if let backStory = result["Text"] as? String { // Need to split name out of text
                            myStringArr = backStory.components(separatedBy: "-")
                            charName = myStringArr[0] as! String
                            var rrtemp = ""
                            for i in 1..<myStringArr.count {  // need to concatenate backStory minus Name
                                rrtemp += String(describing: myStringArr[i])
                            }

                            descTemp = rrtemp
                        }
                        
                        var item = CharData(charName: charName, artworkUrl: artworkUrl!)
                        item.backStory = descTemp

                        items.append(item)
                    }
                }
                
                DispatchQueue.main.async(execute: {
                    completion(items)
                })
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            task.resume()
        }
    }
    
}

