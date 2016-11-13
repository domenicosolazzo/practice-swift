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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 1
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        flickr.searchFlickrForTerm(textField.text!) {
            results, error in
            
            //2
            activityIndicator.removeFromSuperview()
            if error != nil {
                print("Error searching : \(error)")
            }
            
            if results != nil {
                //3
                print("Found \(results!.searchResults.count) matching \(results!.searchTerm)")
                self.searches.insert(results!, at: 0)
                
                //4
                self.collectionView?.reloadData()
            }
        }
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}

extension FlickrPhotosViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searches.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FlickrPhotoCell
        
        let flickrPhoto = photoForIndexPath(indexPath)
        
        cell.activityIndicator.stopAnimating()
        
        if indexPath != largePhotoIndexPath {
            cell.imageView.image = flickrPhoto.thumbnail
            return cell
        }
        
        if flickrPhoto.largeImage != nil {
            cell.imageView.image = flickrPhoto.largeImage
            return cell
        }
        
        cell.imageView.image = flickrPhoto.thumbnail
        cell.activityIndicator.startAnimating()
        
        flickrPhoto.loadLargeImage {
            loadedFlickrPhoto, error in
            
            cell.activityIndicator.stopAnimating()
            
            if error != nil {
                return
            }
            
            if loadedFlickrPhoto.largeImage == nil {
                return
            }
            
            if indexPath == self.largePhotoIndexPath {
                if let cell = collectionView.cellForItem(at: indexPath) as? FlickrPhotoCell {
                    cell.imageView.image = loadedFlickrPhoto.largeImage
                }
            }
        }
        
        return cell
    }
}

extension FlickrPhotosViewController : UICollectionViewDelegateFlowLayout {
    /**
    *  It is responsible for telling the layout the size of a given cell. 
    *  To do this, you must first determine which FlickrPhoto you are looking at, since each photo could
    *  have different dimensions.
    */
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let flickrPhoto =  photoForIndexPath(indexPath)
            // Larged tapped photo  
            if indexPath == largePhotoIndexPath {
                var size = collectionView.bounds.size
                size.height -= topLayoutGuide.length
                size.height -= (sectionInsets.top + sectionInsets.right)
                size.width -= (sectionInsets.left + sectionInsets.right)
                return flickrPhoto.sizeToFillWidthOfSize(size)
            }
            
            if var size = flickrPhoto.thumbnail?.size {
                size.width += 10
                size.height += 10
                return size
            }
            return CGSize(width: 20, height: 20)
    }
    
    // It returns the spacing between the cells, headers, and footers.
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView =
            collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                withReuseIdentifier: "FlickrPhotoHeaderView",
                for: indexPath)
                as! FlickrPhotoHeaderView
            headerView.label.text = searches[(indexPath as NSIndexPath).section].searchTerm
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
    // Selected cell
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if sharing {
            return true
        }
        
        if largePhotoIndexPath == indexPath{
            largePhotoIndexPath = nil
        }else{
            largePhotoIndexPath = indexPath
        }
        return false
    }
    // Add photos in sharing mode
    override func collectionView(_ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            if sharing {
                let photo = photoForIndexPath(indexPath)
                selectedPhotos.append(photo)
                updateSharedPhotoCount()
            }
    }
    
    // Remove photos in sharing mode
    override func collectionView(_ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath) {
            if sharing {
                if let foundIndex = selectedPhotos.index(of: photoForIndexPath(indexPath)) {
                    selectedPhotos.remove(at: foundIndex)
                    updateSharedPhotoCount()
                }
            }
    }
}

class FlickrPhotosViewController: UICollectionViewController {
    fileprivate var searches = [FlickrSearchResults]() // List of searches
    fileprivate let flickr = Flickr() // Singleton
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    fileprivate var selectedPhotos = [FlickrPhoto]()
    fileprivate let shareTextLabel = UILabel()
    
    func updateSharedPhotoCount() {
        shareTextLabel.textColor = themeColor
        shareTextLabel.text = "\(selectedPhotos.count) photos selected"
        shareTextLabel.sizeToFit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Keep track of the tapped cell
    var largePhotoIndexPath: IndexPath? {
        didSet{
            var indexPaths = [IndexPath]()
            if self.largePhotoIndexPath != nil{
                indexPaths.append(self.largePhotoIndexPath!)
            }
            
            if oldValue != nil{
                indexPaths.append(oldValue!)
            }
            
            // Animate any changes to the collection view performed inside the block
            collectionView?.performBatchUpdates({
                self.collectionView?.reloadItems(at: indexPaths)
                return
                }){ completed in
                    if self.largePhotoIndexPath != nil{
                        // Scroll the enlarged cell to the middle of the screen
                        self.collectionView?.scrollToItem(
                            at: self.largePhotoIndexPath!,
                            at: UICollectionViewScrollPosition.centeredVertically,
                            animated: true
                        )
                    }
                }
        }
        
    }
    
    var sharing : Bool = false {
        didSet {
            collectionView?.allowsMultipleSelection = sharing
            collectionView?.selectItem(at: nil, animated: true, scrollPosition: UICollectionViewScrollPosition())
            selectedPhotos.removeAll(keepingCapacity: false)
            if sharing && largePhotoIndexPath != nil {
                largePhotoIndexPath = nil
            }
            
            let shareButton =
            self.navigationItem.rightBarButtonItems?.first! as UIBarButtonItem!
            if let share = shareButton{
                if sharing {
                    updateSharedPhotoCount()
                    let sharingDetailItem = UIBarButtonItem(customView: shareTextLabel)
                    navigationItem.setRightBarButtonItems([shareButton!,sharingDetailItem], animated: true)
                }
                else {
                    navigationItem.setRightBarButtonItems([shareButton!], animated: true)
                }
            }
            
        }
    }
    
    @IBAction func share(_ sender: AnyObject) {
        if searches.isEmpty {
            return
        }
        
        if !selectedPhotos.isEmpty {
            var imageArray = [UIImage]()
            for photo in self.selectedPhotos {
                imageArray.append(photo.thumbnail!);
            }
            
            let shareScreen = UIActivityViewController(activityItems: imageArray, applicationActivities: nil)
            //let popover = UIPopoverController(contentViewController: shareScreen)
            self.present(shareScreen, animated: true, completion: nil)
            //popover.presentPopoverFromBarButtonItem(self.navigationItem.rightBarButtonItems!.first as! UIBarButtonItem,
               // permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
        
        sharing = !sharing
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //- MARK: Flickr
    
    // Convenience method that will get a specific photo related to 
    // an index path in your collection view.
    func photoForIndexPath(_ indexPath: IndexPath) -> FlickrPhoto {
        return searches[(indexPath as NSIndexPath).section].searchResults[(indexPath as NSIndexPath).row]
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
