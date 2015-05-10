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
}

