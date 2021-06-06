//
//  HomeViewController.swift
//  Object-Recognition-App
//
//  Created by Mehdi Benrefad on 05/06/2021.
//  Copyright © 2021 Mehdi Benrefad. All rights reserved.
//

import UIKit
import TransitionButton
import AMPopTip
class HomeViewController: UIViewController {
 
    @IBOutlet weak var isAComputer: UIButton!
    @IBOutlet weak var objectName: UIButton!
    @IBOutlet weak var dominantObject: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let popTip1 = PopTip()
        initPopTip(popTip: popTip1, origin: isAComputer)
        
        let popTip2 = PopTip()
        initPopTip(popTip: popTip2, origin: objectName)
        
        let popTip3 = PopTip()
        initPopTip(popTip: popTip3, origin: dominantObject)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    //fonction qui initialise les popups
    func initPopTip(popTip: PopTip , origin: UIButton){
        popTip.bubbleColor = UIColor.lightGray
        //popTip.borderWidth = 500
        popTip.show(text: "Classification", direction: .down, maxWidth: 400, in: view, from: origin.frame)
        popTip.shouldDismissOnTap = false
        popTip.tapHandler = { popTip in
            //print("\(popTip) tapped")
            if popTip.text == "Classification"{
                popTip.update(text: "In machine learning, classification refers to a predictive modeling problem where a class label is predicted for a given example of input data.")
            }else{
                popTip.update(text: "Classification")
            }
        }
        popTip.shouldDismissOnTapOutside = false
        
        popTip.entranceAnimation = .scale;
        
        popTip.tapOutsideHandler = { _ in
            //print("tap outside")
            popTip.update(text: "Classification")
        }
    }
    //on declare le controlleur comme cibre de retour en arriere
    @IBAction func unwindBookToWelcome(segue:UIStoryboardSegue) { }

    
}

