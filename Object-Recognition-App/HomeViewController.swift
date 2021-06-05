//
//  HomeViewController.swift
//  Object-Recognition-App
//
//  Created by Mehdi Benrefad on 05/06/2021.
//  Copyright © 2021 Mehdi Benrefad. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //on declare le controlleur comme cibre de retour en arriere
    @IBAction func unwindBookToWelcome(segue:UIStoryboardSegue) { }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
