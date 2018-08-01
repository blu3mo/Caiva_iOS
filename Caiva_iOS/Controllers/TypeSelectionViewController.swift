//
//  TypeSelectionViewController.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/08/01.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit

class TypeSelectionViewController: UIViewController {

    @IBOutlet weak var ASTitle: UILabel!
    @IBOutlet weak var ASDescription: UILabel!
    @IBOutlet weak var AOTitle: UILabel!
    @IBOutlet weak var AODescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ASTitle.fitTextToBounds()
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
