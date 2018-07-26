//
//  CardsetInfoViewController.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/09.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit
//import Hero

class CardsetInfoViewController: UIViewController {

    var cardset: Cardset? = nil
    
    @IBOutlet weak var cardList: UITableView!
    @IBOutlet weak var tableBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardsetName: UILabel!
    @IBOutlet weak var cardsetAmount: UILabel!
    @IBOutlet weak var cardsetPerc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardsetName.text = cardset!.name
        cardsetAmount.text = String(cardset!.cards.count)
        cardsetPerc.text = "\(Int(cardset!.perc))%"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        //self.hero.modalAnimationType = .pull(direction: HeroDefaultAnimationType.Direction.right)
        performSegue(withIdentifier: "unwindToHomeFromCardsetInfo", sender: self)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableBottomConstraint.constant = -1*(keyboardSize.height)
            //cardList.frame.size.height -= keyboardSize.height
            UIView.animate(withDuration: 0.2, animations: {
                self.cardList.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //cardList.frame.size.height += 513
            tableBottomConstraint.constant = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.cardList.layoutIfNeeded()
            })
        }
    }
}

extension CardsetInfoViewController: UITableViewDelegate {
    
}

extension CardsetInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardList.dequeueReusableCell(withIdentifier: "card")! as! CardsetInfoCardCell
        cell.frontTextField.delegate = self
        cell.frontTextField.tag = (indexPath.row + 1) * 2 - 1
        cell.backTextField.delegate = self
        cell.backTextField.tag = (indexPath.row + 1) * 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension CardsetInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let nextTag = textField.tag + 1
        if let nextTextField = self.view.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}
