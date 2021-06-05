//
//  ViewController.swift
//  Object-Recognition-App
//
//  Created by Mehdi Benrefad on 05/06/2021.
//  Copyright © 2021 Mehdi Benrefad. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    @IBOutlet weak var imageSelect: UIImageView!
    @IBOutlet weak var shoeLabel: UILabel!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //definir le viewController en tant que delegate de l'image picker
        imagePicker.delegate = self
        //definir la source de l'image
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //on verifie si l'utilisateur a selectionne une image correctement
         if let userPickerImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    imageSelect.image = userPickerImage
                    guard let ciimage = CIImage(image: userPickerImage) else {
                        fatalError("Failed to convert UI image to ciimage")
                    }
        }
         imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraBTN(_ sender: UIBarButtonItem) {
        present(imagePicker,animated: true,completion: nil)
    }
    
}


