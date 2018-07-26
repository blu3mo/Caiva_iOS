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
    @objc dynamic var name = ""
    @objc dynamic var perc = 0.0
    var cards = List<Card>()
    
    @objc dynamic var modificationTime = NSDate()
}
