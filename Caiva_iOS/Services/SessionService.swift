//
//  AudioService.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/08/05.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import Foundation
typealias UUIDString = String

struct SessionService {
    
    static var lastCard: Card = Card()
    
    static func createAudioResource(from cardset: Cardset) -> [(String, Double, UUIDString)] {
        var audioResource: [(String, Double, UUIDString)] = []
        let cards = cardset.cards
        var pickingCard: [Card] = []
        cards.forEach { (card) in
            let multiplier = Int(10 - (card.degree * 10)/1.5 + 2)
            print(multiplier)
            print(card.front)
            for i in 1...multiplier {
                pickingCard.append(card)
            }
        }
        for i in 1...20 {
            pickingCard.shuffle()
            var usingCard = pickingCard.first!
            if usingCard == lastCard {
                usingCard = pickingCard[1]
            }
            audioResource.append((usingCard.front, 1.5, usingCard.uuid))
            audioResource.append((usingCard.back, 3, usingCard.uuid))
            
            lastCard = usingCard
        }
        
        return audioResource
    }
    
    static func setDegree(of card: Card) {
        
    }
    
}

enum SessionType {
    case audioOnly
    case audioAndScreen
}
