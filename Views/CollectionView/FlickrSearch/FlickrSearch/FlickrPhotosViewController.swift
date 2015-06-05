//
//  FlickrPhotosViewController.swift
//  FlickrSearch
//
//  Created by Domenico on 03/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit

let reuseIdentifier = "FlickrCell"

extension FlickrPhotosViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // 1
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        flickr.searchFlickrForTerm(textField.text) {
            results, error in
            
            //2
            activityIndicator.removeFromSuperview()
            if error != nil {
                println("Error searching : \(error)")
            }
            
            if results != nil {
                //3
                println("Found \(results!.searchResults.count) matching \(results!.searchTerm)")
                self.searches.insert(results!, atIndex: 0)
                
                //4
                self.collectionView?.reloadData()
            }
        }
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}

extension FlickrPhotosViewController : UICollectionViewDataSource {
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return searches.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FlickrPhotoCell
        
        let flickrPhoto = photoForIndexPath(indexPath)
        cell.backgroundColor = UIColor.blackColor()
        
        cell.imageView.image = flickrPhoto.thumbnail
        
        return cell
    }
}

extension FlickrPhotosViewController : UICollectionViewDelegateFlowLayout {
    /**
    *  It is responsible for telling the layout the size of a given cell. 
    *  To do this, you must first determine which FlickrPhoto you are looking at, since each photo could
    *  have different dimensions.
    */
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            let flickrPhoto =  photoForIndexPath(indexPath)
            
            if var size = flickrPhoto.thumbnail?.size {
                size.width += 10
                size.height += 10
                return size
            }
            return CGSize(width: 20, height: 20)
    }
    
    // It returns the spacing between the cells, headers, and footers.
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
            //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView =
            collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                withReuseIdentifier: "FlickrPhotoHeaderView",
                forIndexPath: indexPath)
                as! FlickrPhotoHeaderView
            headerView.label.text = searches[indexPath.section].searchTerm
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
    // Selected cell
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if largePhotoIndexPath == indexPath{
            largePhotoIndexPath = nil
        }else{
            largePhotoIndexPath = indexPath
        }
        return false
    }
}

class FlickrPhotosViewController: UICollectionViewController {
    private var searches = [FlickrSearchResults]() // List of searches
    private let flickr = Flickr() // Singleton
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Keep track of the tapped cell
    var largePhotoIndexPath: NSIndexPath? {
        didSet{
            var indexPaths = [NSIndexPath]()
            if self.largePhotoIndexPath != nil{
                indexPaths.append(self.largePhotoIndexPath!)
            }
            
            if oldValue != nil{
                indexPaths.append(oldValue!)
            }
            
            // Animate any changes to the collection view performed inside the block
            collectionView?.performBatchUpdates({
                self.collectionView?.reloadItemsAtIndexPaths(indexPaths)
                return
                }){ completed in
                    if self.largePhotoIndexPath != nil{
                        // Scroll the enlarged cell to the middle of the screen
                        self.collectionView?.scrollToItemAtIndexPath(
                            self.largePhotoIndexPath!,
                            atScrollPosition: UICollectionViewScrollPosition.CenteredVertically,
                            animated: true
                        )
                    }
                }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //- MARK: Flickr
    
    // Convenience method that will get a specific photo related to 
    // an index path in your collection view.
    func photoForIndexPath(indexPath: NSIndexPath) -> FlickrPhoto {
        return searches[indexPath.section].searchResults[indexPath.row]
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    
}
