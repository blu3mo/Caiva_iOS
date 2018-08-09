//
//  CalculationUtility.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/30.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import Foundation
struct Util {
    
    static func getRowFromTag(tag: Int) -> Int {
        return Int((Double(tag) / 2.0))
    }
    
    static func doAfterDelay(seconds: Double, process: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            process()
        }
    }
    
    static func getTimeText(from time: Int) -> String {
        var timeUnits = (time / 3600, (time % 3600) / 60, (time % 3600) % 60)
        var timeText = ""
        if timeUnits.0 != 0 {
            timeText += "\(timeUnits.0)h "
        }
        if timeUnits.1 != 0 {
            timeText += "\(timeUnits.1)m "
        }
        if timeUnits.2 != 0 {
            timeText += "\(timeUnits.2)s "
        }
        if timeText == "" {
            timeText = "0s"
        }
        return timeText
    }
}
