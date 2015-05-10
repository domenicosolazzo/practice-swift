//
//  ViewController.swift
//  Providing basic content to a CollectionView
//
//  Created by Domenico Solazzo on 10/05/15.
//  License MIT
//

import UIKit

class ViewController: UICollectionViewController {
    // Section colors
    let allSectionColors = [
        UIColor.redColor(),
        UIColor.greenColor(),
        UIColor.blueColor()
    ]
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        
        
        self.collectionView?.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "Cell")
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
    }
    
    convenience required init(coder aDecoder: NSCoder) {
        var flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 80, height: 120);
        flowLayout.scrollDirection = .Vertical
        
        flowLayout.sectionInset =
            UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        self.init(collectionViewLayout: flowLayout)
    }
    
    // Number of sections in the collection view
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return allSectionColors.count
    }
    
    // Number of items in each section
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         /* Generate between 20 to 40 cells for each section */
        return Int(arc4random_uniform(21)) + 20
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            "cell",
            forIndexPath: indexPath) as! UICollectionViewCell
        
        cell.backgroundColor = allSectionColors[indexPath.section]
        
        return cell
    }
}

