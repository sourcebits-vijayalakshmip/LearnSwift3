//
//  Cards.swift
//  LearnSwift3
//
//  Created by Vijayalakshmi Pulivarthi on 29/11/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//

import Foundation

import UIKit

class Cards : NSObject {
    
    var cardType = String()
    var cardFaction =  String()
    var cardRarity = String()
    var cardImage = String()
    var sectionHeaderArray = NSArray()
    

    
    init(cardType: String?,cardFaction: String?,cardRarity: String?,cardName: String?,cardImage: String?, sectionHeaderArray: NSArray?){
        
        self.cardType = cardType!
        self.cardFaction = cardFaction!
        self.cardRarity = cardRarity!
        self.sectionHeaderArray = sectionHeaderArray!
        self.cardImage = cardImage!

    }
    
    init(array: [String: AnyObject]) {
        
        self.sectionHeaderArray = array["keys"] as! NSArray

    }
    init(dictionary : [ String: AnyObject]){
        
        self.cardType = dictionary["type"] as! String
        self.cardRarity = dictionary["rarity"] as! String

        if dictionary["faction"] as? String == nil {
            
        } else{
            self.cardFaction = dictionary["faction"] as! String

        }
        if dictionary["img"] as? String == nil {
            
        } else{
            self.cardImage = dictionary["img"] as! String
            
        }
    }
    
    
    
}
