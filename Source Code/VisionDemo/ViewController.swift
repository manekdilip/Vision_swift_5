//
//  ViewController.swift
//  VisionDemo
//
//  Created by Krunal on 08/07/20.
//  Copyright © 2020 Krunal. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

//    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let imageView = UIImageView()
        let image = UIImage(named: "Zachary")
        imageView.image = image
        let ImageScaledHeight = view.frame.width / (image?.size.width)! * (image?.size.height)!
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ImageScaledHeight)
        view.addSubview(imageView)
    
    }
// Face Detection button
    @IBAction func detectFaceAction(_ sender: Any) {
        let image = UIImage(named: "Zachary")
        let scaledHeight = view.frame.width / (image?.size.width)! * (image?.size.height)!
        //detection request
            let request = VNDetectFaceRectanglesRequest { (req, err) in
                    if let err = err{
                        print("Faild to detect face: ",err)
                        return
                    }
                    req.results?.forEach({ (res) in
                        //face Observation & create rectengle on face
                        guard let faceObservation = res as? VNFaceObservation else{ return }
                        
                        let x = self.view.frame.width * faceObservation.boundingBox.origin.x
                        
                        let width = self.view.frame.width * faceObservation.boundingBox.width
                        let Height = scaledHeight * faceObservation.boundingBox.height
                        let y = scaledHeight * (1 - faceObservation.boundingBox.origin.y) - Height
                        let faceView = UIView()
//                        faceView.backgroundColor = .green
//                        faceView.alpha = 0.4
                        faceView.frame = CGRect(x: x, y: y, width: width, height: Height)
                        faceView.layer.borderColor = UIColor.red.cgColor
                        faceView.layer.borderWidth = 3
                        faceView.layer.masksToBounds = true
                        
                        self.view.addSubview(faceView)
                        print(faceObservation.boundingBox)
                    })
                }
                //Handle face Detection request
                guard let cgimage = image?.cgImage else {return}
               let handler = VNImageRequestHandler(cgImage: cgimage, options: [:])
                do {
                    try handler.perform([request])
                }catch let  reqErr{
                    print("faild ti perform request: ",reqErr)
                }
                
    }
    
}

