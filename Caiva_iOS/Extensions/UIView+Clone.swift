//
//  UIView+Clone.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/08/03.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import UIKit

extension UIView{
    func clone() -> UIView{
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
    }
}
