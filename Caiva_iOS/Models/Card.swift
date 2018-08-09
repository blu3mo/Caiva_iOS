//
//  Card.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/06.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Card: Object {
    @objc dynamic var front: String = ""
    @objc dynamic var back: String = ""
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var degree: Double = 0.1
    @objc dynamic var colorID: Int = Int(arc4random_uniform(20)) //0 - 19
}
