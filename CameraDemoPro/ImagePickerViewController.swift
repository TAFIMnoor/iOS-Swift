//
//  ImagePickerViewController.swift
//  CameraDemoPro
//
//  Created by mohammad noor uddin on 13/7/23.
//

import UIKit

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.capturePhotoButtonTapped()
    }
    
    func capturePhotoButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Do something with the captured image
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            imageView.image = image
            view.addSubview(imageView)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
