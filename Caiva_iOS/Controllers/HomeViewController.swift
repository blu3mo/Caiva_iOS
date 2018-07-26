//
//  ViewController.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/02.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit
//import Hero
import RealmSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var addCardsetButton: GradientView!
    @IBOutlet weak var cardsetTableView: UITableView!
    //@IBOutlet weak var newCardsetButton: GradientView!
    
    var cardsets: [Cardset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        cardsets = Array(RealmHelper.retrieveCardsets())
        cardsetTableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addCardsetButtonTouchDowned(_ sender: Any) {
        addCardsetButton.shadowColor = UIColor(hexString: "000000", alpha: 0.2)!
    }
    
    @IBAction func addCardsetButtonTouchUpedOutside(_ sender: Any) {
        addCardsetButton.shadowColor = UIColor(hexString: "000000", alpha: 0.3)!
    }
    @IBAction func addCardsetButtonTapped(_ sender: Any) {
        addCardsetButton.shadowColor = UIColor(hexString: "000000", alpha: 0.3)!
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) { }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cardsets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sec = indexPath.section
        print(indexPath.row)
        switch indexPath.row {
        case 0:
            let cell = cardsetTableView.dequeueReusableCell(withIdentifier: "HomeBlankCell")
            return cell!
        case 1:
            let cell = cardsetTableView.dequeueReusableCell(withIdentifier: "HomeCardsetCell") as! HomeCardsetCell
            
            let cardset = cardsets[sec]
            cell.setText(nameData: cardset.name, amountData: cardset.cards.count, percData: cardset.perc)
            return cell
        default:
            print("ERROR: Unexpected indexPath")
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            if indexPath.section == 0 {
                return CGFloat(5)
            } else {
                return CGFloat(0)
            }
        case 1:
            return CGFloat(95)//100)
        default:
            return CGFloat(0)
        }
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let selectedCell = tableView.cellForRow(at: indexPath) as! HomeCardsetCell
            selectedCell.boxView.borderColor = UIColor(hexString: "D7B4DB")!
            selectedCell.boxView.borderWidth = CGFloat(3.0)
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let selectedCell = tableView.cellForRow(at: indexPath) as! HomeCardsetCell
            selectedCell.boxView.borderColor = UIColor(hexString: "E9E9E9")!
            selectedCell.boxView.borderWidth = CGFloat(2.0)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "cardsetInfo") as! CardsetInfoViewController
        nextVC.cardset = self.cardsets[indexPath.section]

        show(nextVC, sender: self)
        //present(nextVC, animated: true, completion: )
        //performSegue(withIdentifier: "showCardsetInfo", sender: self)
    }
}
