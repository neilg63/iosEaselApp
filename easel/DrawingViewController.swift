//
//  ViewController.swift
//  easel
//
//  Created by Neil Gardner on 05/05/2016.
//  Copyright © 2016 Neil Gardner. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {

    @IBOutlet weak var buttonsStack: UIStackView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    var lastPoint = CGPoint.zero
    
    var red:CGFloat = 0.0
    
    var green:CGFloat = 0.0
    
    var blue:CGFloat = 0.0
    
    var opacity:CGFloat = 0.9
    
    var strokeWidth: CGFloat = 6
    
    var randomMode = false

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appBecameActive", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.buttonsStack.hidden = true
        if let touch = touches.first {
            let point = touch.locationInView(self.imageView)
            self.lastPoint = point
        }
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.locationInView(self.imageView)
            drawBetweenPoints(self.lastPoint,secondPoint: point)
            self.lastPoint = point
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.locationInView(self.imageView)
            drawBetweenPoints(self.lastPoint,secondPoint: point)
        }
        self.buttonsStack.hidden = false
    }
    
    func drawBetweenPoints(firstPoint:CGPoint,secondPoint:CGPoint) {
        
        UIGraphicsBeginImageContext(self.imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        self.imageView.image?.drawInRect(CGRect(x:0, y:0,width:self.imageView.frame.size.width, height:self.imageView.frame.size.height) )
        
        CGContextMoveToPoint(context, firstPoint.x, firstPoint.y)
        CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y)
        if randomMode {
            randomTapped(UIButton())
        }
        CGContextSetRGBStrokeColor(context, self.red / 255.0, self.green / 255.0, self.blue / 255.0, self.opacity)
        CGContextSetLineCap(context, .Round)
        CGContextSetLineWidth(context, self.strokeWidth)
        CGContextStrokePath(context)
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    func appBecameActive() {
        self.buttonsStack.hidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "drawingToSettings" {
            let settingsVc = segue.destinationViewController as! SettingsViewController
            settingsVc.drawingVC = self
        }
    }
    
    func eraseEasel() {
        self.imageView.image = nil
    }
    
    
    @IBAction func greenTapped(sender: AnyObject) {
        self.randomMode = false
        self.red = 45.0
        self.green = 239.0
        self.blue = 106.0
    }
    
    @IBAction func blueTapped(sender: AnyObject) {
        self.randomMode = false
        self.red = 51.0
        self.green = 95.0
        self.blue = 228.0
    }
    
    @IBAction func redTapped(sender: AnyObject) {
        self.randomMode = false
        self.red = 224.0
        self.green = 41.0
        self.blue = 49.0
    }
    
    @IBAction func yellowTapped(sender: AnyObject) {
        self.randomMode = false
        self.red = 248.0
        self.green = 215.0
        self.blue = 21.0
    }

    @IBAction func randomTapped(sender: AnyObject) {
        self.randomMode = true
        self.red = CGFloat(arc4random_uniform(256))
        self.green = CGFloat(arc4random_uniform(256))
        self.blue = CGFloat(arc4random_uniform(256))
    }
    
}

