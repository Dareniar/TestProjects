//
//  ViewController.swift
//  Canvas
//
//  Created by Данил on 9/3/18.
//  Copyright © 2018 Dareniar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvas: CanvasView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clearButtonPressed(_ sender: Any) {
        canvas.clearCanvas()
    }
    
}

