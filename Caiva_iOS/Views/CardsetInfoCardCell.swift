//
//  CardsetInfoCardCell.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/26.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit

class CardsetInfoCardCell: UITableViewCell {

    @IBOutlet weak var frontBoxView: GradientView!
    @IBOutlet weak var backBoxView: GradientView!
    @IBOutlet weak var frontTextField: UITextField!
    @IBOutlet weak var backTextField: UITextField!
    
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

}
