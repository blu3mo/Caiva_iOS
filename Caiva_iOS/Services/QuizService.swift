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
    
    static func updateDegree(quiz: Quiz, wasCorrect: Bool) {
        if wasCorrect {
            let newValue = quiz.answer.degree + 0.1
            RealmHelper.setDegree(on: quiz.answer, value: newValue)
            for card in quiz.otherSelections {
                let newOtherValue = card.degree + 0.01
                RealmHelper.setDegree(on: card, value: newOtherValue)
            }
        } else {
            let newValue = quiz.answer.degree + ((quiz.answer.degree - 0.5) / -5)
            RealmHelper.setDegree(on: quiz.answer, value: newValue)
        }
    }
}
