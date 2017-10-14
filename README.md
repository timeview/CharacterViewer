# CharacterViewer - By Orlando Rivera
I only had a few hours over the weekend to work on this project because of other commitments. This is my unfinished version of the Character viewer Demo App. I did not use any external frameworks. 

•	I pulled together a basic working Character viewer app for both the Simpsons & Seinfeld TV shows using https://api.duckduckgo.com/api web services. 
•	Each show has its own unique parameters for its web services. 
•	I did put in a few XCTests methods & UI tests.  Please note a search could be included using .filter on the json data.

In general this code needs refactoring and consolidation of files.   Below are some notes on the approach I took to create a cool project.

1)	Pulled data from the REST API in json format.
I created a class called “CharAPI.swift” base API services to handle the two base urls with same json structure (CharData.swift). The json for both Simpsons and Seinfeld are the same.

2)	Display the resulting data as a list using collections (not tables).
See item 3 since the collection view handles both lists and columns.

3)	Selecting an item in the List or Grid should load a detail view including the image, title, and description of the character.
By using the collectionview.collectionViewLayout , I was able to configure the layout for both List and the grid view (did not need tableview). In addition, I added both a two and three column view. I also extracted the name of the character for the text body using myStringArr = backStory.components(separatedBy: "-") since this not defined as a separate element.

4)	On a tablet, the list & detail view should show on the same screen in a landscape format.  On the iPhone, the detail view should fill the screen.
This is basically a Master-Detail flow using a splitViewController. The app is a universal app and works on both iPads and iPhones of varying sizes.



The following are the major files used by the Character viewer Demo App.

1.	AppDelegate.swift: The additional code added was to support splitViewController (protocols and functions).

2.	myCollectionView.swift:  This is the main view controller that handles collectionView & layouts, button actions for the List, Columns (2 or 3), switching between “TV Shows”,  and Segues to the detail pages. Some of this could be moved to another manager class.

3.	DetailViewController.swift: This handles displaying of detail pages.

4.	CharData.swift: This is the basic data model for the Json web services.

5.	CharAPI.swift: This class holds the major fetchResults method which gets the json data for the various web services for the app.

6.	Extensions.swift: This was going to have more helper extensions (would be part of a refactoring) but at this point only has one extension to UIImageView that allows us to load from a url or local cache.

7.	GridLayout.swift & ListLayout.swift: Are both special classes that support UICollectionViewFlowLayout.

8.	Info.plist: I needed to add “App Transport Security Settings” to allow access to web services since we did not have a real SSL certificate etc.

9.	CharacterViewerTests.swift & CharacterViewerUITests.swift: A few basic XC & UI Tests have been included.

Please note that I do not consider this production code but a quick demo of an approach to using collections views for different presentation layouts/views of web services.  

Thank you, Orlando Rivera




