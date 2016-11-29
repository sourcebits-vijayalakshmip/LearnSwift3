//
//  ViewController.swift
//  LearnSwift3
//
//  Created by Vijayalakshmi Pulivarthi on 29/11/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var  cardTypeArray : NSMutableArray!
    var  factionArray : NSMutableArray!
    var  rarityArray : NSMutableArray!
    var  imageArray : NSMutableArray!
    var  sectionHeaderArray: NSMutableArray!
    

    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let nib = UINib(nibName: "CollectionSectionHeaderView", bundle: nil)
//        collectionView.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionSectionHeaderView")
        registerNibs()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func buttonAction(_ sender: AnyObject) {
        
        APIManager.shared.cardsInformation()  { (backend, error) in
            
            if((error) == nil){
                
                
                let basicArray = backend?["Basic"] as! NSArray?
                let classicArray = backend?["Classic"] as! NSArray?
                /*let promoArray = backend?["Basic"] as! NSArray?
                let rewardArray = backend?["Basic"] as! NSArray?
                let naxxaArray = backend?["Basic"] as! NSArray?
                let goblinsArray = backend?["Basic"] as! NSArray?
                let blackrocksArray = backend?["Basic"] as! NSArray?
                let bgrandTournmentArray = backend?["Basic"] as! NSArray?
                let explorersArray = backend?["Basic"] as! NSArray?
                let whispersArray = backend?["Basic"] as! NSArray?
                let karazhanArray = backend?["Basic"] as! NSArray?
                let taveranArray = backend?["Basic"] as! NSArray?
                let heroArray = backend?["Basic"] as! NSArray?
                let misssionsArray = backend?["Basic"] as! NSArray?
                let creditsArray = backend?["Basic"] as! NSArray?
                let systemArray = backend?["Basic"] as! NSArray?
                let debugArray = backend?["Basic"] as! NSArray?*/

                
                for cardsType in basicArray! {
                    let dictType = cardsType as! NSDictionary
                    let allcards = AllCards()
                    allcards.cardType = dictType["type"] as! String
                    self.cardTypeArray = NSMutableArray()
                    self.cardTypeArray?.add(allcards.cardType)
                    
                }
                for cardsFaction in basicArray! {
                    let dictFaction = cardsFaction as! NSDictionary
                    let allcards = AllCards()
                    
                    if dictFaction["faction"] as? String == nil {
                        
                    } else{
                        allcards.cardFaction = dictFaction["faction"] as? String
                        self.factionArray = NSMutableArray()
                        self.factionArray.add(allcards.cardFaction)
                    }
                }

                for cardsRarity in basicArray! {
                    let dictRarity = cardsRarity as! NSDictionary
                    let allcards = AllCards()
                    allcards.cardRarity = dictRarity["rarity"] as! String
                    self.rarityArray = NSMutableArray()
                    self.rarityArray.add(allcards.cardRarity)
                }
                for cardsImages in basicArray! {
                    let dictImages = cardsImages as! NSDictionary
                    
                    if dictImages["img"] as? String == nil {
                        
                    } else{
                        let allcards = AllCards()
                        allcards.cardImage = dictImages["img"] as? String
                        self.imageArray = NSMutableArray()
                        self.imageArray.add(self.imageArray)
                     }
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.cardTypeArray.count
    
    
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.ibresType.text = self.cardTypeArray?[indexPath.row] as? String
        return cell
        
    }

}

