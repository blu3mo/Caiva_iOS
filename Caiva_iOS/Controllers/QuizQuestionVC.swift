//
//  QuizQuestionViewController.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/08/01.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit
import Hero

class QuizQuestionViewController: UIViewController {

    var quizset: Quizset?
    var currentQuiz: Quiz?
    var quizIndex: Int = 0
    var correctCount = 0
    var initialPerc = 0.0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var selection1: UIButton!
    @IBOutlet weak var selection2: UIButton!
    @IBOutlet weak var selection3: UIButton!
    @IBOutlet weak var selection4: UIButton!
    
    @IBOutlet weak var countLabelC: UILabel!
    @IBOutlet weak var questionLabelC: UILabel!
    
    @IBOutlet weak var selection1C: UIButton!
    @IBOutlet weak var selection2C: UIButton!
    @IBOutlet weak var selection3C: UIButton!
    @IBOutlet weak var selection4C: UIButton!
    
    @IBOutlet weak var questionContainer: UIView!
    @IBOutlet weak var questionContainerCopy: UIView!
    
    @IBOutlet weak var resultView: GradientView!
    @IBOutlet weak var resultQuestion: UILabel!
    @IBOutlet weak var resultAnswer: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var darkCover: UIView!
    
    
    var selectionButtons: [UIButton] = []
    var selectionButtonsC: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        quizset = QuizService.createQuizset(from: Cardset.currentCardset!, amount: 4)

        initialPerc = Cardset.currentCardset!.perc
        
        selectionButtons = [selection1, selection2, selection3, selection4]
        selectionButtonsC = [selection1C, selection2C, selection3C, selection4C]
        
        setText(from: quizset!.quizes[0], randomNum: Int(arc4random_uniform(4)))
        
        //resultView.isHidden = true
        resultView.alpha = 0.0
        darkCover.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuizDone" {
            let nextVC = segue.destination as! QuizResultViewController
            nextVC.result = String(correctCount) + "/" + String(quizset!.quizes.count)
            nextVC.initialPerc = initialPerc
        }
    }
    
    func setText(from quiz: Quiz, randomNum: Int) {
        currentQuiz = quiz
        questionLabel.text = quiz.answer.front
        countLabel.text = "\(quizIndex + 1)/\(quizset!.quizes.count)"
        //let randomNum = arc4random_uniform(4)
        var wrongSelections = quiz.otherSelections
        for index in 0...3 {
            let button = selectionButtons[index]
            if (index == randomNum) {
                button.setTitle(quiz.answer.back, for: .normal)
                button.tag = 1
            } else {
                button.setTitle(wrongSelections[0].back, for: .normal)
                button.tag = 0
                wrongSelections.removeFirst()
            }
        }
    }
    
    
    func setTextC(from quiz: Quiz, randomNum: Int) {
        questionLabelC.text = quiz.answer.front
        countLabelC.text = "\(quizIndex + 1)/\(quizset!.quizes.count)"
        questionLabelC.setNeedsLayout()
        //let randomNum = arc4random_uniform(4)
        var wrongSelections = quiz.otherSelections
        for index in 0...3 {
            let button = selectionButtonsC[index]
            if (index == randomNum) {
                button.setTitle(quiz.answer.back, for: .normal)
                button.setNeedsLayout()
            } else {
                button.setTitle(wrongSelections[0].back, for: .normal)
                button.setNeedsLayout()
                wrongSelections.removeFirst()
            }
        }
    }
    
    func slideQuestion(quizIndex: Int, randomNum: Int) -> Bool {
        if let nextQuiz = quizset!.quizes[safe: quizIndex] {
            //setTextC(from: nextQuiz)
            questionContainerCopy.center.x += 400
            questionContainerCopy.isHidden = false
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
                //self.setTextC(from: nextQuiz)
                self.questionContainer.center.x -= 400
                self.questionContainerCopy.center.x -= 400
            }, completion: { _ in
                self.setText(from: nextQuiz, randomNum: randomNum)
                self.questionContainer.center.x += 400
                self.questionContainerCopy.isHidden = true
            })
            return true
        } else {
            return false
        }
    }

    @IBAction func selectionTapped(_ sender: UIButton) {
        //let text = "test"
        //questionLabelC.text = text//quizset!.quizes[quizIndex].answer.front
        
        let isCorrect = sender.tag == 1
        print(isCorrect)
        
        //self.resultView.center.y += 600
        resultQuestion.text = currentQuiz!.answer.front
        resultAnswer.text = currentQuiz!.answer.back
        if isCorrect {
            result.text = "Correct!"
            result.textColor = UIColor(hexString: "#35A716")
            correctCount += 1
        } else {
            result.text = "Wrong.."
            result.textColor = UIColor(hexString: "#C52C71")
        }
        
        QuizService.updateDegree(quiz: currentQuiz!, wasCorrect: isCorrect)
        
        resultView.alpha = 0.0
        darkCover.isHidden = false
        darkCover.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            self.resultView.alpha = 1.0
            self.darkCover.alpha = 1.0
        })
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        quizIndex += 1
        
        UIView.animate(withDuration: 0.3, animations: {
            self.resultView.alpha = 0.0
            self.darkCover.alpha = 0.0
        })
        darkCover.isHidden = true
        
        if quizset!.quizes[safe: quizIndex] == nil {
            self.performSegue(withIdentifier: "toQuizDone", sender: self)
            return
        }
        
        let randomNum = arc4random_uniform(4)
        
        self.setTextC(from: self.quizset!.quizes[self.quizIndex], randomNum: Int(randomNum))
        
        Util.doAfterDelay(seconds: 0.05, process: {
            self.slideQuestion(quizIndex: self.quizIndex, randomNum: Int(randomNum))
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
