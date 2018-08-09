//
//  CardsetInfoViewController.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/09.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit
//import Hero
import TapticEngine
import Realm
import RealmSwift
import AlertHelperKit
import AVFoundation

class CardsetInfoViewController: UIViewController {

    var cardset: Cardset? = nil
    
    @IBOutlet weak var cardList: UITableView!
    @IBOutlet weak var tableBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardsetName: UILabel!
    @IBOutlet weak var cardsetAmount: UILabel!
    @IBOutlet weak var cardsetPerc: UILabel!
    @IBOutlet weak var sessionStartButtonView: GradientView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardset = Cardset.currentCardset!
        
        cardsetName.text = cardset!.name
        cardsetAmount.text = "\(cardset!.cards.count) cards"
        cardsetPerc.text = "\(Int(cardset!.perc * 100))%"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        updateValues()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        cardsetPerc.text = "\(Int(cardset!.perc * 100))%"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toSession" {
            if cardset!.cards.count < 4 {
                AlertHelperKit().showAlert(self, title: "Can not start session", message: "You need 4+ cards", button: "OK")
                return false
            }
        }
        if identifier == "toQuiz" {
            if cardset!.cards.count < 4 {
                AlertHelperKit().showAlert(self, title: "Can not start quiz", message: "You need 4+ cards", button: "OK")
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toSession" {
//            let nextVC = segue.destination as! QuizStartViewController
//            nextVC.cardset = cardset
//        }
    }

    @IBAction func startSessionButtonTapped(_ sender: Any) {
        
    }
    
    func addCard() {
        try! Realm().write {
            cardset!.cards.append(Card())
        }
        view.endEditing(false)
        //cardList.reloadData()
        cardList.beginUpdates()
        cardList.insertRows(at: [IndexPath(row: cardset!.cards.count - 1, section: 0)], with: .automatic)
        cardList.endUpdates()
        //cardList.reloadRows(at: [IndexPath(row: (cardset?.cards.count)!, section: 0)], with: .fade)
        updateValues()
    }
    
    func updateValues() {
        cardsetAmount.text = "\(cardset!.cards.count) cards"
        if cardset!.cards.count < 4 {
            sessionStartButtonView.topColor = sessionStartButtonView.topColor.withAlphaComponent(0)
            sessionStartButtonView.bottomColor = sessionStartButtonView.bottomColor.withAlphaComponent(0)
        } else {
            sessionStartButtonView.topColor = sessionStartButtonView.topColor.withAlphaComponent(1.0)
            sessionStartButtonView.bottomColor = sessionStartButtonView.bottomColor.withAlphaComponent(1.0)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        //self.hero.modalAnimationType = .pull(direction: HeroDefaultAnimationType.Direction.right)
        performSegue(withIdentifier: "unwindToHomeFromCardsetInfo", sender: self)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        //print(AVPlayer().volume)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableBottomConstraint.constant = keyboardSize.height
            //cardList.frame.size.height -= keyboardSize.height
            UIView.animate(withDuration: 0.2, animations: {
                self.cardList.setNeedsLayout()
            })
            
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //cardList.frame.size.height += 513
            tableBottomConstraint.constant = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.cardList.setNeedsLayout()
            })
        }
    }
    
     @IBAction func unwindToCardsetInfo(segue: UIStoryboardSegue) {
    }
}

extension CardsetInfoViewController: UITableViewDelegate {
    
}

extension CardsetInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cardset!.cards.count// + 1
        } else {
            return 2
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {//cardset!.cards.count {
            if indexPath.row == 1 { //spacing
                let blankCell = cardList.dequeueReusableCell(withIdentifier: "blankCell")!
                return blankCell
            }
            let buttonCell = cardList.dequeueReusableCell(withIdentifier: "plusButton")! as! CardsetInfoPlusButtonCell
            buttonCell.delegate = self
            return buttonCell
        }
        let cell = cardList.dequeueReusableCell(withIdentifier: "card")! as! CardsetInfoCardCell
        cell.frontTextField.delegate = self
        cell.frontTextField.tag = (indexPath.row) * 2
        cell.backTextField.delegate = self
        cell.backTextField.tag = (indexPath.row) * 2 + 1
        cell.delegate = self
        
        cell.frontTextField.text = cardset!.cards[indexPath.row].front
        cell.backTextField.text = cardset!.cards[indexPath.row].back
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if indexPath.row == 1 { //spacing
                return 110
            }
            return 60
        }
        return 110
    }
    
}

extension CardsetInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TapticEngine.impact.prepare(.light)
        textField.resignFirstResponder()
        
        let nextTag = textField.tag + 1 //get next textField tag
        let nextRow = Util.getRowFromTag(tag: nextTag)
        
        if let nextTextField = self.view.viewWithTag(nextTag) {
            if cardList.numberOfRows(inSection: 0) >= nextRow { //check if the next row with textfield exists
                TapticEngine.impact.feedback(.light)
            } else {
                addCard()
                TapticEngine.impact.feedback(.medium)
            }
            self.cardList.scrollToRow(at: IndexPath.init(row: nextRow, section: 0), at: UITableViewScrollPosition.bottom, animated: true)
            nextTextField.becomeFirstResponder()
        } else {
            addCard()
            self.cardList.scrollToRow(at: IndexPath.init(row: nextRow, section: 0), at: UITableViewScrollPosition.bottom, animated: true)
            self.view.viewWithTag(nextTag)?.becomeFirstResponder()
        }
        
        return true
    }
}

extension CardsetInfoViewController: CardsetInfoPlusButtonCellDelegate {
    func didTapButton(_ followButton: UIButton, on cell: CardsetInfoPlusButtonCell) {
        addCard()
        cardList.scrollToRow(at: IndexPath.init(row: 1, section: 1), at: UITableViewScrollPosition.bottom, animated: true)
    }
}

extension CardsetInfoViewController: CardsetInfoCardCellDelegate {
    func textFieldTapped(indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(20)) {
            if self.cardset!.cards.count > indexPath.row + 1 {
                self.cardList.scrollToRow(at: IndexPath(row: indexPath.row + 1, section: 0), at: UITableViewScrollPosition.bottom, animated: true)
            } else if self.cardset!.cards.count > indexPath.row {
                self.cardList.scrollToRow(at: IndexPath(row: 0, section: 1), at: UITableViewScrollPosition.bottom, animated: true)
            }
        }
    }
    
    func textFieldEditEnded(indexPath: IndexPath, front: String, back: String) {
        //cardset!.cards[indexPath.row].front = "aaa"
        RealmHelper.setCard(on: cardset!, card: cardset!.cards[indexPath.row], front: front, back: back)
        //cardList.reloadData()
    }
    
}
