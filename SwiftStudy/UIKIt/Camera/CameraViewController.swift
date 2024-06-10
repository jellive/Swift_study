//
//  CameraViewController.swift
//  SwiftStudy
//
//  Created by Jell PD on 2020/08/30.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit
import MobileCoreServices // 미디어 등이 정의되어 있는 헤더

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var captureImage: UIImage!
    var flagImageSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("camera")
    }
    
    @IBAction func cameraClicked(_ sender: Any) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String] // ??
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true) {}
        }
    }
    
    @IBAction func albumClicked(_ sender: Any) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true) {}
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[.mediaType] as! NSString
        print(mediaType)
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            captureImage = info[.originalImage] as? UIImage
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imageView.image = captureImage
        }
        self.dismiss(animated:true){}
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
