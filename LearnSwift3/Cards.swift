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
    var sectionHeader = String()
    var cardText = String()
    var viewcontroller = ViewController()
    var dict: [String] = []

    

    
    init(cardType: String?,cardFaction: String?,cardRarity: String?,cardName: String?,cardImage: String?, sectionHeader: String?, cardText: String?){
        
        self.cardType = cardType!
        self.cardFaction = cardFaction!
        self.cardRarity = cardRarity!
        self.sectionHeader = sectionHeader!
        self.cardImage = cardImage!
        self.cardText = cardText!

    }
    
   
    init(dictionary : [ String: AnyObject]){
        
        self.cardType = dictionary["type"] as! String
        
        if dictionary["rarity"] as? String == nil {
            
        } else{
            self.cardRarity = dictionary["rarity"] as! String
            
        }

        if dictionary["faction"] as? String == nil {
            
        } else{
            self.cardFaction = dictionary["faction"] as! String

        }
        if dictionary["img"] as? String == nil {
            
        } else{
            self.cardImage = dictionary["img"] as! String
        }
        if dictionary["text"] as? String == nil {

        } else{
            self.cardText = dictionary["text"] as! String

        }
        

    }
    
    
    
}
