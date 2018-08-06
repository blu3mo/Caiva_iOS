//
//  QuizService.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/31.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import Foundation

struct QuizService {
    static func createQuizset(from cardset: Cardset, amount: Int) -> Quizset {
        let usingCards: [Card] = Array(cardset.cards.shuffled()[..<amount])
        var quizes: [Quiz] = []
        for usingCard in usingCards {
            let otherSelections: [Card] = Array(cardset.cards.filter{$0.uuid != usingCard.uuid}.shuffled()[..<3])
            let quiz = Quiz(answer: usingCard, otherSelections: otherSelections)
            quizes.append(quiz)
        }
        return Quizset(quizes: quizes)
    }
}
