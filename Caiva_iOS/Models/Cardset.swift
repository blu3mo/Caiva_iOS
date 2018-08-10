//
//  Cardset.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/05.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Cardset: Object {
    static var currentCardset: Cardset? = nil
    
    @objc dynamic var name = ""
    @objc dynamic var perc: Double {
        get {
            if cards.count == 0 {
                return 0.1
            }
            var newPerc = 0.0
            for card in cards {
                if card.degree <= 1 {
                    newPerc += card.degree
                } else {
                    newPerc += 1
                }
            }
            newPerc /= Double(cards.count)
            return newPerc
        }
    }
    var showingPerc: Double {
        get {
            return (perc * (10/9) - (1/9) )
        }
    }
    var cards = List<Card>()
    
    @objc dynamic var modificationTime = NSDate()
}
