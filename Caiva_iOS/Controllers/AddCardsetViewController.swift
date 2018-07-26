//
//  AddCardsetViewController.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/09.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit
//import Hero

class AddCardsetViewController: UIViewController {

    @IBOutlet weak var cardsetNameField: UITextField!
    @IBOutlet weak var cancelButton: GradientView!
    @IBOutlet weak var createButton: GradientView!
    @IBOutlet weak var nameWarning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameWarning.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createButtonTouchDowned(_ sender: Any) {
        createButton.shadowColor = UIColor(hexString: "000000", alpha: 0.15)!
    }
    

    @IBAction func createButtonTouchUpedOutside(_ sender: Any) {
        createButton.shadowColor = UIColor(hexString: "000000", alpha: 0.25)!
    }
    
    
    @IBAction func createButtonTapped(_ sender: Any) {
        createButton.shadowColor = UIColor(hexString: "000000", alpha: 0.25)!
        
        if cardsetNameField.text == "" {
            nameWarning.isHidden = false
            return
        }
        
        let newCardset = Cardset()
        newCardset.name = cardsetNameField.text!
        RealmHelper.addCardset(cardset: newCardset)
        
        performSegue(withIdentifier: "unwindSegueToHome", sender: self)
        //self.hero.modalAnimationType = .uncover(direction: HeroDefaultAnimationType.Direction.down)
        //dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTouchDowned(_ sender: Any) {
        cancelButton.shadowColor = UIColor(hexString: "000000", alpha: 0.13)!
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        cancelButton.shadowColor = UIColor(hexString: "000000", alpha: 0.20)!
        
        performSegue(withIdentifier: "unwindSegueToHome", sender: self)
        //self.hero.modalAnimationType = .uncover(direction: HeroDefaultAnimationType.Direction.down)
        //dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        cardsetNameField.resignFirstResponder()
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
