//
//  CardsetInfoPlusButtonCell.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/27.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit

class CardsetInfoPlusButtonCell: UITableViewCell {

    @IBOutlet weak var plusButton: UIButton!
    
    weak var delegate: CardsetInfoPlusButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func plusButtonTapped(_ sender: UIButton) {
        delegate?.didTapButton(sender, on: self)
    }
    
}

protocol CardsetInfoPlusButtonCellDelegate: class {
    func didTapButton(_ button: UIButton, on cell: CardsetInfoPlusButtonCell)
}
