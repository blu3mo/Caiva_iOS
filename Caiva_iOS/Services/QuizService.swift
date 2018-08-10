//
//  QuizService.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/07/31.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import Foundation

struct QuizService {
    
    static var lastCard = Card()
    
    static func createQuizset(from cardset: Cardset) -> Quizset {
        var amount = Int((Double(cardset.cards.count) * (5/8)) + 3.75)
        
        if cardset.cards.count < amount {
            amount = cardset.cards.count
        }
        
        let cards = cardset.cards
        var pickingCards: [Card] = []
        cards.forEach { (card) in
            let multiplier = Int(10 - (card.degree * 10)/1.5 + 2)
            for _ in 1...multiplier {
                pickingCards.append(card)
            }
        }
        
        var quizes: [Quiz] = []
        for _ in 1...amount {
            pickingCards.shuffle()
            var usingCard = pickingCards.first
            if usingCard == lastCard {
                usingCard = pickingCards[1]
            }
            lastCard = usingCard!
            
            let otherSelections: [Card] = Array(cards.filter{$0.uuid != usingCard!.uuid}.shuffled()[..<3])
            let quiz = Quiz(answer: usingCard!, otherSelections: otherSelections)
            quizes.append(quiz)
        }
            
//            let otherSelections: [Card] = Array(cardset.cards.filter{$0.uuid != usingCard.uuid}.shuffled()[..<3])
//            let quiz = Quiz(answer: usingCard, otherSelections: otherSelections)
//            quizes.append(quiz)
        return Quizset(quizes: quizes)
    }
    
    static func updateDegree(quiz: Quiz, wasCorrect: Bool) {
        if wasCorrect {
            let newValue = quiz.answer.degree + ((1.2 - quiz.answer.degree) / 10)
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
