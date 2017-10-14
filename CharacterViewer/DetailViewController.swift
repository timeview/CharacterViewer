//
//  DetailViewController.swift
//  CharacterViewer
//
//  Created by ORLANDO RIVERA on 10/14/17.
//  Copyright © 2017 DigitalSummit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
        var detailCharData: CharData!

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var CharImage: UIImageView!

    @IBOutlet weak var CharBackStory: UILabel!
    @IBOutlet weak var CharName: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        if detailCharData != nil {
           CharName.text = detailCharData.charName
           CharImage.imageFrom(url: detailCharData.artworkUrl!)
           CharBackStory.text = detailCharData.backStory
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

