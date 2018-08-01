//
//  CalculationUtility.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/30.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import Foundation
struct Utility {
    static func getRowFromTag(tag: Int) -> Int {
        return Int((Double(tag) / 2.0))
    }
}
