//
//  AvCaptureViewController.swift
//  CameraDemoPro
//
//  Created by mohammad noor uddin on 13/7/23.
//

import UIKit
import AVFoundation

class AvCaptureViewController: UIViewController,AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var capturePhoto: UIButton!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                DispatchQueue.main.async {
                    self.setUpCamera()
                }
            }
            else {
                print("Camera Permission Not Granted")
            }
        }
    }
    
    @IBAction func dismissButtonTap(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func capturePhotoTap(_ sender: Any) {
        guard let capturePhotoOutput = self.capturePhotoOutput else {
            return
        }
        let settings = AVCapturePhotoSettings()
        capturePhotoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession?.stopRunning()
    }
    
    func setUpCamera() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .photo
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            capturePhotoOutput = AVCapturePhotoOutput()
            captureSession?.addOutput(capturePhotoOutput!)
            captureSession?.addInput(input)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            
            view.layer.addSublayer(videoPreviewLayer!)
            view.bringSubviewToFront(dismissButton)
            view.bringSubviewToFront(capturePhoto)
            
            captureSession?.startRunning()
            
        }
        catch
        {
            print(error.localizedDescription)
        }
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            let capturedImage = UIImage(data: imageData)
            
            let imageView = UIImageView(frame: self.view.bounds)
            imageView.image = capturedImage
            imageView.contentMode = .scaleToFill
            self.view.addSubview(imageView)
            self.view.bringSubviewToFront(dismissButton)
        }
    }

}
