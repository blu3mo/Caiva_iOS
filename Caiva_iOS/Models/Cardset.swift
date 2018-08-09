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
            var newPerc = 0.0
            for card in cards {
                newPerc += card.degree
            }
            newPerc /= Double(cards.count)
            return newPerc
        }
    }
    var cards = List<Card>()
    
    @objc dynamic var modificationTime = NSDate()
}
