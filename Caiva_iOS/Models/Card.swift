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
    var front: String = "NO_DATA"
    var back: String = "NO_DATA"
    var degree: Double = 0.0
}
