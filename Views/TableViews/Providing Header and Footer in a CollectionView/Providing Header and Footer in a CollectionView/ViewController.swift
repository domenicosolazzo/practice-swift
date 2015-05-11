//
//  ViewController.swift
//  Providing Header and Footer in a CollectionView
//
//  Created by Domenico Solazzo on 11/05/15.
//  License MIT
//

import UIKit

class ViewController: UICollectionViewController {
    
    let allImages = [
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3")
    ]
    
    func randomImage() -> UIImage{
        let randomNumber = arc4random_uniform(UInt32(allImages.count))
        let randomImage = allImages[Int(randomNumber)]
        return randomImage!
    }
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        
        let nib = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        
        collectionView!.registerNib(nib, forCellWithReuseIdentifier: "cell")
        
        /* Register the header's nib */
        let headerNib = UINib(nibName: "Header", bundle: nil)
        collectionView!.registerNib(headerNib,
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: "header")
        
        /* Register the footer's nib */
        let footerNib = UINib(nibName: "Footer", bundle: nil)
        collectionView!.registerNib(footerNib,
            forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
            withReuseIdentifier: "footer")
        
        collectionView!.backgroundColor = UIColor.whiteColor()
    }
    
    convenience required init(coder aDecoder: NSCoder) {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 80, height: 120);
        flowLayout.scrollDirection = .Vertical
        
        flowLayout.sectionInset =
            UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        self.init(collectionViewLayout: flowLayout)
    }
    
    override func numberOfSectionsInCollectionView(
        collectionView: UICollectionView) -> Int {
            /* Between 3 to 6 sections */
            return Int(3 + arc4random_uniform(4))
    }
    
    override func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            /* Each section has between 10 to 15 cells */
            return Int(10 + arc4random_uniform(6))
    }
    
    override func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
                "cell", forIndexPath: indexPath) as! MyCollectionViewCell
            
            cell.imageViewBackgroundImage.image = randomImage()
            cell.imageViewBackgroundImage.contentMode = .ScaleAspectFit
            
            return cell
            
    }
    
    override func collectionView(collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            
            var identifier = "header"
            if kind == UICollectionElementKindSectionFooter{
                identifier = "footer"
            }
            
            let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                withReuseIdentifier: identifier,
                forIndexPath: indexPath) as! UICollectionReusableView
            
            if kind == UICollectionElementKindSectionHeader{
                if let header = view as? Header{
                    header.label.text = "Section Header \(indexPath.section+1)"
                }
            }
            else if kind == UICollectionElementKindSectionFooter{
                if let footer = view as? Footer{
                    let title = "Section Footer \(indexPath.section+1)"
                    footer.button.setTitle(title, forState: .Normal)
                }
            }
            
            return view
            
    }
}

