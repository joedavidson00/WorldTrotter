//
//  MathViewController.swift
//  WorldTrotter
//
//  Created by Joseph  Davidson on 2/25/19.
//  Copyright © 2019 Joseph  Davidson. All rights reserved.
//

import UIKit

class MathViewController: UIViewController, UITextFieldDelegate {
    
    
    // all of my labels and text field
    @IBOutlet var NumberOneLabel: UILabel!
    @IBOutlet var NumberTwoLabel: UILabel!
    @IBOutlet var operatorsLabel: UILabel!
    @IBOutlet var questionNumberLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var questionStatusLabel: UILabel!
    @IBOutlet var answerField: UITextField!
    
    
    // decleration of variables
    var questionNumber:Int = 0
    var points:Int = 0
    let operators: [String] =    ["+","-","*","/"]
    var number1: Int = 0
    var number2: Int = 0
    var answeredQuestion: Bool = false
    
    

    // just to get a nice background
    override func viewWillAppear(_ animated: Bool) {
        
        // get the hour component of the current time
        let calendar = Calendar(identifier: Calendar.Identifier.iso8601)
        let currentHour = calendar.component(.hour, from: Date())

        // Define my colors, including the random color generator at dusk
        let darkColor = UIColor(red: 13/255.0, green: 61/255.0, blue: 91/255.0, alpha: 1.0)
        let morningColor = UIColor(red: 250/255.0, green: 150/255.0, blue: 12/255.0, alpha: 0.6)
        let dayColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 150/255.0, alpha: 1.0)
        
        // Switch colors based on the hour of the day
        switch currentHour {
        case 7...10:
            view.backgroundColor = morningColor
        case 11...16:
            view.backgroundColor = dayColor
        default:
            view.backgroundColor = darkColor
        }
        
    }
    // loads the first question
    override func viewDidLoad() {
        answerField.delegate = self
        answerField.keyboardType = .numberPad
        super.viewDidLoad()
        pointsLabel.text = ""
        newQuestion()

    }
    
    // this is code to load a new question and reset some of the text fields
    func newQuestion() {
        if questionNumber == 10 {
            questionNumber = 0
            points = 0
        }
        questionNumber+=1
        questionStatusLabel.text = "Answer the Question"
        if questionNumber == 1 {
            questionStatusLabel.text = "Welcome to the math quiz"
        }
        answerField.text = ""
        number1 =  Int.random(in: -10 ... 20)
        number2 = Int.random(in: -10 ... 20)
        NumberOneLabel.text = "\(number1)"
        NumberTwoLabel.text = "\(number2)"
        operatorsLabel.text = operators.randomElement()!
        questionNumberLabel.text = "Question \(questionNumber)"
    }

    
    
    
    
    // the function that is ran when the submit button is hit, I have logic for the question status in here too
    @IBAction func submitQuestion(_ sender: UIButton) {
        let answerAttempt = Int(answerField.text ?? "-1000")
        let answer = doMath(number1, number2,Character(operatorsLabel!.text!))
        
    
        if answerAttempt == answer && !answeredQuestion && answerAttempt != nil{
            points+=1
            answeredQuestion = true
            questionStatusLabel.text = "Correct!"
        }
        if answerAttempt != answer && answerAttempt != nil{
            answeredQuestion = true
            questionStatusLabel.text = "Wrong! - The answer is \(answer)"
            
        }
        
        let percentRight:Float = (Float(points)/Float(questionNumber))*100
        pointsLabel.text = "\(round(percentRight))% right"
        
    }
    
    // ran when the next question button is hit
    @IBAction func nextQuestion(_ sender: UIButton) {
        if answeredQuestion {
            newQuestion()
            answeredQuestion = false
        }
    }

    // the new quiz button, resets everything then starts a new quiz
    @IBAction func newQuiz(_ sender: UIButton) {
        points = 0
        questionNumber = 0
        newQuestion()
    }
    
    func add(_ a: Int, _ b: Int) -> Int {
        return (a+b)
    }
    func sub(_ a: Int, _ b: Int) -> Int {
        return (a-b)
    }
    func div(_ a: Int, _ b: Int) -> Int {
        if b != 0{
            return (a/b)}
        else {
            return 42
        }
    }
    func mul(_ a: Int, _ b: Int) -> Int {
        return (a*b)
    }
    
    

    
    // i used the first version of the domath function with the switch statement, I tried the one with typealias but I kept getting an error
    func doMath(_ a:Int, _ b:Int, _ op:Character) -> Int {
        switch op {
        case "+": return add(a,b)
        case "-": return sub(a,b)
        case "*": return mul(a,b)
        case "/": return div(a,b)
        default: return 0
        }
    }
}
