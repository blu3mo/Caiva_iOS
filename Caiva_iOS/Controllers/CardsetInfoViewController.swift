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
        cardsetAmount.text = "\(cardset!.cards.count) cards"
        cardsetPerc.text = "\(Int(cardset!.perc))%"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

        // Dispose of any resources that can be recreated.
    }

    @IBAction func startSessionButtonTapped(_ sender: Any) {
        SpeechHelper.shared.speak(text: "hello abc あいうえお　今日はいい天気　薔薇", voiceType: .standardJapanese) {
            
        }
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
        cardsetAmount.text = "\(cardset!.cards.count) cards"
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
}

extension CardsetInfoViewController: UITableViewDelegate {
    
}

extension CardsetInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cardset!.cards.count// + 1
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {//cardset!.cards.count {
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
        
        cell.frontTextField.text = cardset?.cards[indexPath.row].front
        cell.backTextField.text = cardset?.cards[indexPath.row].back
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
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
        let nextRow = Utility.getRowFromTag(tag: nextTag)
        
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
