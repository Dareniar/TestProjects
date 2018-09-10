//
//  ViewController.swift
//  CoreAnimationDemo
//
//  Created by Данил on 9/4/18.
//  Copyright © 2018 Dareniar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var passwordTextField: ShakingTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        
        avatarImageView.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.addPulse))
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func addPulse() {
        
        let pulse = Pulsing(numberOfPulses: 1, radius: 160, position: avatarImageView.center)
        pulse.animationDuration = 1.2
        pulse.backgroundColor = UIColor.blue.cgColor
        
        self.view.layer.insertSublayer(pulse, below: avatarImageView.layer)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        passwordTextField.shake()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

