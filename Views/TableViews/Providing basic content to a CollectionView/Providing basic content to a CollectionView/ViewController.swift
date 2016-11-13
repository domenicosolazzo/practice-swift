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
        UIColor.red,
        UIColor.green,
        UIColor.blue
    ]
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        
        
        collectionView!.register(UICollectionViewCell.classForCoder(),
            forCellWithReuseIdentifier: "cell")
        
        collectionView!.backgroundColor = UIColor.white
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 80, height: 120);
        flowLayout.scrollDirection = .vertical
        
        flowLayout.sectionInset =
            UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        self.init(collectionViewLayout: flowLayout)
    }
    
    // Number of sections in the collection view
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allSectionColors.count
    }
    
    // Number of items in each section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         /* Generate between 20 to 40 cells for each section */
        return Int(arc4random_uniform(21)) + 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath) 
        
        cell.backgroundColor = allSectionColors[(indexPath as NSIndexPath).section]
        
        return cell
    }
}

