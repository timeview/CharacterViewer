//
//  CharData.swift
//  CharacterViewer
//
//  Created by ORLANDO RIVERA on 10/14/17.
//  Copyright © 2017 DigitalSummit. All rights reserved.
//
// base Data Model
import Foundation

struct CharData {
    var charName: String?
    var artworkUrl: URL?
    var backStory: String?
    
    init(charName: String, artworkUrl: URL) {
        self.charName = charName
        self.artworkUrl = artworkUrl
    }
}
