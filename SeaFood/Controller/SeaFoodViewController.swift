//
//  ViewController.swift
//  SeaFood
//
//  Created by Narongsak_O on 2/9/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit
import CoreML
import Vision

class SeaFoodViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
    }
    
    //MARH:- picked Picture from camera
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {fatalError("Could not covert UIImage to CIImage.")}
            detect(image: ciimage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - detech CoreML
    
    func detect(image: CIImage){
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {fatalError("Loding CoreML Module failed.")}
        
        let request = VNCoreMLRequest(model: model) { (request,error) in
            guard let results = request.results as? [VNClassificationObservation] else {fatalError("Model failed to prcess image.")
            }
            
            print(results)
            
            if let firstResult = results.first {
                if firstResult.identifier.contains("hotdog"){
                    self.navigationItem.title = "Hotdog!"
                } else {
                    self.navigationItem.title = "Not Hotdog!"
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
           try handler.perform([request])
        } catch {
            print(error)
        }
        
    }

    //MARK: - Camera Button
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    

}

