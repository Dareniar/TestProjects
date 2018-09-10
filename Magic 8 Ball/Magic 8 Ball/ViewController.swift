//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Данил on 7/20/18.
//  Copyright © 2018 Dareniar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let images = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    var randomBallNumber: Int = 0

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newBallImage()
        
    }

    @IBAction func askButtonPressed(_ sender: Any) {
        
        newBallImage()
        
    }
    
    func newBallImage() {
        
        randomBallNumber = Int(arc4random_uniform(5))
        imageView.image = UIImage(named: images[randomBallNumber])
        
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        newBallImage()
        
    }

}

