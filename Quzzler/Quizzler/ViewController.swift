//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber += 1
        
        updateUI()
        
    }
    
    
    func updateUI() {
        
        scoreLabel.text = "Score: \(score)"
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber)
        
        progressLabel.text = "\(questionNumber) / \(allQuestions.list.count)"
        
        nextQuestion()
        
    }
    

    func nextQuestion() {
        
        if questionNumber < allQuestions.list.count {
            
            questionLabel.text = allQuestions.list[questionNumber].questionText
            
        } else {

            let alert = UIAlertController(title: "Awesome!", message: "You've finished all the question, do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
        
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("You got it!")
            score += 1
        } else {
            ProgressHUD.showError("Wrong!")
        }
        
    }
    
    
    func startOver() {
        
        score = 0
        questionNumber = 0
        updateUI()
        
    }
    

    
}
