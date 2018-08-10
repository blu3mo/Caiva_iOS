//
//  QuizResultViewController.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/08/03.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit

class QuizResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var growthLabel: UILabel!
    
    var result: String = ""
    var initialPerc = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = result
        let currentPerc = Cardset.currentCardset!.showingPerc
        progressLabel.text = "\(Int(currentPerc * 100))%"
        let growth = Int((currentPerc - initialPerc) * 100)
        if growth >= 0 {
            growthLabel.text = "+\(growth)%"
        } else {
            growthLabel.text = "\(growth)%"
        }
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
