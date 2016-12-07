//
//  ViewController.swift
//  LearnSwift3
//
//  Created by Vijayalakshmi Pulivarthi on 29/11/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var  sectionHeaderArray: NSMutableArray?
    var typeArray = [Cards]()
    var factionArray = [Cards]()
    var rarityArray = [Cards]()
    var imageArray = [Cards]()
    var textArray = [Cards]()
    
    var getarrays: NSMutableArray?
    var dict: [String] = []
    var isValue: Bool = false
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?

    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        registerNibs()
        registerSectionHeaderNIb()
        fetchAllCards()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func filterImagesAction(_ sender: AnyObject) {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        isValue = true
        self.collectionView.reloadData()
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    // API CALL
    func fetchAllCards() -> Void {
        
        APIManager.shared.cardsInformation()  { (backend, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if((error) == nil){
                
                //let keys = backend?.allKeys
               // print("The Value Is........ \(keys!)")
                
                 self.dict = backend?.allKeys as! [String]
                
                self.sectionHeaderArray = NSMutableArray()
                self.sectionHeaderArray?.addObjects(from: self.dict)
                self.getarrays = NSMutableArray()
                self.getarrays?.add(self.sectionHeaderArray)
                
                if let basicArray = backend?["Basic"] as? NSArray{
                    for cards in basicArray{
                        let types = Cards(dictionary: cards as! [String : AnyObject])
                        let factions = Cards(dictionary: cards as! [String : AnyObject])
                        let rarities = Cards(dictionary: cards as! [String : AnyObject])
                        let images = Cards(dictionary: cards as! [String : AnyObject])
                        let text = Cards(dictionary: cards as! [String : AnyObject])

                        self.typeArray.append(types)
                        self.factionArray.append(factions)
                        self.rarityArray.append(rarities)
                        self.imageArray.append(images)
                        self.textArray.append(text)

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
    
    func registerSectionHeaderNIb() {
        
        let nib = UINib(nibName: "CollectionSectionHeaderView", bundle: nil)
        collectionView.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionSectionHeaderView")
    }
    //MARK: - UICOLLECTIONVIEW 
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        
        return (self.sectionHeaderArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.typeArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        if isValue == false {
            
            let itemType = self.typeArray[indexPath.row]
            customCell.ibresType.text = itemType.cardType
            let itemFaction  = self.factionArray[indexPath.row]
            customCell.ibresFaction.text = itemFaction.cardFaction
            let itemrarity = self.rarityArray[indexPath.row]
            customCell.ibresRarity.text = itemrarity.cardRarity
            let itemImage = self.imageArray[indexPath.row]
            
            if itemImage.cardImage == "" {
                
            } else{
                
                customCell.ibImageView.image = UIImage(named: itemImage.cardImage)
                print("image...", itemImage.cardImage)
                print("image Url..", customCell.ibImageView.image)
            }

        } else  {
            
            let itemImage = self.imageArray[indexPath.row]
            customCell.ibresImageUrl.text = itemImage.cardImage
            
            customCell.ibresType.isHidden = true
            customCell.ibresFaction.isHidden = true
            customCell.ibresRarity.isHidden = true
            
          }
        
        return customCell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: (collectionView.frame.size.width / 3), height: 180)
    }
    
    
}

