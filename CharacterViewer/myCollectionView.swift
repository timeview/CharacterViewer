//
//  myCollectionView.swift
//  CharacterViewer
//
//  Created by ORLANDO RIVERA on 10/14/17.
//  Copyright © 2017 DigitalSummit. All rights reserved.
//

import UIKit

class myCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // http://api.duckduckgo.com/?q=simpsons+characters&format=json
    // http://api.duckduckgo.com/?q=seinfeld+characters&format=json
    var baseUrl:String? = nil
    var detailViewController: DetailViewController? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var columnChangerButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    
    var results = [CharData]()
    {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBAction func TV_Show(_ sender: Any) {
        if baseUrl == "http://api.duckduckgo.com/?q=simpsons+characters&format=json" {
            baseUrl = "http://api.duckduckgo.com/?q=seinfeld+characters&format=json"
        } else {
            baseUrl = "http://api.duckduckgo.com/?q=simpsons+characters&format=json"
        }
        CharAPI.shared.fetchResults(for: baseUrl!) { items in
            self.results = items
        }
       //     self.collectionView.reloadData()
       //     gridLayout.invalidateLayout()
    }
    
    var gridLayout: GridLayout!
    lazy var listLayout: ListLayout = {
        var listLayout = ListLayout(itemHeight: 180)
        return listLayout
    }()
    
    
    @IBAction func changeNumberOfColumns() {
        if gridLayout.numberOfColumns == 3 {
            gridLayout.numberOfColumns = 2
        } else {
            gridLayout.numberOfColumns = 3
        }
        CharAPI.shared.fetchResults(for: baseUrl!) { items in
            self.results = items
        }
        
        gridLayout.invalidateLayout()  // this triggers the update for the Grid change of Columns
    }
    
    @IBAction func changeLayout() {
        if collectionView.collectionViewLayout == gridLayout {
            // list layout
            columnChangerButton.isEnabled = false
            UIView.animate(withDuration: 0.1, animations: {
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(self.listLayout, animated: false)
                
            })
        } else {
            // grid layout
            columnChangerButton.isEnabled = true
            UIView.animate(withDuration: 0.1, animations: {
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(self.gridLayout, animated: false)
            })
        }
        collectionView.reloadData()
    }
    
    func whatShow() {
        let alert = UIAlertController(title: "What Show do you want to explore?", message: "Pick from two options below", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Simpsons", style: UIAlertActionStyle.default, handler: { (action) in
            self.baseUrl = "http://api.duckduckgo.com/?q=simpsons+characters&format=json"
            CharAPI.shared.fetchResults(for: self.baseUrl!) { items in
                self.results = items
            }

            alert.dismiss(animated: true, completion: nil)
        }))
 
        alert.addAction(UIAlertAction(title: "Seinfeld", style: UIAlertActionStyle.default, handler: { (action) in
            self.baseUrl = "http://api.duckduckgo.com/?q=seinfeld+characters&format=json"
            CharAPI.shared.fetchResults(for: self.baseUrl!) { items in
                self.results = items
            }

            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: view methods
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        gridLayout = GridLayout(numberOfColumns: 3)
        collectionView.collectionViewLayout = gridLayout
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.primaryOverlay // for overlay Detail will be  hidden half
        self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.allVisible  // detail will fit into right
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (baseUrl == nil)  {
            whatShow()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        collectionView.reloadData()
    }
    
    
    // MARK: collectionView methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (results.count)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellName: String

        if (results.isEmpty){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myGridCell
            cell.listLabel.text = " \(indexPath.row)"
            print("No Data - index = \(indexPath.row)")
         return cell
        }
        
        let item = results[(indexPath.row)]
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as Any
        
        if collectionView.collectionViewLayout == gridLayout {
            // Grid layout
            cellName = "cell"

            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! myGridCell

            (cell as! myGridCell).listImage?.imageFrom(url: item.artworkUrl!)
            (cell as! myGridCell).listLabel.text = item.charName

            return cell as! myGridCell
        } else {
            // List layout
            cellName = "cellList"
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! myListCell
            (cell as! myListCell).listImage?.imageFrom(url: item.artworkUrl!)
            (cell as! myListCell).listLabel.text = item.charName

            return cell as! myListCell

        }

    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetail", sender: indexPath.row) // this calls prepare()
        
    }
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
        var detailData:CharData
        if segue.identifier == "showDetail" {

            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            let index = sender as! Int
            
            detailData = results[index]
            controller.detailCharData = detailData

            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true

        }
    }
    
    
}
