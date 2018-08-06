//
//  TestStartViewController.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/08/01.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit
//import Hero

class QuizStartViewController: UIViewController {

    var cardset: Cardset?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuizQuestion" {
            let nextVC = segue.destination as! QuizQuestionViewController
            nextVC.quizset = QuizService.createQuizset(from: cardset!, amount: 4)
        }
    }
    
    @IBAction func quizStartButtonTapped(_ sender: Any) {
        
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
