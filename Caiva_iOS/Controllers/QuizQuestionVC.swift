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
    
    var selectionButtons: [UIButton] = []
    var selectionButtonsC: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectionButtons = [selection1, selection2, selection3, selection4]
        selectionButtonsC = [selection1C, selection2C, selection3C, selection4C]
        
        questionLabel.fitTextToBounds()
        
        setText(from: quizset!.quizes[0])
        
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setText(from quiz: Quiz) {
        questionLabel.text = quiz.answer.front
        let randomNum = arc4random_uniform(4)
        var wrongSelections = quiz.otherSelections
        for index in 0...3 {
            if (index == randomNum) {
                selectionButtons[index].setTitle(quiz.answer.back, for: .normal)
            } else {
                selectionButtons[index].setTitle(wrongSelections[0].back, for: .normal)
                wrongSelections.removeFirst()
            }
        }
    }
    
    
    func setTextC(from quiz: Quiz) {
        questionLabelC.text = quiz.answer.front
        let randomNum = arc4random_uniform(4)
        var wrongSelections = quiz.otherSelections
        for index in 0...3 {
            if (index == randomNum) {
                selectionButtonsC[index].setTitle(quiz.answer.back, for: .normal)
            } else {
                selectionButtonsC[index].setTitle(wrongSelections[0].back, for: .normal)
                wrongSelections.removeFirst()
            }
        }
    }
    
    func slideQuestion(quizIndex: Int) -> Bool {
        if let nextQuiz = quizset!.quizes[safe: quizIndex] {
            //setTextC(from: nextQuiz)
            questionContainerCopy.center.x += 400
            questionContainerCopy.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: {
                //self.setTextC(from: nextQuiz)
                self.questionContainer.center.x -= 400
                self.questionContainerCopy.center.x -= 400
            }, completion: { _ in
                self.setText(from: nextQuiz)
                self.questionContainer.center.x += 400
                self.questionContainerCopy.isHidden = true
            })
            return true
        } else {
            return false
        }
    }

    @IBAction func selectionTapped(_ sender: UIButton) {
        quizIndex += 1
        let text = "test"
        questionLabelC.text = text//quizset!.quizes[quizIndex].answer.front
        //setTextC(from: quizset!.quizes[quizIndex])
        if !(slideQuestion(quizIndex: quizIndex)) {
            performSegue(withIdentifier: "toQuizDone", sender: self)
        }
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
