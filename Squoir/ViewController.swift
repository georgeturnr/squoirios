//
//  ViewController.swift
//  Squoir
//
//  Created by George Turner on 06/12/2016.
//  Copyright © 2016 George Turner. All rights reserved.
//


import UIKit
import GPUImage
import Photos



class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var videoCamera:GPUImageVideoCamera?
    
    
    var filter:GPUImageGrayscaleFilter?
    

    
    @IBAction func photoTake(_ sender: UIButton) {
        
        self.filter?.useNextFrameForImageCapture()
        let capturedImage:UIImage = (self.filter?.imageFromCurrentFramebuffer())!;
        UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil);
        self.videoCamera?.resumeCameraCapture()
    }

    @IBOutlet weak var df: GPUImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Specifies the video camera dimentions and which camera to use
        videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .front)
        
        //Specifies output orientation
        videoCamera!.outputImageOrientation = .portrait;

        filter = GPUImageGrayscaleFilter()
        
        videoCamera?.addTarget(filter)
        filter?.addTarget(df)
        videoCamera?.startCapture()
        
    }
    
}

