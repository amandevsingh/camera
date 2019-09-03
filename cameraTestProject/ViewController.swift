//
//  ViewController.swift
//  cameraTestProject
//
//  Created by Aman dev on 6/26/19.
//  Copyright © 2019 Aman dev. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var photoPreviewImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSession.Preset.photo
        let backCamera =  AVCaptureDevice.default(for: AVMediaType.video)
            var error: NSError?
            var input: AVCaptureDeviceInput!
            do {
                input = try AVCaptureDeviceInput(device: backCamera!)
            } catch let error1 as NSError {
                error = error1
                input = nil
                print(error!.localizedDescription)
            }
            if error == nil && session!.canAddInput(input) {
                session!.addInput(input)
                stillImageOutput = AVCaptureStillImageOutput()
                stillImageOutput?.outputSettings = [AVVideoCodecKey:  AVVideoCodecJPEG]
                if session!.canAddOutput(stillImageOutput!) {
                    session!.addOutput(stillImageOutput!)
                    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
                    videoPreviewLayer!.videoGravity =    AVLayerVideoGravity.resizeAspect
                    videoPreviewLayer!.connection?.videoOrientation =   AVCaptureVideoOrientation.portrait
                    previewView.layer.addSublayer(videoPreviewLayer!)
                    session!.startRunning()
                }
            }
        }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer!.frame = previewView.bounds
    }
  

    @IBAction func didTapOnTakePhotoButton(_ sender: UIButton) {
    }


}

