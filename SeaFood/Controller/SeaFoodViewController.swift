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
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

    //MARK: - Camera Button
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    

}

