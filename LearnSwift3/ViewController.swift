//
//  ViewController.swift
//  LearnSwift3
//
//  Created by Vijayalakshmi Pulivarthi on 29/11/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var  cardTypeArray : NSMutableArray?
    var  factionArray : NSMutableArray?
    var  rarityArray : NSMutableArray?
    var  imageArray : NSMutableArray?
    var  sectionHeaderArray: NSMutableArray?
    var cardsArray = [Cards]()
    var getarrays: NSArray?
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let nib = UINib(nibName: "CollectionSectionHeaderView", bundle: nil)
//        collectionView.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionSectionHeaderView")
        registerNibs()
        fetchAllCards()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    
    
    // API CALL
    func fetchAllCards() -> Void {
        
        APIManager.shared.cardsInformation()  { (backend, error) in
            
            if((error) == nil){
                
                if let basicArray = backend?["Basic"] as? NSArray{
                    for cards in basicArray{
                        let types = Cards(dictionary: cards as! [String : AnyObject])
                        let factions = Cards(dictionary: cards as! [String : AnyObject])
                        let rarities = Cards(dictionary: cards as! [String : AnyObject])
                        let images = Cards(dictionary: cards as! [String : AnyObject])
         
                        self.cardsArray.append(types)
                        self.cardsArray.append(factions)
                        self.cardsArray.append(rarities)
                        self.cardsArray.append(images)

                    }
                    
                    self.collectionView.reloadData()
                }

            } else {
                
            }
        }

    }
    
    
    //PRIVATE
    func registerNibs(){
        
        let customCollectionCellNib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(customCollectionCellNib, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
    }
    
    //MARK: - UICOLLECTIONVIEW 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.cardsArray.count
    
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        let item = self.cardsArray[indexPath.row]
        customCell.ibresType.text = item.cardType
        customCell.ibresFaction.text = item.cardFaction
        customCell.ibresRarity.text = item.cardRarity
        if item.cardImage == "" {
            
        } else{
            customCell.ibImageView.image = UIImage(named: item.cardImage)
        }
        return customCell
        
    }

    

}

