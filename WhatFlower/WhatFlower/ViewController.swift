//
//  ViewController.swift
//  WhatFlower
//
//  Created by Данил on 9/7/18.
//  Copyright © 2018 Dareniar. All rights reserved.
//

import UIKit
import Vision
import CoreML
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userPickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {

            guard let ciimage = CIImage(image: userPickedImage) else { fatalError("Could not convert to CIImage") }
            
            detect(image: ciimage)
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else { fatalError("Loading CoreML Model Failed.") }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let result = request.results?.first as? VNClassificationObservation else { fatalError("Model failed to process image.") }
            
            let flowerName = result.identifier
            self.navigationItem.title = flowerName.capitalized
            self.wikipediaRequest(with: flowerName)

            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }

    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func wikipediaRequest(with flowerName: String) {
        
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize" : "500"
            ]
        
            Alamofire.request(wikipediaURl, method: .get, parameters: parameters).responseJSON {
            
            response in
            if response.result.isSuccess {
                
                //print(response.result.value!)
                let flowerJSON: JSON = JSON(response.result.value!)
                let pageid = flowerJSON["query"]["pageids"][0].stringValue
                let description = flowerJSON["query"]["pages"][pageid]["extract"].stringValue
                let flowerImageURL = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                self.descriptionLabel.text = description
                self.imageView.sd_setImage(with: URL(string: flowerImageURL))
                
                
            } else {
                print("Error \(String(describing: response.result.error)).")
            }
            
        }
        
    }
    
}

