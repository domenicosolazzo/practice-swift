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
        
        collectionView!.register(nib, forCellWithReuseIdentifier: "cell")
        
        /* Register the header's nib */
        let headerNib = UINib(nibName: "Header", bundle: nil)
        collectionView!.register(headerNib,
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: "header")
        
        /* Register the footer's nib */
        let footerNib = UINib(nibName: "Footer", bundle: nil)
        collectionView!.register(footerNib,
            forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
            withReuseIdentifier: "footer")
        
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
        
        /* Set the reference size for the header and the footer views */
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 50)
        flowLayout.footerReferenceSize = CGSize(width: 300, height: 50)
        
        self.init(collectionViewLayout: flowLayout)
    }
    
    override func numberOfSections(
        in collectionView: UICollectionView) -> Int {
            /* Between 3 to 6 sections */
            return Int(3 + arc4random_uniform(4))
    }
    
    override func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            /* Each section has between 10 to 15 cells */
            return Int(10 + arc4random_uniform(6))
    }
    
    override func collectionView(_ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
            
            cell.imageViewBackgroundImage.image = randomImage()
            cell.imageViewBackgroundImage.contentMode = .scaleAspectFit
            
            return cell
            
    }
    
    override func collectionView(_ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {
            
            var identifier = "header"
            if kind == UICollectionElementKindSectionFooter{
                identifier = "footer"
            }
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                withReuseIdentifier: identifier,
                for: indexPath) 
            
            if kind == UICollectionElementKindSectionHeader{
                if let header = view as? Header{
                    header.label.text = "Section Header \((indexPath as NSIndexPath).section+1)"
                }
            }
            else if kind == UICollectionElementKindSectionFooter{
                if let footer = view as? Footer{
                    let title = "Section Footer \((indexPath as NSIndexPath).section+1)"
                    footer.button.setTitle(title, for: UIControlState())
                }
            }
            
            return view
            
    }
}

