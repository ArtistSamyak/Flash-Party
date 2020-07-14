//
//  ViewController.swift
//  Flash Party
//
//  Created by Samyak Pawar on 11/07/20.
//  Copyright © 2020 ArtistSamyak. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    var rate: Float = 0.7
    var timer : Timer? = nil
    let colors = [ #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "7")]
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateRate(rate: rate)
    }
    
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        rate = sender.value
        print(rate)
        updateRate(rate: rate)
        
    }
    
    func updateRate(rate : Float) {
        var isOn = false
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: Double(1 - rate), repeats: true) { timer in
            
            self.image.image = self.colors.randomElement()
            
            if isOn == true {
                
                self.toggleTorch(on: false)
                isOn = false
            }else if isOn == false{
                
                isOn = true
                self.toggleTorch(on: true)
            }
            
        }
    }
    


}

