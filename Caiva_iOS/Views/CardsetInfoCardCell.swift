//
//  CardsetInfoCardCell.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/26.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class CardsetInfoCardCell: MGSwipeTableCell {

    @IBOutlet weak var frontBoxView: GradientView!
    @IBOutlet weak var backBoxView: GradientView!
    @IBOutlet weak var frontTextField: UITextField!
    @IBOutlet weak var backTextField: UITextField!
    
    weak var myDelegate: CardsetInfoCardCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        frontBoxView.round(corners: [.topLeft, .topRight], radius: 5.0, borderColor: UIColor(hexString: "E9E9E9")!, borderWidth: 3)
        backBoxView.round(corners: [.bottomLeft, .bottomRight], radius: 5.0, borderColor: UIColor(hexString: "E9E9E9")!, borderWidth: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func frontTextFieldEditEnded(_ sender: Any) {
        myDelegate?.textFieldEditEnded(indexPath: IndexPath.init(row: Util.getRowFromTag(tag: backTextField.tag), section: 0), front: frontTextField.text!, back: backTextField.text!)
    }
    @IBAction func backTextFieldEditEnded(_ sender: Any) {
        myDelegate?.textFieldEditEnded(indexPath: IndexPath.init(row: Util.getRowFromTag(tag: backTextField.tag), section: 0), front: frontTextField.text!, back: backTextField.text!)
    }
    
    @IBAction func textFieldTapped(_ sender: UITextField) {
        myDelegate?.textFieldTapped(indexPath: IndexPath.init(row: Util.getRowFromTag(tag: sender.tag), section: 0))
    }
    
}

protocol CardsetInfoCardCellDelegate: class {
    func textFieldEditEnded(indexPath: IndexPath, front: String, back: String)
    func textFieldTapped(indexPath: IndexPath)
}
