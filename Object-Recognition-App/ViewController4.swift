//
//  ViewController4.swift
//  Object-Recognition-App
//
//  Created by Mehdi Benrefad on 06/06/2021.
//  Copyright © 2021 Mehdi Benrefad. All rights reserved.
//

import UIKit
import Vision
import CoreML

class ViewController4: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var prediction: UILabel!
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
                    //imageSelected.image = userPickerImage
                    guard let ciimage = CIImage(image: userPickerImage) else {
                        fatalError("Failed to convert UI image to ciimage")
                    }
            Detect(image: ciimage)
        }
         imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    //Detecter image
    func Detect(image: CIImage){
        //recuperer le modele
        guard   let model = try? VNCoreMLModel(for: MNISTClassifier().model) else{
                       fatalError("Core ML loading failed")
               }
 
            
            //tester si la requette a reussi ou non
               let request = VNCoreMLRequest(model: model ) {   (request, error ) in
              guard let results = request.results as? [VNClassificationObservation] else {
                       fatalError("Core ML process failed")
                    }
                 
                //recuperer le premier resultat
                   if let fisrtresult = results.first {
                    self.prediction.text = "the number is:" + fisrtresult.identifier
                       
                   }
               }
         //envoi d'une ou de plusieurs requettes sur l'image
         let handler = VNImageRequestHandler(ciImage: image)
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        /*
               var mlModel = MNISTClassifier()
                let input = MNISTClassifierInput(image: image)
                let pred = try? mlModel.prediction(input: input)
                self.prediction.text = pred?.featureNames.first
        */
        
    }
    
    
    
    //convertit une UIImage a CVPixelBuffer
    func buffer(from image: UIImage) -> CVPixelBuffer? {
      let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
      var pixelBuffer : CVPixelBuffer?
      let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
      guard (status == kCVReturnSuccess) else {
        return nil
      }

      CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
      let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

      let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
      let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

      context?.translateBy(x: 0, y: image.size.height)
      context?.scaleBy(x: 1.0, y: -1.0)

      UIGraphicsPushContext(context!)
      image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
      UIGraphicsPopContext()
      CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

      return pixelBuffer
    }
    
    
    @IBAction func cameraBTN(_ sender: Any) {
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker,animated: true,completion: nil)
    }
    
}
