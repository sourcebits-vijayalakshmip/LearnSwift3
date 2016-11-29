//
//  ViewController.swift
//  LearnSwift3
//
//  Created by Vijayalakshmi Pulivarthi on 29/11/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonAction(_ sender: AnyObject) {
        
        APIManager.shared.cardsInformation()  { (backend, error) in
            
            if((error) == nil){
                
                let basicArray = backend?["Basic"] as! NSArray?
                
                for cardsDict in basicArray! {
                    let dictName = cardsDict as! NSDictionary
                    let name = dictName["name"] as! String
                    print("card Name..", name)
                }
            }
            else
            {
            }
        }
    }

}

