//
//  SessionResultViewController.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/08/06.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit

class SessionResultViewController: UIViewController {

    var timeString = ""
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeLabel.text = timeString
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toQuiz" {
//            
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
