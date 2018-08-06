//
//  Quiz.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/08/02.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

class Quiz {
    var answer: Card
    var otherSelections: [Card]
    init(answer: Card, otherSelections: [Card]) {
        self.answer = answer
        self.otherSelections = otherSelections
    }
}
