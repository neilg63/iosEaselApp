//
//  SettingsViewController.swift
//  easel
//
//  Created by Neil Gardner on 05/05/2016.
//  Copyright © 2016 Neil Gardner. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    weak var drawingVC: DrawingViewController? = nil
    
    @IBOutlet weak var strokeWidthLabel: UILabel!
    
    @IBOutlet weak var strokeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        if let dVc = self.drawingVC {
            self.strokeWidthLabel.text = "\(dVc.strokeWidth)px"
            self.strokeSlider.value = Float(dVc.strokeWidth)
        }
        
    }
    
    @IBAction func eraseTapped(sender: AnyObject) {
        self.drawingVC?.eraseEasel()
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    @IBAction func shareTapped(sender: AnyObject) {
        if let image = self.drawingVC?.imageView.image {
            let activityVc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            self.presentViewController(activityVc, animated: true, completion: nil)
        }
       
    }
    
    @IBAction func adjustStroke(sender: AnyObject) {
        let strokeWidth = CGFloat(round(self.strokeSlider.value))
        self.drawingVC?.strokeWidth = strokeWidth
        self.strokeWidthLabel.text = "\(Int(strokeWidth))px"
    }
    
}
